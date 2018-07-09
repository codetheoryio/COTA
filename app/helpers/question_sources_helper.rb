module QuestionSourcesHelper

  def display_status(status)
    case status
      when "received"
        "<span class='badge new' data-badge-caption=''>#{status.upcase}</span>".html_safe
      when :processing
        "<span class='badge new blue' data-badge-caption=''>#{status.upcase}</span>".html_safe
      when :processed
        "<span class='badge new green' data-badge-caption=''>#{status.upcase}</span>".html_safe
      when :failed
        "<span class='badge new red' data-badge-caption=''>#{status.upcase}</span>".html_safe
    end
  end
end
