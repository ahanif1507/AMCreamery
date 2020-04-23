class PayGradeRate < ApplicationRecord
  
  before_destroy :do_not_delete
  
  #relationships
  belongs_to :pay_grade

  validates_numericality_of :rate, :greater_than =>0
  
  scope :current,       -> {where('end_date IS NULL')}
  scope :chronological, -> {order('start_date')}
  scope :for_date,      ->(date) {where("start_date <= ?", date)}
  scope :for_pay_grade, -> (pay_grade){where('pay_grade_id == ?', pay_grade.id)}
  
  private
  def do_not_delete
    throw(:abort)
  end

end