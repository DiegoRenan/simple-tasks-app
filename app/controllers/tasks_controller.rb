class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :toggle_complete ]

  def index
    @tasks = Task.order(created_at: :desc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      @new_task = @task
      @task = Task.new
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("task_form", partial: "tasks/form"),
                 status: :unprocessable_entity
        end
        format.html do
          @tasks = Task.order(created_at: :desc)
          render :index, status: :unprocessable_entity
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :update, status: :unprocessable_entity }
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def toggle_complete
    @task.update!(completed: !@task.completed)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end
