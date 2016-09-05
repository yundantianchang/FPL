!-----------------------------------------------------------------
! FPL (Fortran Parameter List)
! Copyright (c) 2015 Santiago Badia, Alberto F. Martín, 
! Javier Principe and Víctor Sande.
! All rights reserved.
!
! This library is free software; you can redistribute it and/or
! modify it under the terms of the GNU Lesser General Public
! License as published by the Free Software Foundation; either
! version 3.0 of the License, or (at your option) any later version.
!
! This library is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
! Lesser General Public License for more details.
!
! You should have received a copy of the GNU Lesser General Public
! License along with this library.
!-----------------------------------------------------------------

module DimensionsWrapper6D_L

USE DimensionsWrapper6D
USE FPL_Utils
USE PENF, only: I4P, str
USE ErrorMessages

implicit none
private

    type, extends(DimensionsWrapper6D_t) :: DimensionsWrapper6D_L_t
        logical, allocatable :: Value(:,:,:,:,:,:)
    contains
    private
        procedure, public :: Set            => DimensionsWrapper6D_L_Set
        procedure, public :: Get            => DimensionsWrapper6D_L_Get
        procedure, public :: GetShape       => DimensionsWrapper6D_L_GetShape
        procedure, public :: GetPointer     => DimensionsWrapper6D_L_GetPointer
        procedure, public :: GetPolymorphic => DimensionsWrapper6D_L_GetPolymorphic
        procedure, public :: DataSizeInBytes=> DimensionsWrapper6D_L_DataSizeInBytes
        procedure, public :: isOfDataType   => DimensionsWrapper6D_L_isOfDataType
        procedure, public :: toString       => DimensionsWrapper6D_L_toString
        procedure, public :: Print          => DimensionsWrapper6D_L_Print
        procedure, public :: Free           => DimensionsWrapper6D_L_Free
        final             ::                   DimensionsWrapper6D_L_Final
    end type           

public :: DimensionsWrapper6D_L_t

