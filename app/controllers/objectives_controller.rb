class ObjectivesController < ApplicationController
  before_action :authenticate_user!

  def index
    @objectives = Objective.all.where(user_id: current_user.id).sort_by { |objective| objective.achieved ? 0 : 1 }
  end

  def create
    @objective = Objective.new(objectives_params)
    @objective.user = current_user
    if @objective.save
      redirect_back fallback_location: root_path, notice: 'Objective created successfully.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @objective = Objective.find(params[:id])
    if @objective.update(objectives_params)
      redirect_back fallback_location: root_path, notice: 'Objective updated successfully.'
    else
      render "articles/show", status: :unprocessable_entity
    end
  end

  def destroy
    @objective = Objective.find(params[:id])
    if @objective.destroy
      redirect_back fallback_location: root_path, notice: 'Objective deleted successfully.'
    else
      render "articles/show", status: :unprocessable_entity
    end
  end

  private

  def objectives_params
    params.require(:objective).permit(:name, :achieved)
  end
end
