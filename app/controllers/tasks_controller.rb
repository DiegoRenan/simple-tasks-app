class TasksController < ApplicationController
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

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
