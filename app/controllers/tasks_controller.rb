class TasksController < ApplicationController
  def create
    @task = Task.new(tasks_params)
    if @task.save
      redirect_back fallback_location: root_path, notice: 'Task created successfully.'
    else
      render "objetives/index", status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(tasks_params)
      redirect_back fallback_location: root_path, notice: 'Task updated successfully.'
    else
      render "objetives/index", status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_back fallback_location: root_path, notice: 'Task deleted successfully.'
    else
      render "objetives/index", status: :unprocessable_entity
    end
  end

  private

  def tasks_params
    params.require(:task).permit(:name, :status, :deadline, :objective_id)
  end
end
