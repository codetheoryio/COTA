class AddAttachmentSheetsToQuestionSources < ActiveRecord::Migration
  def self.up
    change_table :question_sources do |t|
      t.attachment :question_sheet
      t.attachment :result_sheet
    end
  end

  def self.down
    remove_attachment :question_sources, :question_sheet
    remove_attachment :question_sources, :result_sheet
  end
end
