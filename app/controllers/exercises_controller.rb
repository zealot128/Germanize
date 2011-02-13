class ExercisesController < ApplicationController
  before_filter :login_required

  def index
    @exercises = Exercise.all
  end
  
  def show
    redirect_to exercise_words_path Exercise.find(params[:id])
  end
  
  def new
    @exercise = Exercise.new
    xhr_no_layout
  end
  
  def edit
    @exercise = Exercise.find(params[:id])
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
    @exercise = Exercise.find(params[:id])
    @exercise.user = current_user
    
    if @exercise.update_attributes(params[:exercise])
      redirect_to(@exercise, :notice =>I18n.t('item_updated', :item => t('exercise')))
    else
      render :action => "edit" 
    end
  end
  
  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    
    redirect_to(exercises_url)
  end
  

end
