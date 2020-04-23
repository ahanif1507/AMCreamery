class EmployeesController < ApplicationController
  
  before_action :check_login 
  before_action :set_employee, only: [:update, :edit, :show, :detail]
  
  def index
      @active_managers = Employee.managers.active.alphabetical.paginate(page: params[:page]).per_page(15)
      @active_employees = Employee.regulars.alphabetical.paginate(page: params[:page]).per_page(15)
      @inactive_employees = Employee.regulars.inactive.alphabetical.paginate(page: params[:page]).per_page(15)
  end
  
  def detail
      @current_assignment = @employee.assignments.current
      @previous_assignments = @employee.assignments.past.chronological
  end
    
  def show
      @current_assignment = @employee.assignments.current
      @previous_assignments = @employee.assignments.past.chronological
  end
      
  def new
      @employee = Employee.new
  end
  
  def create
      @employee = Employee.new(employee_params)
    if @employee.save
      # if saved to database
      flash[:notice] = "Successfully added #{@employee.proper_name} as an employee."
      redirect_to employee_path(Employee.last)
    else
      # return to the 'new' form
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @employee.update_attributes(employee_params)
      flash[:notice] = "Updated #{@employee.proper_name}'s information."
      redirect_to employee_path(@employee)
    else
      render action: 'edit'
    end
  end
 
 
   private
    def set_employee
      @employee = Employee.find(params[:id])
    end
    
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :active)
    end
    
end
