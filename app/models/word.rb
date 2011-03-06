class Word < ActiveRecord::Base
  belongs_to :user
  has_many :levels
  has_many :exercises, :through => :levels
  
  def geschlecht
    if wortart == :nomen and grammar.match(/Geschlecht: +(\w)/)
      case $1
        when "m" then :maskulinum
        when "w" then :femininum
        when "s" then :neutrum
        end
    end
  end
  
  def wortart
    case self.wordform
      when "N" then :nomen
      when "A" then :adjektiv
      when "V" then :verb
      else :unknown
    end
  end
  
  def examples_hidden
    examples.gsub(name,"______").gsub(name.capitalize,"______")
  end
end
