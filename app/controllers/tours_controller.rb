require 'tour_decorator'
require 'my_logger'

class ToursController < ApplicationController
  before_filter :authenticate_user! 
  before_filter :ensure_admin, :only => [:edit, :destroy]
  before_action :set_tour, only: [:show, :edit, :update, :destroy]
  
  def ensure_admin
    unless current_user && current_user.admin?
    render :text => "Access Error Message", :status => :unatuhorized
    end
  end
  
  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.all
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
  end

  # GET /tours/new
  def new
    @tour = Tour.new
  end

  # GET /tours/1/edit
  def edit
  end

  # POST /tours
  # POST /tours.json
  def create
    @tour = Tour.new(tour_params)
    
    @tour.firstname = params[:tour][:firstname]
    @tour.lastname = params[:tour][:lastname]
    @tour.language = params[:tour][:language]
    
    #create an instance/object of a BasicTour
    myTour = BasicTour.new(0, @tour.language)
    # add the extra features
    if params[:tour][:windows].to_s.length > 0 then
      myTour = ElectricWindowsDecorator.new(myTour)
    end

    if params[:tour][:mirror].to_s.length > 0 then
      myTour = MirrorDecorator.new(myTour)
    end
    
    if params[:tour][:psensor].to_s.length > 0 then
      myTour = ParkingSensorDecorator.new(myTour)
    end
    
    #popuate the cost and description details
    @tour.cost = myTour.cost
    @tour.description = myTour.details
    
    #retrieve the instance/object of the MyLogger class
    logger = MyLogger.instance
    logger.logInformation("a new car requested:" + @tour.description)
    
    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: @tour }
      else
        format.html { render :new }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    
    #update the instance variables with the information
    #user provided in the form
    #retrieve each value from the params hash
    @tour.firstname = params[:tour][:firstname]
    @tour.lastname = params[:tour][:lastname]
    @tour.language = params[:tour][:language]
    
    #create and instance/object of a BasicTour
    myTour = BasicTour.new(10, @tour.language)
    
    #add the extra features
    if params[:tour][:windows].to_s.length > 0 then
      myTour = ElectricWindowsDecorator.new(myTour)
    end
    
    if params[:tour][:mirror].to_s.length > 0 then
      myTour = MirrorDecorator.new(myTour)
    end
    
    if params[:tour][:psensor].to_s.length > 0 then
      myTour = ParkingSensorDecorator.new(myTour)
    end
    
    #update the cost and the description details.
    @tour.cost = myTour.cost
    @tour.description = myTour.details
    
    #build a hash with the updated information of the car
    updated_information = {
      "firstname" => @tour.firstname,
      "lastname" => @tour.lastname,
      "language" => @tour.language,
      "cost" => @tour.cost
    }
    
    respond_to do |format|
      if @tour.update(tour_params)
        format.html { redirect_to @tour, notice: 'Tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour.destroy
    respond_to do |format|
      format.html { redirect_to tours_url, notice: 'Tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:firstname, :lastname, :language, :cost, :description)
    end
end
