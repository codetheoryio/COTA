class QuizCreatorJob < ActiveJob::Base
  queue_as :default

  def perform(quiz_candidate)
    q_sets = quiz_candidate.quiz.question_sets
    q_sets.each do |set|
      _questions = Question.tagged_with(set.tags)
      existing_question_ids = quiz_candidate.candidate_questions.map(&:question).map(&:id)
      questions = _questions.where.not(id: existing_question_ids).sample(set.question_count)
      questions.each do |question|
        _candidate_question = question.candidate_questions.new
        _candidate_question.quiz_candidate = quiz_candidate
        _candidate_question.save!
      end
    end
  end
end
