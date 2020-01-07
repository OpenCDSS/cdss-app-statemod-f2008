program statemod
    ! This is the main program for prototype object-oriented StateMod

    ! Modules that are used by the program (similar to import in other languages) 
    ! use class_StateMod_DataSet
    ! use class_StateMod_Diversion
    use class_statemod_dataset
    use class_statemod_diversion

    ! Turn off implicit variable typing so that all variable types must be declared.
    implicit none

    ! Declare interface for subroutine, which is defined after the program
    ! - TODO smalers 2020-01-07 this should not be needed if could call a static subroutine in StateMod_Diversion
    interface
        subroutine read_statemod_file2(filen,diversions)
            import :: StateMod_Diversion
            character(LEN=*), intent(in)                           :: filen       ! Name of *.dds file
            class(StateMod_Diversion), dimension(:), intent(out)   :: diversions  ! Diversions to read
        end subroutine read_statemod_file2
    end interface

    ! A StateMod program contains an instance of a StateMod_DataSet,
    ! which contains the data and functions to process the dataset.

    !class(StateMod_DataSet)                               :: dataset
    class(StateMod_Diversion), allocatable, dimension(:)  :: diversions
    class(StateMod_Diversion), pointer                    :: diversion
    character(80)                                         :: dds_file
    integer                                               :: i
    integer                                               :: n_diversions

    ! The following is what a full implementation would look like
    ! - however, don't do this given limited resources
    ! Read the dataset
    ! responseFile = 'some path'
    ! dataset.read_statemod_file(responseFile)

    ! Instead, read the diversion stations into a list
    ! Use a static function in the class to read the diversions
    ! - currently the path is hard-coded but it would be read from the *.rsp file
    dds_file='ym2015H.dds'
    allocate(diversions(9))
    ! TODO smalers 2020-01-07 want to call a static subroutine on the class but don't know syntax
    !call StateMod_Diversion%read_statemod_file(dds_file,diversions)
    !
    ! Therefore call the subroutine in this main program,
    ! which is a copy of the same code
    call read_statemod_file2(dds_file,diversions)

    n_diversions = size(diversions)
    write(*,*) 'Read ', n_diversions, ' diversions'
    do i = 1, n_diversions
        ! TODO smalers 2020-01-07 following gives error:
        !  Error: Nonallocatable variable must not be polymorphic in intrinsic assignment at (1) - check that there is a matching specific subroutine for '=' operator
        ! diversion = diversions(i)
        write(*,*) 'Read diversion cgoto=',diversions(i)%get_cgoto(),' divcap=',diversions(i)%get_divcap()
    end do

end program statemod

    ! Copied code from StateMod_Diversion so leave indent the same as original
    subroutine read_statemod_file2(filen,diversions)
        use class_statemod_diversion
        implicit none

        ! Read StateMod_Diversion instances from the *.dds file
        ! Subroutine arguments.
        character(LEN=*), intent(in)                           :: filen       ! Name of *.dds file
        class(StateMod_Diversion), dimension(:), intent(out)   :: diversions  ! Diversions to read

        ! Subroutine local data
        !class(StateMod_Diversion), allocatable    :: diversion
        type(StateMod_Diversion)                  :: diversion
        integer                                   :: i
        character(12)                             :: i_string
        character(12)                             :: cgoto

        ! TODO smalers 2020-01-06 need to implement read from file but
        ! for now create an instance and set data
        write(*,*) 'Reading diversions from ', filen
        !do i = 1, 9
            ! Because StateMod_Diversion below has no arguments,
            ! it is matched with the
            ! StateMod_Diversion_constructor(this) function because
            ! the 'pass' property is specified when declaring the
            ! procedure.
            !allocate(diversion)
            !call diversion%constructor()
            write(i_string,'(I1)') i
            cgoto = 'divid'//i_string
            call diversion%set_cgoto(cgoto)
            call diversion%set_divcap(real(i))
            ! Not allowed?
            ! diversions(i) = diversion
        !end do
    end subroutine read_statemod_file2
