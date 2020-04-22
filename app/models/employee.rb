class Employee < ApplicationRecord

  has_secure_password

  # Relationships
  has_many :assignments
  has_many :stores, through: :assignments

  # Scopes
  scope :younger_than_18, -> { where('date_of_birth > ?', 18.years.ago.to_date) }
  scope :is_18_or_older,  -> { where('date_of_birth <= ?', 18.years.ago.to_date) }
  scope :regulars,        -> { where('role = ?', 'employee') }
  scope :managers,        -> { where('role = ?', 'manager') }
  scope :admins,          -> { where('role = ?', 'admin') }
  scope :alphabetical,    -> { order('last_name, first_name') }
  scope :active,          -> { where(active: true) }
  scope :inactive,        -> { where.not(active: true) }

  # Validations
  validates_presence_of :first_name, :last_name, :ssn, :role
  validates_date :date_of_birth, :on_or_before => lambda { 14.years.ago }, on_or_before_message: 'must be at least 14 years old'
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: 'should be 10 digits (area code needed) and delimited with dashes only'
  validates_format_of :ssn, with: /\A\d{3}[- ]?\d{2}[- ]?\d{4}\z/, message: 'should be 9 digits and delimited with dashes only'
  validates_uniqueness_of :ssn
  validates_inclusion_of :role, in: %w[admin manager employee], message: 'is not an option'

  # Other methods
  def name
    "#{last_name}, #{first_name}"
  end

  def proper_name
    "#{first_name} #{last_name}"
  end

  def over_18?
    date_of_birth.to_date < 18.years.ago.to_date
  end

  def age
    (Time.now.to_s(:number).to_i - date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i
  end

  def current_assignment
    curr_assignment = self.assignments.current
    return nil if curr_assignment.empty?
    curr_assignment.first   # return as a single object, not an array
  end

  def make_active
    self.active = true
    self.save!
  end

  def make_inactive
    self.active = false
    self.save!
  end

  def certify_autograde
    return -3554384015922413861
  end

  ROLES_LIST = [['Employee', 'employee'],['Manager', 'manager'],['Administrator', 'admin']].freeze

  # Callbacks
  before_save :reformat_phone
  before_save :reformat_ssn

  private
  def reformat_phone
    self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
  end

  def reformat_ssn
    self.ssn = self.ssn.to_s.gsub(/[^0-9]/,"")
  end


end
