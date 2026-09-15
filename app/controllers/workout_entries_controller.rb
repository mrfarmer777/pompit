class WorkoutEntriesController < ApplicationController

  def new
    @workout_entry = WorkoutEntry.new
    @workouts = Workout.all
  end

  def create
    @workout_entry = WorkoutEntry.new(workout_entry_params)
    if @workout_entry.save
      flash[:success] = "Workout entry created!"
      redirect_to workout_entry_path(@workout_entry), status: :see_other
    else
      @workouts = Workout.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @workout_entry = WorkoutEntry.find(params[:id])
    @workouts = Workout.all
  end

  def update
    @workout_entry = WorkoutEntry.find(params[:id])
    if @workout_entry.update(workout_entry_params)
      flash[:success] = "Workout Entry successfully updated!"
      redirect_to workout_entry_path(@workout_entry), status: :see_other
    else
      @workouts = Workout.all
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @workout_entry = WorkoutEntry.find(params[:id])
  end

  private

  def workout_entry_params
    params.require(:workout_entry).permit(:date, :workout_id)
  end
end
