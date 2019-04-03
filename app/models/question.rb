class Question < ActiveRecord::Base

  acts_as_taggable

  has_many :options
  has_many :candidate_questions

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
      (3..6).to_a.shuffle.each { |num|
        num == 3 ? options << {body: "<pre>#{row[num]}</pre>", is_correct: true} : options << {body: "<pre>#{row[num]}</pre>"} if row[num].try(:strip).present?
      }
      self.options.create(options)
    end
  rescue Exception
    self.errors.messages
  end

  class<<self
    def get_random(tags, count)
      q = includes(:tags)
      tags.each do |tag|
        q = q.where(tags: {name: tag})
      end
      q.sample(count)
    end
  end

end
