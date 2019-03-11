class QuizCreatorJob < ActiveJob::Base
  queue_as :default

  def perform(quiz_candidate)
    q_sets = quiz_candidate.quiz.question_sets
    q_sets.each do |set|
      _questions = Question.tagged_with(set.tags)
      questions = _questions.sample(set.question_count)
      questions.each do |question|
        _answer = question.answers.new
        _answer.quiz_candidate = quiz_candidate
        _answer.save!
      end
    end
  end
end
