import re
from cmaketools import setup
from multiprocessing import cpu_count
from os import path


def get_long_description():
    try:
        dir_path = path.dirname(path.realpath(__file__))
        with open(path.join(dir_path, "README.md"), encoding="utf-8") as readme_file:
            return readme_file.read()

    except Exception:
        raise RuntimeError("Package description retrieval failed. "
                           "Most probably something is wrong with this code and "
                           "you should create an issue at https://github.com/mwydmuch/napkinXC")


def get_version():
    try:
        dir_path = path.dirname(path.realpath(__file__))
        with open(path.join(dir_path, "CMakeLists.txt")) as cmake_file:
            lines = cmake_file.read()
            version = re.search('VERSION\s+([0-9].[0-9].[0-9]+)', lines).group(1)
            return version

    except Exception:
        raise RuntimeError("Package version retrieval failed. "
                           "Most probably something is wrong with this code and "
                           "you should create an issue at https://github.com/mwydmuch/napkinXC")


setup(
    name="napkinxc",
    version=get_version(),
    author="Marek Wydmuch",
    author_email="mwydmuch@cs.put.poznan.pl",
    description="napkinXC is an extremely simple and fast library for extreme multi-class and multi-label classification.",
    long_description_content_type="text/markdown",
    long_description=get_long_description(),
    url="https://github.com/mwydmuch/napkinXC",
    keywords=['machine learning', 'extreme classification', 'multi-class classification', 'multi-label classification', 'classification'],
    classifiers=[
        'Development Status :: 4 - Beta',
        #Development Status :: 5 - Production/Stable,
        'Operating System :: POSIX :: Linux',
        'Operating System :: MacOS',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'Topic :: Scientific/Engineering :: Artificial Intelligence',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
    ],
    license="MIT License",
    platforms=["Linux", "MacOS"],
    src_dir=".",
    packages=['napkinxc'],
    package_dir={'napkinxc': 'dist/napkinxc'},
    package_data={'napkinxc': ['*.py', '*.so']},
    #ext_module_dirs=['python'],
    ext_module_hint=r"pybind11_add_module",
    configure_opts=['-DPYTHON=ON', '-DEXE=OFF'],
    #parallel=max(cpu_count(), 1) # Unknown distribution option: 'parallel'
)
