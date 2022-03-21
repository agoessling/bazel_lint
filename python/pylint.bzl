load("@rules_python//python:defs.bzl", "py_test")

def pylint_test(name, srcs, rcfile=None, extra_args=None, visibility=None):
    if rcfile == None:
        rc_args = []
    else:
        rc_args = ["--rcfile", "$(rootpath {})".format(rcfile)]

    if extra_args == None:
        extra_args = []

    py_test(
        name = name,
        srcs = ["@//python:pylint"],
        main = "pylint_wrapper.py",
        data = srcs + ([rcfile] if rcfile else []),
        args = rc_args + ["$(rootpath {})".format(x) for x in srcs] + extra_args,
        visibility = visibility,
        deps = [
            "@//python:pylint",
        ],
    )
