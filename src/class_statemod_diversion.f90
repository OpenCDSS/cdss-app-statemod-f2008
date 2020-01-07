module class_StateMod_Diversion
    ! Diversion station

    implicit none

    ! Declare data and procedures for the class
    type, public                           :: StateMod_Diversion  ! Class name

        ! Data for diversion station

        character(12)                      :: cgoto     ! River node for diversion
        real                               :: divcap    ! Diversion capacity
      contains
        ! Declare routines in this class
        ! In the following, 'pass' will cause 'this' to be passed
        procedure, pass                    :: constructor
        procedure, nopass                  :: read_statemod_file
        procedure, pass                    :: get_cgoto
        procedure, pass                    :: get_divcap
        procedure, pass                    :: set_cgoto
        procedure, pass                    :: set_divcap

    end type StateMod_Diversion

contains
    ! TODO smalers 2020-01-07 some documentation says to use functions and others subroutines
    subroutine constructor(this)
    ! function constructor(this)
        ! Constructor for a StateMod_Diversion
        class(StateMod_Diversion), intent(out)    :: this

        ! Initialize class data
        this%cgoto = ""
        this%divcap = -999.0
    end subroutine constructor
    ! end function constructor

    function get_cgoto(this) result(r)
        ! Set the cgoto value for the instance
        class(StateMod_Diversion)                 :: this
        character(12)                             :: r

        r = this%cgoto
    end function get_cgoto

    function get_divcap(this) result(r)
        ! Set the divcap value for the instance
        class(StateMod_Diversion)                 :: this
        real                                      :: r

        r = this%divcap
    end function get_divcap

    subroutine read_statemod_file(filen,diversions)
        ! Read StateMod_Diversion instances from the *.dds file
        ! Subroutine arguments.
        character(LEN=*), intent(in)                           :: filen       ! Name of *.dds file
        class(StateMod_Diversion), dimension(:), intent(out)   :: diversions  ! Diversions to read

        ! Subroutine local data
        ! TODO smalers 2020-01-07 the following should be used with allocate() below but gives errors below
        !class(StateMod_Diversion), allocatable    :: diversion
        ! TODO smalers 2020-01-07 the following declares one instance that is rewritten each loop iteration
        class(StateMod_Diversion)                 :: diversion
        integer                                   :: i
        character(12)                             :: i_string
        character(12)                             :: cgoto

        ! TODO smalers 2020-01-06 need to implement read from file but
        ! for now create an instance and set data
        ! TODO smalers 2020-01-07 If using a normal array,
        !  might need to do two passes, one to determine how many diversions,
        !  then allocate array, and then read and assign
        write(*,*) 'Reading diversions from ', filen
        do i = 1, 9
            ! Because StateMod_Diversion below has no arguments,
            ! it is matched with the
            ! StateMod_Diversion_constructor(this) function because
            ! the 'pass' property is specified when declaring the
            ! procedure.
            ! Allocate a new diversion
            ! TODO smalers 2020-01-07 the following seems correct but generates error:
            !  Error: 'constructor' at (1) should be a FUNCTION
            ! allocate(diversion,source=diversion%constructor())
            ! TODO the following works but reuses one instance rather than allocating new memory
            call diversion%constructor()
            write(i_string,'(I1)') i
            cgoto = 'divid'//i_string
            call diversion%set_cgoto(cgoto)
            call diversion%set_divcap(real(i))
            ! Assign the new diversion to the array slot
            ! diversions(i) = diversion
        end do
    end subroutine read_statemod_file

    subroutine set_cgoto(this,cgoto)
        ! Set the cgoto value for the instance
        class(StateMod_Diversion)                 :: this
        character(LEN=*), intent(in)              :: cgoto

        this%cgoto = cgoto
    end subroutine set_cgoto

    subroutine set_divcap(this,divcap)
        ! Set the divcap value for the instance
        class(StateMod_Diversion)                 :: this
        real, intent(in)                          :: divcap

        this%divcap = divcap
    end subroutine set_divcap

end module class_Statemod_Diversion
