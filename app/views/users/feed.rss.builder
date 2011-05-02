xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Letzte Worte von #{@user.username}"
    xml.description "nix"

    for word in @words
      xml.item do
        xml.title word.name
        xml.description word.examples
        xml.link edit_exercise_word_path(@user.exercises.first, word)
        xml.guid word.id
      end
    end
  end
end

