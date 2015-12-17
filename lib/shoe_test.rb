require 'complete_me'

auto_complete = CompleteMe.new

dictionary = File.read('/usr/share/dict/words')

auto_complete.populate(dictionary)

Shoes.app do
  @text  = title "Auto-complete"
  stack do
    edit_box do |e|
      if e.text == ""
        @counter.text = para ""
      elsif auto_complete.suggest(e.text).empty?
        @counter.text = para ""
      else
        @counter.text = auto_complete.suggest(e.text).first(20).join("\n")
      end
    end
  end
  @counter = para ""
end
