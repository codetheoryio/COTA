class CandidateNotifier < BaseNotifier

  def send_candidate_invitation(candidate, quiz)
    email(candidate, quiz)
  end

  def email(candidate, quiz)
    @notifier_candidate = candidate
    @quiz = quiz
    subject = "ClearStack | Interview Next Steps | #{@notifier_candidate.name.titleize} | #{@notifier_candidate.applied_position}"
    mail(to: candidate.email,
         # cc: test_cc,
         # bcc: test_bcc,
         subject: subject)
  end
end