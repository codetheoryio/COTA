module QuestionSourcesHelper

  def display_status(status)
    case status
      when "received" , "invited"
        "<span class='badge new' data-badge-caption=''>#{status.upcase}</span>".html_safe
      when 'processing' , "started"
        "<span class='badge new blue' data-badge-caption=''>#{status.upcase}</span>".html_safe
      when 'processed' , "completed"
        "<span class='badge new green' data-badge-caption=''>#{status.upcase}</span>".html_safe
      when 'failed' , "not_completed"
        "<span class='badge new red' data-badge-caption=''>#{status.upcase}</span>".html_safe
      when 'timeout'
        "<span class='badge new pink' data-badge-caption=''>#{status.upcase}</span>".html_safe
    end
  end
end
