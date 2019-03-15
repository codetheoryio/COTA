class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "application"

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_url, :alert => exception.message }
    end
  end

  def breadcrumb_path(path, humanize=true)
    root_path = {:Home => "/"}
    path = {} if path.nil?
    path = root_path.merge!(path)
    links = []
    index = 0
    root_path.each do |title, link|
      if(index == root_path.length - 1)
        links << (humanize ? link.to_s.humanize : link.to_s)
      else
        links << (humanize ? "<a href='#{link}' title='#{title}'>#{title.to_s.underscore.humanize}</a>" : "<a href='#{link}' title='#{title}'>#{title.to_s}</a>")
      end

      index = index + 1
    end
    return links.join("&nbsp;&#187;&nbsp;")
  end
end
