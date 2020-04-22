class PayGrade < ApplicationRecord

    before_destroy :do_not_delete
    
    #relationships
    has_many :assignments
    has_many :pay_grade_rates
    
    #validations
    validates_presence_of :level
    
    #scopes
    scope :alphabetical,    -> {order('level')}
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

end