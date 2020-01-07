# Makefile for compiling StateMod object oriented version using gfortran
#
# See:  https://stackoverflow.com/questions/35234003/how-to-create-a-makefile-for-a-fortran-program-using-modules

# Find all source files, create a list of corresponding object files
SRCS=$(wildcard *.f90)
OBJS=$(patsubst %.f90,%.o,$(SRCS))

# Find all module files, which when processed will result in a corresponding .mod file.
# - these are files that have class_ at the front of the name
# - the module and file name must match for the following pattern to work
MODS=$(wildcard class*.f90)
MOD_OBJS=$(patsubst %.f90,%.o,$(MODS))

# ======================================================================
# Declarations
# ======================================================================
# The compiler
FC = gfortran
# Determine the StateMod version
# - used in the executable name
# - also used for installer upload folder, etc.
# - "dev" at the end of the version (e.g., 15.00.14dev) indicates the software is under development
#STATEMOD_VERSION := $(shell cat statem.for | grep 'ver =' | grep -v 'xx' | cut -d '=' -f 2 | sed "s/'//g" | tr -d ' ' )
STATEMOD_VERSION = oo
# The flags for debugging or for maximum performance, comment as necessary

# -cpp
#
# Enable preprocessing. The preprocessor is automatically invoked if the file extension is
# .fpp, .FPP, .F, .FOR, .FTN, .F90, .F95, .F03 or .F08. Use this option to manually enable
# preprocessing of any kind of Fortran file.
#
# To disable preprocessing of files with any of the above listed extensions, use the negative form: -nocpp.
#
# The preprocessor is run in traditional mode. Any restrictions of the file-format,
# especially the limits on line length, apply for preprocessed output as well, so it might be
# advisable to use the -ffree-line-length-none or -ffixed-line-length-none options.
#-------------------------------------------------------------------------------------------------------
# See compiler options here:  https://gcc.gnu.org/onlinedocs/gfortran/#toc-GNU-Fortran-Command-Options
#-------------------------------------------------------------------------------------------------------
#
# -fcheck=bounds
# -fbounds-check (this is deprecated in favor of -fcheck=bounds)
#
# Enable generation of run-time checks for array subscripts and against the declared
# minimum and maximum values. It also checks array indices for assumed and deferred
# shape arrays against the actual allocated bounds and ensures that all string lengths
# are equal for character array constructors without an explicit typespec.
#
# Some checks require that -fcheck=bounds is set for the compilation of the main program.
#
# Note: In the future this may also include other forms of checking, e.g., checking substring references.
#------------
#
# -finit-local-zero
#
# ALWAYS INCLUDE.
# The -finit-local-zero option instructs the compiler to initialize local INTEGER, REAL,
# and COMPLEX variables to zero, LOGICAL variables to false, and CHARACTER variables to a string of null bytes
#------------
#
# -fno-align-commons
#
# ALWAYS INCLUDE.
# By default, gfortran enforces proper alignment of all variables in a COMMON block
# by padding them as needed. On certain platforms this is mandatory, on others it
# increases performance. If a COMMON block is not declared with consistent data types
# everywhere, this padding can cause trouble, and -fno-align-commons can be used to
# disable automatic alignment. The same form of this option should be used for all
# files that share a COMMON block. To avoid potential alignment issues in COMMON blocks,
# it is recommended to order objects from largest to smallest.
#------------
#
# -fno-automatic
#
# ALWAYS INCLUDE.
# Treat each program unit (except those marked as RECURSIVE) as if the SAVE statement were
# specified for every local variable and array referenced in it. Does not affect common blocks.
# (Some Fortran compilers provide this option under the name -static or -save.)
# The default, which is -fautomatic, uses the stack for local variables smaller than the value
# given by -fmax-stack-var-size. Use the option -frecursive to use no static memory.
#------------
#
# -g 
#
# ALWAYS INCLUDE.
#------------
#
# -static
#
# ALWAYS INCLUDE.
#------------

#FFLAGS = -g -fbounds-check -fno-align-commons
# use -static especially for windows compiling 
#FFLAGS = -g -cpp -fbounds-check -fno-align-commons -static
# Extra checks that can be added for deep check of code logic
# - Steve Malers added to track down remaining issues
FCFLAGS_EXTRA_CHECKS=-fcheck=do,mem,pointer

# Compiler options
#FCFLAGS = -g -fno-align-commons -fcheck=bounds -fno-automatic -finit-local-zero $(FCFLAGS_EXTRA_CHECKS)
FCFLAGS = -g -c -Wall -Wextra -Wconversion -Og -pedantic -fcheck=bounds

#FFLAGS = -O2
# The flags for all cases (e.g. look for system .mod files, required in gfortran)
#FFLAGS += -I/usr/include

# Linker flags
# -static is not used by gfortran
FLFLAGS = -g -static

# The libraries needed for linking
#LDFLAGS = -li_need_this_lib
# The list of executables to be built within the package
PROGRAM = statemod
PRG_OBJ = $(PROGRAM).o

# ======================================================================
# Main targets
# ======================================================================

# all: compile all programs
# - the default if make is called without arguments
# - may want to change so default is 'help'
#all: printenv $(PROGRAMS)
all: help

