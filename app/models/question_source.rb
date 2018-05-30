class QuestionSource < ActiveRecord::Base

  has_attached_file :question_sheet

  validates_attachment :question_sheet, presence: true,
                       content_type: { content_type: %w(
                           application/vnd.ms-excel,
                           application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,
                           application/x-ole-storage
                       )
                       },
                       message: ' Only EXCEL files are allowed.'


  def process
    questions_excel = Spreadsheet.open (Rails.root.join(self.question_sheet.path))
    questions_sheet = questions_excel.worksheet 0
    questions_sheet.each 1 do |row|
      question = Question.find_by_uid(row[0]) || Question.new
      question.build_object(row) if question.uid.nil?
    end
  end
end
