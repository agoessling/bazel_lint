"""This is a Bazel aspect for running pylint on python targets.

Note that in order to make this work we have to manually stick all the needed inputs into
the run action and then in the wrapper add the paths manually. This is better than having a
macro that creates a test per target but not perfect.
"""

def _run_pylint(ctx, rc, pylint, infile, target):
    """Run pylint on a single target."""
    inputs = depset(
        direct = (
            [infile, rc] + target.output_groups.compilation_outputs.to_list()
        ),
    )

    # Declare an output json file for the pylint results
    outfile = ctx.actions.declare_file(
        "bazel_pylint_" + infile.path + "." + target.label.name + ".pylint.json"
    )

    args = [
        infile.path,
        "--rcfile",
        rc.path,
        "--output-format=json:{},colorized".format(outfile.path),
        "--bazel-imports",
    ] + target[PyInfo].imports.to_list()

    ctx.actions.run(
        inputs = inputs,
        outputs = [outfile],
        executable = pylint.files_to_run,
        arguments = args,
        mnemonic = "Pylint",
        use_default_shell_env = True,
        progress_message = "Run pylint on {}".format(infile.short_path),
    )

    return outfile

def _get_sources(ctx):
    """Return the sources for the aspect."""

    def check_valid_file_type(src):
        """
        Returns True if the file type matches one of the permitted srcs file types for C and C++ header/source files.
        """
        permitted_file_types = [
            ".py",
        ]
        for file_type in permitted_file_types:
            if src.basename.endswith(file_type):
                return True
        return False

    srcs = []
    if hasattr(ctx.rule.attr, "srcs"):
        for src in ctx.rule.attr.srcs:
            srcs += [src for src in src.files.to_list() if src.is_source and check_valid_file_type(src)]
    return srcs

def _pylint_aspect_impl(target, ctx):
    """The implementation of the aspect."""

    # if not a python target, we are not interested
    if not PyInfo in target:
        return []

    # Ignore external targets
    if target.label.workspace_root.startswith("external"):
        return []

    # Ignore anything with the no-pylint tag
    if "no-pylint" in ctx.rule.attr.tags:
        return []

    outputs = [
        _run_pylint(
            ctx,
            ctx.attr._pylintrc.files.to_list()[0],
            ctx.attr._pylint,
            src,
            target,
        )
        for src in _get_sources(ctx)
    ]

    return [
        OutputGroupInfo(report = depset(direct = outputs)),
    ]

pylint_aspect = aspect(
    implementation = _pylint_aspect_impl,
    fragments = ["python"],
    attrs = {
        "_pylint": attr.label(default = Label("@bazel_lint//python:pylint")),
        "_pylintrc": attr.label(default = Label("//:pylintrc")),
    },
)
