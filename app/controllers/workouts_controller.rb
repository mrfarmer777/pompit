class WorkoutsController < ApplicationController

  helper_method :exercises
  def index
    @workouts = Workout.all
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.new(**workout_params)
    if @workout.save
      flash[:success] = 'Workout successfully created!'
      redirect_to workouts_path, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @workout = Workout.find(params[:id])
    @from = params[:from]
  end

  def update
    @workout = Workout.find(params[:id])
    if @workout.update(workout_params)
      flash[:success] = 'Workout successfully updated!'
      params[:from] == 'show' ?
        redirect_to(workout_path(@workout), status: :see_other) :
        redirect_to(workouts_path, status: :see_other)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout = Workout.find(params[:id])
    if @workout.destroy
      flash[:success] = 'Workout deleted!'
      redirect_to workouts_path, status: :see_other
    end
  end

  def show
    @workout = Workout.find(params[:id])
  end

  private


  def exercises
    @exercises ||= Exercise.all
  end

  def workout_params
    params.require(:workout).permit(:name, workout_exercises_attributes: [:id, :exercise_id, :set_count, :_destroy])
  end
end
