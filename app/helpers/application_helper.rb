module ApplicationHelper
  def highlight_text(text, regex)
    text.gsub(Regexp.new(regex)) do |match|
      "<strong>#{match}</strong>"
    end
  end
end
