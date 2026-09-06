class ExercisesController < ApplicationController
  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(**exercise_params)
    if @exercise.save
      flash[:success] = 'Exercise successfully created!'
      redirect_to exercises_path, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @exercises = Exercise.all
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    if @exercise.destroy
      flash[:success] = 'Exercise deleted!'
      redirect_to exercises_path, status: :see_other
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def edit
    @exercise = Exercise.find(params[:id])
    @from = params[:from]
  end

  def update
    @exercise = Exercise.find(params[:id])
    if @exercise.update(exercise_params)
      flash[:success] = 'Exercise successfully updated!'
      params[:from] == 'show' ?
        redirect_to(exercise_path(@exercise), status: :see_other) :
        redirect_to(exercises_path, status: :see_other)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name)
  end
end
