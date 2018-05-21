class Question < ActiveRecord::Base
  has_many :answers
  has_many :options
  has_many :tags, through: :tagging
  has_many :taggings, as: :taggable

  accepts_nested_attributes_for :options
  accepts_nested_attributes_for :taggings

  validates :title, :uid, presence: true
  validates_uniqueness_of :uid

  def build_object(row)
    self.uid = row[0]
    self.title = row[1]
    self.body = "<pre>#{row[2]}</pre>" if row[2].try(:strip).present?
    Question.transaction do
      self.save!
      options = []
      (3..6).each { |num|
        num == 3 ? options << {body: "<pre>#{row[num]}</pre>"} : options << {body: "<pre>#{row[num]}</pre>", is_correct: true} if row[num].try(:strip).present?
      }
      self.options.create(options)
    end
  end

end
