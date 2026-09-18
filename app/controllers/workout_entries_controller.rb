class WorkoutEntriesController < ApplicationController

  helper_method :workouts

  def index
    @workout_entries = WorkoutEntry.all
  end

  def new
    @workout_entry = WorkoutEntry.new
  end

  def create
    @workout_entry = WorkoutEntry.new(workout_entry_params)
    if @workout_entry.save
      flash[:success] = "Workout entry created!"
      redirect_to workout_entry_path(@workout_entry), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @workout_entry = WorkoutEntry.find(params[:id])
  end

  def update
    @workout_entry = WorkoutEntry.find(params[:id])
    if @workout_entry.update(workout_entry_params)
      flash[:success] = "Workout Entry successfully updated!"
      redirect_to workout_entry_path(@workout_entry), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @workout_entry = WorkoutEntry.find(params[:id])
  end

  def destroy
    @workout_entry = WorkoutEntry.find(params[:id])
    @workout_entry.destroy
    flash[:success] = "Workout Entry deleted!"
    redirect_to workout_entries_path, status: :see_other
  end

  private

  def workouts
    @workouts ||= Workout.all
  end

  def workout_entry_params
    params.require(:workout_entry).permit(:date, :workout_id)
  end
end
