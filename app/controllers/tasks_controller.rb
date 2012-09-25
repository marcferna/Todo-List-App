class TasksController < ApplicationController
  before_filter :authenticate_user!

  def new
    @task = Task.new
  end

  def create
    @list = current_user.lists.find( params[:list_id] )
    @task = @list.tasks.create ( params[:task] )
    if @task.save
      redirect_to user_list_path( current_user, params[:list_id] ), :notice => t('tasks.controller.create.success')
    else
      flash[:error] = t('tasks.controller.create.failure')
      render :action => :new
    end
  end

  def edit
    begin
      list = current_user.lists.find(params[:list_id])
      @task = list.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to user_list_path(current_user, list), :error => t('lists.controller.not_found') 
    end
  end

  def update
    begin
      list = current_user.lists.find(params[:list_id])
      @task = list.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound 
      redirect_to user_list_path(current_user, list), :error => t('tasks.controller.not_found') 
    end
    if @task.update_attributes(params[:task])
      redirect_to user_list_path(current_user, list), :notice => t('tasks.controller.update.success') 
    else
      flash[:error] = t('tasks.controller.update.failure') 
      render :action => 'edit'
    end
  end

  def complete
    begin
      list = current_user.lists.find(params[:list_id])
      @task = list.tasks.find(params[:task_id])
    rescue ActiveRecord::RecordNotFound 
      redirect_to user_list_path(current_user, list), :error => t('tasks.controller.not_found') 
    end
    if @task.update_attributes(:done => !@task.done)
      message = t('tasks.controller.change.do')
      unless @task.done
        message = t('tasks.controller.change.undo')
      end
      redirect_to user_list_path(current_user, list), :notice => message
    else
      redirect_to user_list_path(current_user, list), :error => t('tasks.controller.change.failure') 
    end
  end

  def destroy
    begin
      list = current_user.lists.find(params[:list_id])
      @task = list.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to user_list_path( current_user, params[:list_id] ), :error => t('tasks.controller.destroy.failure') 
    end
    @task.destroy
    redirect_to user_list_path( current_user, params[:list_id] ), :notice => t('tasks.controller.destroy.success')
  end
end
