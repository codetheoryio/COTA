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
    self.body = "<pre>#{row[2]}</pre>"
    Question.transaction do
      self.save!
      self.options.create([
                              {body: "<pre>#{row[3]}</pre>", is_correct: true},
                              {body: "<pre>#{row[4]}</pre>"},
                              {body: "<pre>#{row[5]}</pre>"},
                              {body: "<pre>#{row[6]}</pre>"}
                          ])
    end
  end

end
