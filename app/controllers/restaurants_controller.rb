class RestaurantsController < ApplicationController
  # GET /restaurants
  # GET /restaurants.xml
  def index
    if params[:city_id]
      @city = City.find(params[:city_id])
      @restaurants = @city.restaurants.find(:all, :order => "name")
      results = Geocoding::get("#{@city.name} Netherlands")
      if results.status == Geocoding::GEO_SUCCESS
        lat = results[0].latitude.to_f
        lon = results[0].longitude.to_f
      end
    elsif params[:food_type_id]
      @restaurants = FoodType.find(params[:food_type_id]).restaurants.find(:all, :order => "name")
    else
      @restaurants = Restaurant.find(:all, :order => "name")
    end

    if not (lat or lon)
      # Eindhoven, center of the world 
      (lat, lon) = [51.440200, 5.463225]
    end

    @map = GMap.new('map')
    @map.control_init(:large_map => false, :map_type => true, :small_zoom => true)
    @map.center_zoom_init([lat, lon], 12)

    @markers = []
    @restaurants.each do |@restaurant|
      (lon, lat) = @restaurant.geocoordinates
      next if lon == 0 or lat == 0

      # XXX ugly hack
      if @restaurant.pricing
        pricing_type = Restaurant::PRICING_TYPES[@restaurant.pricing-1][0]
      else
        pricing_type = "Onbekend"
      end

      @info_window = "
        Restaurant: #{@restaurant.name}<br />
        Vorkjes: #{@restaurant.rating}<br />
        Prijscategorie: #{pricing_type}<br />
        Keuken: #{@restaurant.food_type}<br />
      "
      @map.overlay_init(
        GMarker.new(
          @restaurant.geocoordinates,
          :title => @restaurant.name,
          :info_window => @info_window
        )
      )
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurants }
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.xml
  def show
    @restaurant = Restaurant.find(params[:id])
    @map = GMap.new('map')
    @map.control_init(:large_map => false, :small_zoom => true, :map_type => true)

    center = @restaurant.geocoordinates
    if center[0] == 0 or center[1] == 0
      results = Geocoding::get("#{@restaurant.city} Netherlands")
      if results.status == Geocoding::GEO_SUCCESS
        center = [results[0].latitude.to_f, results[0].longitude.to_f]
        @map.center_zoom_init(center, 12)
      end
    else
      @map.center_zoom_init(center, 15)
      @map.overlay_init(GMarker.new(center, :title => @restaurant.name, :info_window => @restaurant.address))
    end

    @actions = [ {
      'name' => 'Show',
      'action' => 'show',
      'id' => @restaurant.id
    }, {
      'name' => 'Destroy',
      'action' => 'destroy',
      'id' => @restaurant.id
    }, {
      'name' => 'Edit',
      'action' => 'edit',
      'id' => @restaurant.id
    } ]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  # GET /restaurants/new
  # GET /restaurants/new.xml
  def new
    @restaurant = Restaurant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  # POST /restaurants
  # POST /restaurants.xml
  def create
    @restaurant = Restaurant.new(params[:restaurant])

    respond_to do |format|
      if @restaurant.save
        flash[:notice] = 'Restaurant was successfully created.'
        format.html { redirect_to(@restaurant) }
        format.xml  { render :xml => @restaurant, :status => :created, :location => @restaurant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.xml
  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        flash[:notice] = 'Restaurant was successfully updated.'
        format.html { redirect_to(@restaurant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.xml
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to(restaurants_url) }
      format.xml  { head :ok }
    end
  end
end
