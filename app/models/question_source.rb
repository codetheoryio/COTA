class QuestionSource < ActiveRecord::Base

  has_attached_file :question_sheet
  has_attached_file :result_sheet

  validates_attachment :question_sheet, presence: true,
                       content_type: { content_type: %w(
                           application/vnd.ms-excel,
                           application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,
                           application/x-ole-storage
                       )
                       },
                       message: ' Only EXCEL files are allowed.'

  do_not_validate_attachment_file_type :result_sheet


  def process
    questions_excel = Spreadsheet.open (Rails.root.join(self.question_sheet.path))
    questions_sheet = questions_excel.worksheet 0
    failed_rows = []
    questions_sheet.each 1 do |row|
      question = Question.find_by_uid(row[0]) || Question.new
      next if question.uid.present?
      errors = question.build_object(row)
      # if errors.any?
      #   row[8] = errors.map { |attr, msgs|
      #     msgs.map {|msg| "#{attr} #{msg}"}.join(', ')
      #   }.join(', ')
      #   failed_rows << row
      # end
    end
    # generate_result_sheet(failed_rows) if failed_rows.any?
  end

  def generate_result_sheet(failed_rows)
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    sheet1.name = 'Failed Rows'
    sheet1.row(0).concat %w{uid title body correct_option option2 option3 option4 tags failure_reasons}
    failed_rows.each_with_index do |row, index|
      sheet1.row(index+1) << row
    end
    self.result_sheet = book
    self.save!
  end
end
