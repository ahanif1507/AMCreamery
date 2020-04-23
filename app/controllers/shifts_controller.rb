class ShiftsController < ApplicationController

  before_action :check_login 

  before_action :set_shift, only: [:edit, :show, :update]

  def new
		@shift = Shift.new
	end

  def edit
  end

  def index
		@shifts = Shift.alphabetical.paginate(page: params[:page]).per_page(15)
  end

  def show
  end

  def create
    @shift = Shift.new(shift_params)
		if @shift.save
			# if saved to database
			flash[:notice] = "Successfully added the shift: #{@shift}."
			redirect_to shift_path(@shift)
		else
			# return to the 'new' form
			render :action => 'new'
		end
  end

  def update
		if @shift.update_attributes(shift_params)
			flash[:notice] = "Successfully updated shift to #{@shift}."
			redirect_to @shift
		else
			render :action => 'edit'
		end
  end
  
  def destroy
    @shift.destroy
    flash[:notice] = "Removed shift from the system."
    redirect_to shifts_url
  end


  private
    def set_shift
      @shift = Shift.find(params[:id])
    end

    def shift_params
      params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status) 
    end

end