contains


    subroutine DimensionsWrapper6D_L_Final(this) 
    !-----------------------------------------------------------------
    !< Final procedure of DimensionsWrapper6D
    !-----------------------------------------------------------------
        type(DimensionsWrapper6D_L_t), intent(INOUT) :: this
    !-----------------------------------------------------------------
        call this%Free()
    end subroutine


    subroutine DimensionsWrapper6D_L_Set(this, Value) 
    !-----------------------------------------------------------------
    !< Set logical Wrapper Value
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), intent(INOUT) :: this
        class(*),                       intent(IN)    :: Value(:,:,:,:,:,:)
        integer                                       :: err
    !-----------------------------------------------------------------
        select type (Value)
            type is (logical)
                allocate(this%Value(size(Value,dim=1),  &
                                    size(Value,dim=2),  &
                                    size(Value,dim=3),  &
                                    size(Value,dim=4),  &
                                    size(Value,dim=5),  &
                                    size(Value,dim=6)), &
                                    stat=err)
                this%Value = Value
                if(err/=0) &
                    call msg%Error( txt='Setting Value: Allocation error ('//&
                                    str(no_sign=.true.,n=err)//')', &
                                    file=__FILE__, line=__LINE__ )
            class Default
                call msg%Warn( txt='Setting value: Expected data type (logical)', &
                               file=__FILE__, line=__LINE__ )

        end select
    end subroutine


    subroutine DimensionsWrapper6D_L_Get(this, Value) 
    !-----------------------------------------------------------------
    !< Get logical Wrapper Value
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), intent(IN)  :: this
        class(*),                       intent(OUT) :: Value(:,:,:,:,:,:)
        integer(I4P), allocatable                     :: ValueShape(:)
    !-----------------------------------------------------------------
        select type (Value)
            type is (logical)
                call this%GetShape(ValueShape)
                if(all(ValueShape == shape(Value))) then
                    Value = this%Value
                else
                    call msg%Warn(txt='Getting value: Wrong shape ('//&
                                  str(no_sign=.true.,n=ValueShape)//'/='//&
                                  str(no_sign=.true.,n=shape(Value))//')',&
                                  file=__FILE__, line=__LINE__ )
                endif
            class Default
                call msg%Warn(txt='Getting value: Expected data type (L)',&
                              file=__FILE__, line=__LINE__ )
        end select
    end subroutine


    subroutine DimensionsWrapper6D_L_GetShape(this, ValueShape)
    !-----------------------------------------------------------------
    !< Get Wrapper Value Shape
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), intent(IN)    :: this
        integer(I4P), allocatable,      intent(INOUT) :: ValueShape(:)
    !-----------------------------------------------------------------
        if(allocated(ValueShape)) deallocate(ValueShape)
		allocate(ValueShape(this%GetDimensions()))
        ValueShape = shape(this%Value, kind=I4P)
    end subroutine


    function DimensionsWrapper6D_L_GetPointer(this) result(Value) 
    !-----------------------------------------------------------------
    !< Get Unlimited Polymorphic pointer to Wrapper Value
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), target, intent(IN)  :: this
        class(*), pointer                                   :: Value(:,:,:,:,:,:)
    !-----------------------------------------------------------------
        Value => this%Value
    end function


    subroutine DimensionsWrapper6D_L_GetPolymorphic(this, Value) 
    !-----------------------------------------------------------------
    !< Get Unlimited Polymorphic Wrapper Value
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), intent(IN)  :: this
        class(*), allocatable,          intent(OUT) :: Value(:,:,:,:,:,:)
    !-----------------------------------------------------------------
        allocate(Value(size(this%Value,dim=1),  &
                       size(this%Value,dim=2),  &
                       size(this%Value,dim=3),  &
                       size(this%Value,dim=4),  &
                       size(this%Value,dim=5),  &
                       size(this%Value,dim=6)), &
                       source=this%Value)
    end subroutine


    subroutine DimensionsWrapper6D_L_Free(this) 
    !-----------------------------------------------------------------
    !< Free a DimensionsWrapper6D
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), intent(INOUT) :: this
        integer                                         :: err
    !-----------------------------------------------------------------
        if(allocated(this%Value)) then
            deallocate(this%Value, stat=err)
            if(err/=0) call msg%Error(txt='Freeing Value: Deallocation error ('// &
                                      str(no_sign=.true.,n=err)//')',             &
                                      file=__FILE__, line=__LINE__ )
        endif
    end subroutine


    function DimensionsWrapper6D_L_DataSizeInBytes(this) result(DatasizeInBytes)
    !-----------------------------------------------------------------
    !< Return the size of the stored data in bytes
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), intent(IN) :: this            !< Dimensions wrapper 6D
        integer(I4P)                               :: DataSizeInBytes !< Size of the stored data in bytes
    !-----------------------------------------------------------------
        DataSizeInBytes = byte_size_logical(this%value(1,1,1,1,1,1))*size(this%value)
    end function DimensionsWrapper6D_L_DataSizeInBytes


    function DimensionsWrapper6D_L_isOfDataType(this, Mold) result(isOfDataType)
    !-----------------------------------------------------------------
    !< Check if Mold and Value are of the same datatype 
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), intent(IN) :: this            !< Dimensions wrapper 6D
        class(*),                       intent(IN) :: Mold            !< Mold for data type comparison
        logical                                    :: isOfDataType    !< Boolean flag to check if Value is of the same data type as Mold
    !-----------------------------------------------------------------
        isOfDataType = .false.
        select type (Mold)
            type is (logical)
                isOfDataType = .true.
        end select
    end function DimensionsWrapper6D_L_isOfDataType


    function DimensionsWrapper6D_L_toString(this, Separator) result(String) 
    !-----------------------------------------------------------------
    !< Return the wrapper value as a string
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t), intent(IN)  :: this
        character(len=1), optional,     intent(IN)  :: Separator
        character(len=:), allocatable               :: String
        character(len=1)                            :: Sep
        integer(I4P)                                :: idx1,idx2,idx3,idx4,idx5,idx6
    !-----------------------------------------------------------------
        String = ''
        Sep = ','
        if(allocated(this%Value)) then
            if(present(Separator)) Sep = Separator
            do idx6=1, size(this%Value,6)
                do idx5=1, size(this%Value,5)
                    do idx4=1, size(this%Value,4)
                        do idx3=1, size(this%Value,3)
                            do idx2=1, size(this%Value,2)
                                do idx1=1, size(this%Value,1)
                                    String = String // trim(str(n=this%Value(idx1,idx2,idx3,idx4,idx5,idx6))) // Sep
                                enddo
                            enddo
                        enddo
                    enddo
                enddo
            enddo
            String = trim(adjustl(String(:len(String)-1)))
        endif
    end function


    subroutine DimensionsWrapper6D_L_Print(this, unit, prefix, iostat, iomsg)
    !-----------------------------------------------------------------
    !< Print Wrapper
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_L_t),   intent(IN)  :: this         !< DimensionsWrapper
        integer(I4P),                     intent(IN)  :: unit         !< Logic unit.
        character(*), optional,           intent(IN)  :: prefix       !< Prefixing string.
        integer(I4P), optional,           intent(OUT) :: iostat       !< IO error.
        character(*), optional,           intent(OUT) :: iomsg        !< IO error message.
        character(len=:), allocatable                 :: prefd        !< Prefixing string.
        integer(I4P)                                  :: iostatd      !< IO error.
        character(500)                                :: iomsgd       !< Temporary variable for IO error message.
    !-----------------------------------------------------------------
        prefd = '' ; if (present(prefix)) prefd = prefix
        write(unit=unit,fmt='(A,$)',iostat=iostatd,iomsg=iomsgd) prefd//' Data Type = L'//&
                        ', Dimensions = '//trim(str(no_sign=.true., n=this%GetDimensions()))//&
                        ', Bytes = '//trim(str(no_sign=.true., n=this%DataSizeInBytes()))//&
                        ', Value = '
        write(unit=unit,fmt=*,iostat=iostatd,iomsg=iomsgd) this%toString()
        if (present(iostat)) iostat = iostatd
        if (present(iomsg))  iomsg  = iomsgd
    end subroutine DimensionsWrapper6D_L_Print

end module DimensionsWrapper6D_L
