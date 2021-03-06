class Exercise < ActiveRecord::Base
  belongs_to :user
  has_many :levels
  has_many :words, :through => :levels
  

  def find_next_word
    current_usr = self.user
    exercise = self

    word = Word.joins("left join levels on levels.word_id = words.id").where("levels.word_id is null").where(:user_id => current_usr).order("created_at asc")
    if word.empty?
      word = Word.joins(:levels).
        where("exercise_id != ?",exercise).
        where("(select id from levels l where l.exercise_id = ? and l.word_id = words.id) is null",self).
        where(:user_id => current_usr).
        order("created_at desc").
        limit(1)
    end
      
    if word.empty?
      word = Word.where("user_id = ? ", current_usr).joins(:levels).where(:levels => {:exercise_id => exercise}).
        order("levels.next_visit asc").
        limit(1)
    end
    word.first
  end

  def count_due
    current_usr = self.user
    exercise = self
    sql = Word.where("user_id = ? ", current_usr).joins(:levels)
    sql = sql.where(:levels => {:exercise_id => exercise})
    sql = sql.where(["levels.next_visit <= ?",Time.now])
    sql.count
  end

  def level(word)
    Level.find_by_word_id_and_exercise_id(word, self)
  end
  


  def find_all_by_level(level,count = false)
    bla = words.joins(:levels).where(:levels =>{ :level => level})

    if level==0
      empty = Word.where('id not in (?)', words).where(:user_id => self.user_id)
    end
    
    if count
      count =  bla.count
      count += empty.count if level == 0
      count
    else
      obj = bla.all
      obj = obj + empty.all if level == 0
      obj.sort{|a,b| a.name.downcase <=> b.name.downcase }
    end
  end  
end
