class ListsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @lists = current_user.lists
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.create( params[:list] )
    if @list.save
      redirect_to user_lists_path( current_user ), :notice => t('lists.controller.create.success')
    else
      flash[:error] = t('lists.controller.create.failure')
      render :action => :new
    end
  end

  def show
    begin
      @list = current_user.lists.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to user_lists_path(current_user), :error => t('lists.controller.not_found') 
    end
  end

  def edit
    begin
      @list = current_user.lists.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to user_lists_path(current_user), :error => t('lists.controller.not_found') 
    end
  end

  def update
    begin
      @list = current_user.lists.find(params[:id])
    rescue ActiveRecord::RecordNotFound 
      redirect_to user_lists_path(current_user), :error => t('lists.controller.not_found') 
    end
    if @list.update_attributes(params[:list])
      redirect_to user_lists_path(current_user), :notice => t('lists.controller.update.success') 
    else
      flash[:error] = t('lists.controller.update.failure') 
      render :action => 'edit'
    end
  end

  def destroy
    begin
      @list = current_user.lists.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to user_lists_path( current_user ), :error => t('lists.controller.destroy.failure') 
    end
    @list.destroy
    redirect_to user_lists_path( current_user ), :notice => t('lists.controller.destroy.success')
  end
end
