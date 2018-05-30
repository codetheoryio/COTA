class Question < ActiveRecord::Base

  acts_as_taggable

  has_many :answers
  has_many :options

  accepts_nested_attributes_for :options

  validates :title, :uid, :tag_list, presence: true
  validates_uniqueness_of :uid

  def build_object(row)
    self.uid = row[0]
    self.title = row[1]
    self.body = "<pre>#{row[2]}</pre>" if row[2].try(:strip).present?
    self.tag_list = row[7].strip if row[7].try(:strip).present?
    Question.transaction do
      self.save!
      options = []
      (3..6).each { |num|
        num == 3 ? options << {body: "<pre>#{row[num]}</pre>", is_correct: true} : options << {body: "<pre>#{row[num]}</pre>"} if row[num].try(:strip).present?
      }
      self.options.create(options)
    end
  end

end
