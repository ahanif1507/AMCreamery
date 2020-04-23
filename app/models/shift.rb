class Shift < ApplicationRecord
 
  before_create :set_end_time
  before_destroy :do_not_delete, unless: :should_delete?
  
  # def destroy
  #   super if should_delete?
  # end
  
  #relationships
  belongs_to :assignment
  has_one :store, through: :assignment
	has_one :employee, through: :assignment
  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  
  #validations
  validates_presence_of :assignment_id, :status, :date, :start_time
  validates_inclusion_of :status, in: %w[pending started finished]
  validates_date :date, on_or_after: :start_date
  validates_time :start_time
	validates_time :end_time, after: :start_time, allow_blank: true

  #scopes
  scope :completed,     -> { joins(:shift_jobs).group(:shift_id) }
	scope :incomplete,    -> { joins("LEFT JOIN shift_jobs ON shifts.id = shift_jobs.shift_id").where('shift_jobs.job_id IS NULL') }
	scope :for_store,     -> (store_id){ joins(:assignment, :store).where("assignments.store_id = ?", store_id) }
	scope :for_employee,  -> (employee_id){ joins(:assignment, :employee).where("assignments.employee_id = ?", employee_id) }
	scope :past,          -> { where('date < ?', Date.today) }
  scope :upcoming,      -> { where('date >= ?', Date.today) }
  scope :pending,       -> { where('status = ?', 'pending') }
  scope :started,       -> { where('status = ?', 'started') }
  scope :finished,      -> { where('status = ?', 'finished') }
	scope :for_next_days, -> (x){ where('date BETWEEN ? AND ?', Date.today, x.days.from_now.to_date) }
	scope :for_past_days, -> (x){ where('date BETWEEN ? AND ?', x.days.ago.to_date, 1.day.ago.to_date) }
  scope :for_dates,     -> (x,y){ where('date BETWEEN ? AND ?', x.days.ago.to_date, y.days.ago.to_date) }
  scope :chronological, -> { order(:date, :start_time) }
	scope :by_store,      -> { joins(:assignment, :store).order(:name) }
  scope :by_employee,   -> { joins(:assignment, :employee).order(:last_name, :first_name) }
  
  #metods
  def report_completed?
    return self.shift_jobs.count > 0
  end

  def duration
    shift_time = end_time.ceil(15*60) - start_time.round_off(15*60)
		duration = shift_time/3600
		return duration
  end

  def set_end_time
    self.end_time = self.start_time + (3*60*60)
    return self.end_time
  end

  private
  def start_date
		@start_date = self.assignment.start_date.to_date
  end

  def do_not_delete
    throw(:abort)
  end

  #only delete when status = 'pending'
  def should_delete?
    if self.status == "pending"
      return true
    else
      return false
    end
  end

end