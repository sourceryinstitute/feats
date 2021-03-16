module scheduler_m
  !! Compute-image/Scheduler-image abstraction
  use image_m, only : image_t
  use dag_interface, only : dag_t
  implicit none

  private
  public :: scheduler_t

  type, extends(image_t) :: scheduler_t
    !! Encapsulate scheduler image identity and communication protocol
    private
    type(dag_t) task_dependencies
  contains
    procedure :: is_this_image
    procedure :: distribute_initial_tasks
  end type

  interface

    module function is_this_image(self) result(scheduler_is_this_image)
      !! Result is .true. if the executing image is the scheduler image
      implicit none
      class(scheduler_t), intent(in) :: self
      logical scheduler_is_this_image
    end function

    module subroutine distribute_initial_tasks(self)
      !! Scheduler places tasks in each compute image's mailbox
      implicit none
      class(scheduler_t), intent(in) :: self
    end subroutine

  end interface

end module
