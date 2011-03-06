require "rubygems"
require "wlapi"
require "cgi"
require "nokogiri"
require "open-uri"
require "active_support/core_ext/array/grouping"
require 'iconv' #this line is not needed in rails !

class String
  def to_iso
    Iconv.conv('ISO-8859-1', 'utf-8', self)
  end
end

class WordProvider
  attr_accessor :word
  attr_accessor :word_class
  attr_accessor :examples
  attr_accessor :synonyms
  attr_accessor :wordforms
  attr_accessor :translations
  attr_accessor :grammar
  def initialize(word)
    @@api ||= WLAPI::API.new
    baseform, wordclass = @@api.baseform(word)
    self.word = word

  end

  def post(url, params)
    res = Net::HTTP.post_form(URI.parse(url), params)
    return res.body
  end

  def get_grammar
    return self.grammar unless self.grammar.nil?
    para = CGI.escape self.word.to_iso
    doc = Nokogiri.parse post("http://wortschatz.uni-leipzig.de/abfrage/", "Wort" => para)
    e = doc.search(".result table:nth-child(2) tr").map{|i| i.search("td").map{|j| j.inner_text}}
    last = ""
    out = e.map do |i,j|
      if i.strip != ""
        last = i.strip
      end
      [last,j]
    end
    couples = out.group_by {|i| i[0]}.to_a.map{|i| [i[0].gsub(":",""), i[1].map{|j| j[1]}.join("; ")]}
    result = {}
    couples.each do |i|
      if i[1].include? ": "
        i[1].split(/(\w+):/).reject{|i| i.empty?}.in_groups_of(2).each do |j|
          result[j[0]]=j[1]
        end
      else
        result[i[0]] = i[1]
      end
    end
    self.grammar = result
  end

  def get_examples
    self.examples ||= @@api.sentences(self.word).in_groups_of(2).map{|i| i[1]} rescue []
  end

  def get_synonyms
    self.synonyms ||= @@api.synonyms(self.word)[0..4] rescue []
  end

  def get_wordforms
    self.wordforms ||= @@api.wordforms(self.word) rescue []
  end

  def get_translations
    if self.translations.nil?
      link = "http://dict.leo.org/chde?lp=chde&lang=de&searchLoc=0&cmpType=relaxed&sectHdr=on&spellToler=&search=" 
      link += CGI.escape(self.word)
      doc = Nokogiri.parse(open(link))
      self.translations = doc.search("#results tr[valign=top]").map{|i| i.search("td")[1].inner_text} rescue []
    end
    self.translations
    
  end

  def to_hash
    out = {:word => word, :class => word_class}
    %w[examples synonyms wordforms translations grammar].each do |bla|
      out[bla.to_sym] = self.send("get_#{bla}")      
    end
    out

  end

  def to_json
    require "json"
    to_hash.to_json
  end

end


