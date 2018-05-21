module QuestionsHelper

  def display_tags(tags)
    html = ''
    tags.map(&:name).map do |tag|
      html << "<span class='badge new blue' data-badge-caption=''>#{tag.upcase}</span>"
    end
    html.html_safe
  end

end
