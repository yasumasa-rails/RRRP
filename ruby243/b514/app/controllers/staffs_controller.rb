class StaffsController < ApplicationController
  before_action :sign_in_required, only: [:index]
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
  end
  # GET /api/staffs/searchs
  def search
    @q = Staff.ransack(search_params)
    @staffs = @q.result(distinct: true)
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # DELETE /staffs/1
  # DELETE /staffs/1.json
 def destroy
    @staff.destroy
    respond_to do |format|
	      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	  end

	  private
	 	  
	    # Use callbacks to share common setup or constraints between actions.
	    def set_staff
	      @staff = Staff.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def staff_params
      params.require(:staff).permit(:name, :age, :joined_on)
    end 
	def search_params
	      params.require(:q).permit(:name_cont , :age_gteq , :age_lteq , :joined_on_gteq, :joined_on_lteq)
	  end

end
