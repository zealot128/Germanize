class ExercisesController < ApplicationController
  before_filter :login_required

  def index
    @exercises = current_user.exercises
  end
  
  def show
    redirect_to exercise_words_path current_user.exercises.find(params[:id])
  end
  
  def new
    @exercise = Exercise.new
    xhr_no_layout
  end
  
  def edit
    @exercise = current_user.exercises.find(params[:id])
    xhr_no_layout
  end
  
  def create
    @exercise = Exercise.new(params[:exercise])
    @exercise.user = current_user
    
    if @exercise.save
      redirect_to(@exercise, :notice => I18n.t('item_created', :item => t('exercise'))) 
    else
      render :action => "new" 
    end
  end
  
  def update
    @exercise = current_user.exercises.find(params[:id])
    @exercise.user = current_user
    
    if @exercise.update_attributes(params[:exercise])
      redirect_to(@exercise, :notice =>I18n.t('item_updated', :item => t('exercise')))
    else
      render :action => "edit" 
    end
  end
  
  def destroy
    @exercise = current_user.exercises.find(params[:id])
    @exercise.destroy
    
    redirect_to(exercises_url)
  end
  
  def level
    @exercise = Exercise.find(params[:id])
    @words = @exercise.find_all_by_level(params[:level])
    render :layout => false

  end

end
