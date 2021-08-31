module task_item_m
  !! define tasks for compute images to complete
  use data_location_map_m, only: data_location_map_t
  use payload_m, only: payload_t
  use task_m, only : task_t
  implicit none

  private
  public :: task_item_t

  type task_item_t
    !! A wrapper for a `class(task_t)` value, to facilitate constructing an array of tasks
    private
    class(task_t), allocatable :: task
  contains
    procedure :: execute
    procedure :: is_final_task
  end type

  interface task_item_t

    module function constructor(task) result(new_task_item)
      implicit none
      type(task_item_t) new_task_item
      class(task_t), intent(in) :: task
    end function

  end interface

  interface

    module function execute(self, input_locations, task_number, mailbox) result(output)
      !! complete the assigned task
      implicit none
      class(task_item_t), intent(in) :: self
      type(data_location_map_t), intent(in) :: input_locations
      integer, intent(in) :: task_number
      type(payload_t), intent(in) :: mailbox(:)[*]
      type(payload_t) :: output
    end function

    pure module function is_final_task(self)
        !! is this the final task?
        implicit none
        class(task_item_t), intent(in) :: self
        logical :: is_final_task
    end function

  end interface

end module task_item_m
