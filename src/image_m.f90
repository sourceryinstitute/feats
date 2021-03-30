module image_m
  !! Compute-image/Scheduler-image abstraction
  implicit none

  private
  public :: image_t

  type image_t
    !! Encapsulate compute/scheduler communication protocol
    private
  contains
    procedure, nopass :: wait_do_task_notify_ready
    procedure, nopass :: is_scheduler
    procedure, nopass :: distribute_initial_tasks
  end type

  interface

    module subroutine wait_do_task_notify_ready()
      !! Compute-image does task; error terminate if called on scheduler compute
      implicit none
    end subroutine

    pure module function is_scheduler() result(image_is_scheduler)
      !! Result is .true. iff the executing image is the scheduler
      implicit none
      logical image_is_scheduler
    end function

    module subroutine distribute_initial_tasks()
      !! Scheduler places tasks in each compute image's mailbox
      implicit none
    end subroutine

  end interface

end module
