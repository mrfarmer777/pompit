class ExercisesController < ApplicationController
  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(**exercise_params)
    if @exercise.save
      flash[:success] = 'Exercise successfully created!'
      redirect_to exercises_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @exercises = Exercise.all
  end

  def delete
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name)
  end
end
