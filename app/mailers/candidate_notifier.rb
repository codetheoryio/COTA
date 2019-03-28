class CandidateNotifier < BaseNotifier

  def send_candidate_invitation(candidate, generated_password, quiz_candidate)
    @new_user =  generated_password.blank? ? false : true
    @notifier_candidate = candidate
    @quiz_candidate = quiz_candidate
    @password = generated_password
    subject = "ClearStack | Interview Next Steps | #{@notifier_candidate.name.titleize} | #{@notifier_candidate.applied_position}"
    mail(to: candidate.email,
         # cc: test_cc,
         bcc: 'bala@clearstack.io',
         subject: subject)
  end

  def assessment_completed_notification(quiz_candidate)
    @notifier_candidate = quiz_candidate.candidate
    @quiz_candidate = quiz_candidate
    subject = "Test Results |  #{@notifier_candidate.name.titleize} | #{@notifier_candidate.applied_position}"
    mail(to: 'sreekanth@clearstack.io',
         # cc: test_cc,
         bcc: 'bala@clearstack.io',
         subject: subject)
  end
end