# help: print the targets that are available
# @echo "STATEMOD_VERSION (from statem.for) = $(STATEMOD_VERSION)"
help:
	@echo "--------------------------------------------------------------------------------"
	@echo "StateMod makefile targets:"
	@echo ""
	@echo "all        Default target that prints this help message."
	@echo "clean      Remove dynamically created files (but not final executable)."
	@echo "debug      Print important variables."
	@echo "help       Print this message."
	@echo "statemod   Compile the StateMod executable, recompiling any .o if .for modified."
	@echo "veryclean  Make the 'clean' target, and also remove the final executable."
	@echo ""
	@echo "file.o     Compile the source file.for file into object file file.o,"
	@echo "           useful to check syntax for a single file."
	@echo ""
	@echo "To do a dry run:  make -n statemod"
	@echo "To do verbose make:  make --debug=v statemod"
	@echo "--------------------------------------------------------------------------------"
	@echo "Important makefile variables that are used:"
	@echo ""
	@echo "FC (compiler) = $(FC)"
	@echo "STATEMOD_VERSION = $(STATEMOD_VERSION)"
	@echo "--------------------------------------------------------------------------------"
	@echo "Important environment variables that are used:"
	@echo ""
	@echo "OS (to determine operating system) = $(OS)"
	@echo "--------------------------------------------------------------------------------"

# If something doesn't work right, have a 'make debug' to
# show what each variable contains.
debug:
	@echo "SRCS = $(SRCS)"
	@echo "OBJS = $(OBJS)"
	@echo "MODS = $(MODS)"
	@echo "MOD_OBJS = $(MOD_OBJS)"
	@echo "PROGRAM = $(PROGRAM)"
	@echo "PRG_OBJ = $(PRG_OBJ)"

# Dependencies for object files
# - because statemod is the main output (not library, etc.) only concern is the include file
# - need to make this simpler, but something like makedepends may be too much
# - not every file depends on common.inc (do `grep -i common.inc *.for` to find)
#statem.o: common.inc

# The rule for building the statemod executable
# - all source modules are listed as dependencies
# - interdependencies are not accounted for, just the main program requirements
# - the following were in Jim Brannon's code and have been integrated more generically:
#
#	parse_gfortran.o
#	dattim_gfortran.o
#
#	getpath_windows.o
#	putpath_windows.o 
#
#statemod: \
#	StateMod_Diversion.o \
#	StateMod_DataSet.o \
#	statemod.o

# Compile source .f90 into .o
$(OBJS) : %.o : %.f90
	$(FC) $(FCFLAGS) -o $@ $<

# Link *.o into executable
$(PROGRAM) : $(OBJS)
ifdef OS
	# Windows...
	$(FC) $(FLFLAGS) -o statemod-$(STATEMOD_VERSION)-gfortran-win-32bit.exe $^
	@echo "-----------------------------------------------------------------------"
	@echo "Executable is statemod-$(STATEMOD_VERSION)-gfortran-win-32bit.exe"
	@echo "-----------------------------------------------------------------------"
else
	# Linux...
	$(FC) $(FLFLAGS) -o statemod-$(STATEMOD_VERSION)-gfortran-32bit $^
	@echo "-----------------------------------------------------------------------"
	@echo "Executable is statemod-$(STATEMOD_VERSION)-gfortran-lin-32bit"
	@echo "-----------------------------------------------------------------------"
endif

# ======================================================================
# The general rules.  These generally should not require modification.
# ======================================================================

# General rule for building prog from prog.o; $^ (GNU extension) is
# used in order to list additional object files on which the
# executable depends
#%: %.o
#	$(FC) $(FFLAGS) -o $@ $^ $(LDFLAGS)

# General rules for compiling source files into object files.
#
# % = wildcard to match file basename
# $< = source file name

# Compile files with extension .f90 into .o object files
#%.o: %.f90
#	$(FC) $(FFLAGS) -c $<

# Compile files with extension .F90 into .o object files
#%.o: %.F90
#	$(FC) $(FFLAGS) -c $<

# Compile files with extension .for into .o object files
#%.o: %.for
#	$(FC) $(FFLAGS) -c $<
#

# Main program depends on all modules
$(PRG_OBJ) : $(MOD_OBJS)

# The following is needed because of module dependencies
# - add if specific files have dependencies outside of main program
#statemod.o: \
#	StateMod_DataSet.o \
#	StateMod_Diversion.o

# Utility targets
.PHONY: clean veryclean

# Remove intermediate files used when compiling
# - Do not remove *.obj because that is used with Lahey and want gfortran compile to be separate.
clean: printenv
	@echo "-----------------------------------------------------------------------"
	@echo "Removing compile byproducts but not final executable..."
	@echo "Use 'make veryclean' if necessary to also remove final executable."
	@echo "-----------------------------------------------------------------------"
	rm -f *.o *.mod *.MOD

# Print important environment information to help understand setup
printenv: 
	@echo "-----------------------------------------------------------------------"
	@echo "Environment information:"
ifdef OS
	@echo "Windows detected from OS environment variable:  yes"
else
	@echo "Windows detected from OS environment variable:  no"
	@echo "...assuming Linux"
endif
	@echo "-----------------------------------------------------------------------"

# Remove all intermediate files and the final executable
veryclean: printenv clean
	@echo "-----------------------------------------------------------------------"
	@echo "Removing compile byproducts (make clean) and final executable..."
	@echo "-----------------------------------------------------------------------"
ifdef OS
	# Windows...
	rm -f *~ $(PROGRAMS) *.exe
else
	# Linux...
	rm -f *~ $(PROGRAMS) *.exe statemod-$(STATEMOD_VERSION)-gfortran-lin-32bit statemod-$(STATEMOD_VERSION)-gfortran-lin-64bit
endif
