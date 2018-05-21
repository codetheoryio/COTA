class AddAttachmentQuestionSheetToQuestionSources < ActiveRecord::Migration
  def self.up
    change_table :question_sources do |t|
      t.attachment :question_sheet
    end
  end

  def self.down
    remove_attachment :question_sources, :question_sheet
  end
end
