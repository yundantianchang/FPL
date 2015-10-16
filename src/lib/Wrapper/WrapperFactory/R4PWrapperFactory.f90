module R4PWrapperFactory

USE WrapperFactory
USE IR_Precision, only: R4P
USE DimensionsWrapper
USE DimensionsWrapper0D_R4P
USE DimensionsWrapper1D_R4P
USE DimensionsWrapper2D_R4P
USE DimensionsWrapper3D_R4P
USE DimensionsWrapper4D_R4P
USE DimensionsWrapper5D_R4P
USE DimensionsWrapper6D_R4P
USE DimensionsWrapper7D_R4P

implicit none
private

    type, extends(WrapperFactory_t) :: R4PWrapperFactory_t
    private

    contains
        procedure         :: R4PWrapperFactory_Create0D
        procedure         :: R4PWrapperFactory_Create1D
        procedure         :: R4PWrapperFactory_Create2D
        procedure         :: R4PWrapperFactory_Create3D
        procedure         :: R4PWrapperFactory_Create4D
        procedure         :: R4PWrapperFactory_Create5D
        procedure         :: R4PWrapperFactory_Create6D
        procedure         :: R4PWrapperFactory_Create7D
        procedure, public :: hasSameType => R4PWrapperFactory_hasSameType
        generic,   public :: Create      => R4PWrapperFactory_Create0D, &
                                            R4PWrapperFactory_Create1D, &
                                            R4PWrapperFactory_Create2D, &
                                            R4PWrapperFactory_Create3D, &
                                            R4PWrapperFactory_Create4D, &
                                            R4PWrapperFactory_Create5D, &
                                            R4PWrapperFactory_Create6D, &
                                            R4PWrapperFactory_Create7D
    end type

public :: R4PWrapperFactory_t

contains

    function R4PWrapperFactory_hasSameType(this, Value) result(hasSameType)
        class(R4PWrapperFactory_t), intent(IN) :: this
        class(*),                   intent(IN) :: Value
        logical                                :: hasSameType
        hasSameType = .false.
        select type(Value)
            type is (real(R4P))
                hasSameType = .true.
        end select
    end function R4PWrapperFactory_hasSameType


    subroutine R4PWrapperFactory_Create0D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create R4P 0D Wrapper
    !-----------------------------------------------------------------
        class(R4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value)) then
            allocate(DimensionsWrapper0D_R4P_t::Wrapper)
            select type (Wrapper)
                type is(DimensionsWrapper0D_R4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine R4PWrapperFactory_Create0D


    subroutine R4PWrapperFactory_Create1D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create R4P 1D Wrapper
    !-----------------------------------------------------------------
        class(R4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1))) then
            allocate(DimensionsWrapper1D_R4P_t::Wrapper)
            select type (Wrapper)
                type is(DimensionsWrapper1D_R4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine R4PWrapperFactory_Create1D


    subroutine R4PWrapperFactory_Create2D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create R4P 2D Wrapper
    !-----------------------------------------------------------------
        class(R4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1))) then
            allocate(DimensionsWrapper2D_R4P_t::Wrapper)
            select type (Wrapper)
                type is(DimensionsWrapper2D_R4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine R4PWrapperFactory_Create2D


    subroutine R4PWrapperFactory_Create3D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create R4P 3D Wrapper
    !-----------------------------------------------------------------
        class(R4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1))) then
            allocate(DimensionsWrapper3D_R4P_t::Wrapper)
            select type (Wrapper)
                type is(DimensionsWrapper3D_R4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine R4PWrapperFactory_Create3D


    subroutine R4PWrapperFactory_Create4D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create R4P 4D Wrapper
    !-----------------------------------------------------------------
        class(R4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1,1))) then
            allocate(DimensionsWrapper4D_R4P_t::Wrapper)
            select type (Wrapper)
                type is(DimensionsWrapper4D_R4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine R4PWrapperFactory_Create4D


    subroutine R4PWrapperFactory_Create5D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create R4P 5D Wrapper
    !-----------------------------------------------------------------
        class(R4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1,1,1))) then
            allocate(DimensionsWrapper5D_R4P_t::Wrapper)
            select type (Wrapper)
                type is(DimensionsWrapper5D_R4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine R4PWrapperFactory_Create5D


    subroutine R4PWrapperFactory_Create6D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create R4P 6D Wrapper
    !-----------------------------------------------------------------
        class(R4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:,:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1,1,1,1))) then
            allocate(DimensionsWrapper6D_R4P_t::Wrapper)
            select type (Wrapper)
                type is(DimensionsWrapper6D_R4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine R4PWrapperFactory_Create6D


    subroutine R4PWrapperFactory_Create7D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create R4P 7D Wrapper
    !-----------------------------------------------------------------
        class(R4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:,:,:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1,1,1,1,1))) then
            allocate(DimensionsWrapper7D_R4P_t::Wrapper)
            select type (Wrapper)
                type is(DimensionsWrapper7D_R4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine R4PWrapperFactory_Create7D


end module R4PWrapperFactory
