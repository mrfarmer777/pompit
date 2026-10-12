class WorkoutEntriesController < ApplicationController

  attr_reader :workout_entry, :exercise_entries
  helper_method :workout_entry, :workout, :exercise_entries

  def index
    @workout_entries = WorkoutEntry.where(workout_id: workout.id)
  end

  def new
    @workout_entry = WorkoutEntry.new
    build_exercise_entries
  end

  def create
    @workout_entry = workout.entries.new(workout_entry_params)
    if @workout_entry.save
      flash[:success] = "Workout entry created!"
      redirect_to workout_entry_path(workout, workout_entry), status: :see_other
    else
      build_exercise_entries
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @workout_entry = WorkoutEntry.find(params[:id])
  end

  def update
    @workout_entry = WorkoutEntry.find(params[:id])
    if workout_entry.update(workout_entry_params)
      flash[:success] = "Workout Entry successfully updated!"
      redirect_to workout_entry_path(workout, workout_entry), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @workout_entry = WorkoutEntry.find(params[:id])
  end

  def destroy
    @workout_entry = WorkoutEntry.find(params[:id])
    workout_entry.destroy
    flash[:success] = "Workout Entry deleted!"
    redirect_to workout_entries_path, status: :see_other
  end

  private

  def workout
    @workout = Workout.find(params[:workout_id])
  end

  def workouts
    @workouts = Workout.all
  end

  def workout_entry_params
    params.require(:workout_entry).permit(
      :date,
      :workout_id,
      exercise_entries_attributes: [
        :id,
        :workout_exercise_id,
        :set_number,
        :reps,
        :weight,
        :_destroy
      ]
    )
  end

  def build_exercise_entries
    @exercise_entries = []
    workout.workout_exercises.each do |exercise|
      exercise.set_count.to_i.times do |set_number|
        @exercise_entries << @workout_entry.exercise_entries.build(
          set_number: set_number + 1,
          workout_exercise: exercise
        )
      end
    end
  end
end
