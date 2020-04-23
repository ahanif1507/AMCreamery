class PayGradesController < ApplicationController

  before_action :check_login 

  before_action :set_pay_grade, only: [:edit, :show, :update]

  def new
		@pay_grade = PayGrade.new
	end

  def edit
  end

  def index
		@pay_grades = PayGrade.alphabetical.paginate(page: params[:page]).per_page(15)
  end

  def show
  end

  def create
    @pay_grade = PayGrade.new(pay_grade_params)
		if @pay_grade.save
			# if saved to database
			flash[:notice] = "Successfully add the pay_grade: #{@pay_grade}."
			redirect_to pay_grade_path(@pay_grade)
		else
			# return to the 'new' form
			render :action => 'new'
		end
  end

  def update
		if @pay_grade.update_attributes(pay_grade_params)
			flash[:notice] = "Successfully updated pay grade to #{@pay_grade}."
			redirect_to @pay_grade
		else
			render :action => 'edit'
		end
  end
  
  def destroy
    @pay_grade.destroy
    flash[:notice] = "Removed pay grade from the system."
    redirect_to pay_grades_url
  end
  
  private
    def set_pay_grade
      @pay_grade = PayGrade.find(params[:id])
    end

    def pay_grade_params
      params.require(:pay_grade).permit(:level, :active) 
    end


end
