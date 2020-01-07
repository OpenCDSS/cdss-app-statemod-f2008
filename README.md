# cdss-app-statemod-f2008 #

CDSS prototype of StateMod written in object-oriented Fortran

* [Introduction](#introduction)
* [Repository Contents](#repository-contents)
* [Development Environment Setup](#development-environment-setup)
* [Compiling Prototype](#compiling-prototype)
* [Running Prototype](#running-prototype)
* [Contributing](#contributing)
* [Maintainers](#maintainers)
* [License](#license)
* [Contact](#contact)

-------------------

## Introduction ## 

The code in this repository was ported from Java and legacy Fortran code
to evaluate which programming language(s) may be suitable for
converting the StateMod software from Fortran to another language.
This prototype focuses on reading the diversion station (`*.dds`) file.

The main repositories for StateMod language evaluation prototypes are:

* Java:  this repository
* C#:  [cdss-app-statemod-cs](https://github.com/OpenCDSS/cdss-app-statemod-cs) 
* Fortran 2008:  [cdss-app-statemod-f2008](https://github.com/OpenCDSS/cdss-app-statemod-f2008) 
* Python:  [cdss-app-statemod-python](https://github.com/OpenCDSS/cdss-app-statemod-java)

## Repository Contents ##

The following folder structure is recommended for development.
Top-level folders should be created as necessary.
The following folder structure clearly separates user files (as per operating system),
development area (`cdss-dev`), product (`StateMod-f2008`), repositories for product (`git-repos`),
and specific repositories for the product.
Repository folder names should agree with GitHub repository names.
Scripts in repository folders that process data should detect their starting location
and then locate other folders based on the following convention.

See [Development Environment Setup](#development-environment-setup) below to easily download all repositories to a local environment.

```
C:\Users\user\                                 User's home folder for Windows.
/c/Users/user/                                 User's home folder for Git Bash.
/cygdrive/C/Users/user/                        User's home folder for Cygwin.
/home/user/                                    User's home folder for Linux.
  owf-cdss/                                    Projects that are part of Colorado's Decision Support Systems.
    StateMod-f2008/                            StateMod Fortran 2008 product folder.
                                               (name of this folder is not critical).
      ---- below here folder names should match exactly ----
      git-repos/                               Git repositories for the StateMod Fortran application.
        cdss-app-statemod-f2008/               Statemod Fortran main application code (this repo).
```

This repository contains the following:
```
cdss-app-statemod-f2008
  .git/                                        Standard Git folder for repository (DO NOT MODIFY).
  .gitattributes/                              Standard Git configuration file for repository (for portability).
  .gitignore/                                  Standard Git configuration file to ignore dynamic working files.
  build-util/                                  Scripts to help in the StateMod Fortran development environment.
  src/                                         StateMod source code.
  test/
    datasets/
      cdss-ym2015/                             Tests for StateMod application - Yampa dataset input files.
  README.md                                    This file.
  LICENSE.md                                   StateMod Fortran license file.
```

## Development Environment Setup ##

The following instructions explain how to set up the StateMod Fortran development environment on Windows.
It is assumed that Git for Windows has been installed.  Git Bash will be used for some steps.

To set up the development environment follow the normal
[StateMod Development Manual](http://opencdss.state.co.us/statemod/latest/doc-dev/).
Use `make` and `gfortran` compiler to compile the code in this repository.

## Compiling

To compile the prototype:

1. Open a Windows Command prompt.
2. `cd` to the `build-util/mingw` folder.
3. Run the `setup-mingw-env.bat` batch file to configure the environment.
4. `cd` to the `src` folder.
5. Run `make` to see options.  Run `make statemod` to compile the executable.

## Running Prototype ##

To run the prototype, use a Git Bash window or Windows Command shell and run the
`statemod-oo-gfortran-win-32bit.exe` program in the `src` folder.
This will run the prototype executable process fabricated data.

## Contributing ##

Contributions to this project can be submitted using the following options:

1. StateMod object-oriented Fortran software developers with commit privileges can write to this repository
    as per normal OpenCDSS development protocols.
2. Post an issue on GitHub with suggested change.  Provide information using the issue template.
3. Fork the repository, make changes, and do a pull request.
    Contents of the current master branch should be merged with the fork to minimize
    code review before committing the pull request.

See also the [OpenCDSS / StateMod protocols](http://opencdss.state.co.us/opencdss/statemod/)

## License ##

Copyright Colorado Department of Natural Resources.

The software is licensed under GPL v3+. See the [LICENSE.md](LICENSE.md) file.

## Contact ##

See the [OpenCDSS StateMod information for product contacts](http://opencdss.state.co.us/opencdss/statemod/#software-developers).
