class Exercise < ActiveRecord::Base
  belongs_to :user
  has_many :levels
  has_many :words, :through => :levels
  

  def find_next_word
    current_usr = self.user

    word = Word.joins("left join levels on levels.word_id = words.id").
      where("levels.word_id is null").order("created_at asc")
    if word.empty?
      word = Word.joins(:levels).
        where("exercise_id != ?",self).
        where("(select id from levels l where l.exercise_id = ? and l.word_id = words.id) is null",self).
        order("created_at desc").
        limit(1)
    end
      
    if word.empty?
      word = Word.where("user_id = ? ", current_usr).
        joins(:levels).
        where(:levels => {:exercise_id => self}).
        order("levels.next_visit asc").
        limit(1)
    end
    word.first
  end

  def level(word)
    Level.find_by_word_id_and_exercise_id(word, self)
  end
  
  def find_all_by_level(level)
    words.joins(:levels).where(:levels =>{ :level => level}).group("words.id").all
  end  
end
