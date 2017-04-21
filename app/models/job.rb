class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_upper_bound,presence: true
  validates :wage_down_bound,presence: true
  validates :wage_down_bound,numericality: {greater_than: 0}
  validates :job_sorting,presence: true
  has_many  :resumes
  def publish!
     self.is_hidden = false
     self.save
  end
  def hide!
     self.is_hidden = true
     self.save
  end
end
