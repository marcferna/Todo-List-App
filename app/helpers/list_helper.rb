module ListHelper
  def print_overdue_tasks_badge
  	@number_overdue_tasks = current_user.overdue_tasks.size
    if @number_overdue_tasks != 0
      raw('<span class="badge badge-important">') +  pluralize(@number_overdue_tasks, t('lists.general.overdue_task')) + raw('</span>')
    end
  end
end
