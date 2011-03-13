module WordsHelper
  def reward_pictures(score)
    points = [
      [:flower, 5],
      [:jade, 5],
      [:ruby, 5],
      [:auto, 5],
      [:haus, 5],
    ]
    faktor = points.inject(1){|s,a| s*=a[1]} 
    ret = []
    points.reverse.each do |object, divisor|
      counts = score / faktor
      if counts > 0
        ret << [object, counts]
        score -= counts * faktor
      end
      faktor /= divisor
    end
    calc = ret
    pics = {
      :flower => "blume.gif",
      :jade   => "jade.jpg",
      :ruby   => "ruby-resized.png",
      :auto   => "auto.jpg,",
      :haus   => "haus.jpg"
    }
    out = ""
    calc.each do |object, count|
      count.times do 
        out += image_tag "/images/#{pics[object]}"
      end
      out+="<br/>"
    end
    out.html_safe
  end
  
end
