class PayGradeRatesController < ApplicationController

  before_action :check_login 
  before_action :set_pay_grade_rate, only: [:edit, :show, :update, :destroy]

  def new
		@pay_grade_rate = PayGradeRate.new
	end

  def edit
  end

  def index
		@pay_grade_rates = PayGradeRate.alphabetical.paginate(page: params[:page]).per_page(15)
  end

  def show
  end

  def create
    @pay_grade_rate = PayGradeRate.new(pay_grade_rate_params)
		if @pay_grade_rate.save
			# if saved to database
			flash[:notice] = "Successfully add the pay_grade_rate: #{@pay_grade_rate}."
			redirect_to pay_grade_rate_path(@pay_grade_rate)
		else
			# return to the 'new' form
			render :action => 'new'
		end
  end

  def update
		if @pay_grade_rate.update_attributes(pay_grade_rate_params)
			flash[:notice] = "Successfully updated pay grade rate to #{@pay_grade_rate.rate}."
			redirect_to @pay_grade_rate
		else
			render :action => 'edit'
		end
  end
  
  # def destroy
  #   @pay_grade_rate.destroy
  #   flash[:notice] = "Removed pay grade rate from the system."
  #   redirect_to pay_grade_rates_url
  # end
  
  private
    def set_pay_grade_rate
      @pay_grade_rate = PayGradeRate.find(params[:id])
    end

    def pay_grade_rate_params
      params.require(:pay_grade_rate).permit(:pay_grade_id, :rate, :start_date) 
    end

end
