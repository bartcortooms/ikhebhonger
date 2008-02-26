class FoodTypesController < ApplicationController
  # GET /food_types
  # GET /food_types.xml
  def index
    @food_types = FoodType.find(:all, :order=> "name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @food_types }
    end
  end

  # GET /food_types/1
  # GET /food_types/1.xml
  def show
    @food_type = FoodType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @food_type }
    end
  end

  # GET /food_types/new
  # GET /food_types/new.xml
  def new
    @food_type = FoodType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @food_type }
    end
  end

  # GET /food_types/1/edit
  def edit
    @food_type = FoodType.find(params[:id])
  end

  # POST /food_types
  # POST /food_types.xml
  def create
    @food_type = FoodType.new(params[:food_type])

    respond_to do |format|
      if @food_type.save
        flash[:notice] = 'FoodType was successfully created.'
        format.html { redirect_to(@food_type) }
        format.xml  { render :xml => @food_type, :status => :created, :location => @food_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @food_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /food_types/1
  # PUT /food_types/1.xml
  def update
    @food_type = FoodType.find(params[:id])

    respond_to do |format|
      if @food_type.update_attributes(params[:food_type])
        flash[:notice] = 'FoodType was successfully updated.'
        format.html { redirect_to(@food_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @food_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /food_types/1
  # DELETE /food_types/1.xml
  def destroy
    @food_type = FoodType.find(params[:id])
    @food_type.destroy

    respond_to do |format|
      format.html { redirect_to(food_types_url) }
      format.xml  { head :ok }
    end
  end
end
