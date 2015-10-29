class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  before_filter :authenticate_user!
  def index
#    @companies = Company.all
    @company = Company.find(current_user.company.id)

    respond_to do |format|
      format.html { redirect_to @company }
      format.json { render json: @company }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /companies/1/edit
  def edit_formats
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.js
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.js { render action: "edit" }
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
  
  def subscribe_month
    @company = Company.find(current_user.company.id)
    @company.plan = "PAGO"
    @company.initial_cycle = Time.new
    @company.final_cycle = Time.now.months_since(1)
    @company.counter = 0
    @company.limit = 1000000

    respond_to do |format|
      if @company.save
  	    format.js {} 
      else
  	    format.js { @company.errors[:base] << "Error al actualizar plan"} 
      end
    end  
  end
  
  def subscribe_year
    @company = Company.find(current_user.company.id)
    @company.plan = "PAGO"
    @company.initial_cycle = Time.new
    @company.final_cycle = Time.now.years_since(1)
    @company.counter = 0
    @company.limit = 1000000

    respond_to do |format|
       if @company.save
         format.js { } 
       else
         format.js { @company.errors[:base] << "Error al actualizar plan"} 
       end
     end
  end

   def subscribe_alert
      @company = Company.find(current_user.company.id)

      respond_to do |format|
     	  format.js { @company.errors[:base] << params[:msg] }  
      end
   end

   # ############# Para Pruebas 
   #  def became_free
   #     @company = Company.find(current_user.company.id)
   #     @company.plan = "GRATIS"
   #     @company.initial_cycle = Time.new
   #     @company.final_cycle = Time.now.months_since(1)
   #     @company.counter = 0
   #     @company.limit = 3
   #     
   #     respond_to do |format|
   #        if @company.save
   #    	    format.js { @company.errors[:base] << "SE puso gratis" } 
   #        else
   #          format.js { @company.errors[:base] << "Error al actualizar plan"} 
   #        end
   #      end
   #   end
   ####################   
end
