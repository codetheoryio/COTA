class BaseNotifier < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  # layout 'cota_notifier'
end