class ShiftJob < ApplicationRecord
  
  before_create :do_not_create, unless: :should_create? 
  
  #relationships
  belongs_to :shift
  belongs_to :job

  #scopes
  scope :alphabetical, -> {joins(:job).order('name')}

  #validations
  validates_presence_of :shift_id, :job_id

  private
  def do_not_create
    throw(:abort)
  end

  def should_create?
    if self.shift.status == "finished"
      return true
    else
      return false
    end
  end

end