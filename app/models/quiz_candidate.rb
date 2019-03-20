class QuizCandidate < ActiveRecord::Base
  include AASM

  has_many :candidate_questions
  belongs_to :quiz
  belongs_to :candidate

  before_save :generate_secure_token
  after_save :generate_secure_url

  # Need this to generate the secure recommandation URL below in the after save call.
  include Rails.application.routes.url_helpers
  delegate :default_url_options, to: ActionMailer::Base

  aasm column: 'status', :whiny_transitions => false do
    state :invited, :initial => true
    state :started
    state :timeout
    state :not_completed
    state :completed

    event :set_started do
      transitions :from => :invited, :to => :started
    end

    event :set_timeout do
      transitions :from => [:invited, :started], :to => :timeout
    end

    event :set_not_completed do
      transitions :from => [:invited, :started], :to => :not_completed
    end

    event :set_completed do
      transitions :from => [:invited, :started], :to => :completed
    end
  end

  def self.check_can_create_quiz_candidate(quiz, candidate_email)
    user = User.find_by_email(candidate_email)
    candidate = user&.candidate
    return if candidate.blank?

    quiz_candidate_exists = quiz.quiz_candidates.where(candidate_id: candidate.id).present?
    raise CanCan::AccessDenied.new("Candidate is Already invited!") if quiz_candidate_exists
  end

  def generate_secure_token
    self.secure_assessment_token = Devise.friendly_token if self.secure_assessment_token.blank?
    self.secure_token_expire_at = Time.zone.now + 3.days if self.secure_token_expire_at.blank?
  end

  def generate_secure_url
    if self.secure_assessment_token.present? && self.secure_assessment_url.blank?
      begin
        long_url = polymorphic_url([self.quiz, self], action: 'assessment', :secure => self.secure_assessment_token)
        self.update_attribute(:secure_assessment_url, long_url) if long_url.present?
      rescue Exception => e
        raise(e)
      end
    end
  end

  def set_assessment_times
    start_time = Time.zone.now
    end_time = Time.zone.now + self.quiz.time_limit.minutes
    self.assessment_started_at = start_time if self.assessment_started_at.blank?
    self.assessment_ends_at = end_time if self.assessment_ends_at.blank?
    self.save!
  end

  def right_candidate?(user)
    self&.candidate&.user.id == user.id
  end

  def prepare_quiz
    QuizCreatorJob.perform_later(self)
  end
end
