class Job < ApplicationRecord

    before_destroy :do_not_delete, unless: :should_delete?

    #relationships
    has_many :shift_jobs
    has_many :shifts, through: :shift_jobs
    
    #validations
    validates_presence_of :level
    
    #scopes
    scope :alphabetical,    -> {order('name')}
    scope :active,          -> {where(active: true)}
    scope :inactive,        -> {where(active: false)}
        
    #methods 
    def make_active
      self.active = true
    end
      
    def make_inactive
      self.active = false
    end

    private
    def do_not_delete
        throw(:abort)
    end

    #only delete if the job has never been recorded as being done by an employee during a shift
    def should_delete?
        return self.shift.report_completed?
    end

end