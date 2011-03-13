class WordsController < ApplicationController
  before_filter :provide_exercise, :login_required
  
  def index
    @words = current_user.words.all
  end
  
  def show
    @word = current_user.words.find(params[:id])
    @level = @exercise.level(@word)
    @show = {
      :word => false,
      :translation => true,
      :examples => true,
      :synonyms => false,
      :grammar => false
     }
  end
  
  def new
    @word = Word.new
    xhr_no_layout
  end
  
  def edit
    @word = current_user.words.find(params[:id])
    xhr_no_layout
  end
  
  def create
    @word = Word.new(params[:word])
    @word.user = current_user
    if @word.save
      redirect_to(exercise_words_path(@exercise), :notice => t('item_created', :item => t('word')))
    else
      render :action => "new" 
    end
  end
  
  def update
    @word = current_user.words.find(params[:id])
    
    
    if @word.update_attributes(params[:word])
      @word.user = current_user
      @word.save
      redirect_to(exercise_word_path(@exercise, @word), :notice => t('item_updated', :item => t('word'))) 
    else
      render :action => "edit" 
    end
  end
  
  def destroy
    @word = current_user.words.find(params[:id])
    @word.destroy
    
    redirect_to(exercise_words_path(@exercise)) 
  end
  
  def retrieve
    @provider = WordProvider.new(params[:word])
    @information = @provider.to_hash
    logger.debug @information.inspect
    
  end
  
  def correct
    User.increment_counter :score, current_user
    answer('flash.correct') do
      correct
    end
  end
  
  def wrong
    User.decrement_counter :score, current_user
    answer('flash.wrong') do
      wrong
    end
  end  
  
  private
  
  def provide_exercise
    @exercise = current_user.exercises.find(params[:exercise_id])
  end
  
  def answer(flash,&block)
    @word = current_user.words.find(params["id"])
    @exercise = current_user.exercises.find(params["exercise_id"])
    @level = Level.find_or_initialize_by_word_id_and_exercise_id(@word.id,@exercise.id)
    if (@level.new_record?)
      @level.level = 0
    end
    @level.instance_exec(&block)
    logger.debug @level.inspect
    logger.debug @level.save
    redirect_to exercise_word_path(@exercise,@exercise.find_next_word) , :notice => t(flash, :level => @level.level)
  end
end
