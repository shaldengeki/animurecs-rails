class SeriesController < ApplicationController
  # This model is deprecated, and any methods listed here are not guaranteed to provide useful data.

  # Displays list of series.
  # Can be accessed by GETting /series or  /series.xml
  def index
    @series = Series.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @series }
    end
  end

  # Displays a series's information.
  # Can be accessed by GETting /series/1 or  /series/1.xml
  def show
    @series = Series.find(params[:id])
    @comments = @series.comments

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @series }
    end
  end

  # Displays the form to add a new series.
  # Can be accessed by GETting /series/new or  /series/new.xml
  def new
    @series = Series.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @series }
    end
  end

  # Displays the form to edit a series's information.
  # Can be accessed by GETting /series/edit/1
  def edit
    @series = Series.find(params[:id])
  end

  # Creates a series.
  # Can be accessed by POSTING /series or  /series.xml
  def create
    @series = Series.new(params[:series])

    respond_to do |format|
      if @series.save
        format.html { redirect_to(@series, :notice => 'Series was successfully created.') }
        format.xml  { render :xml => @series, :status => :created, :location => @series }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @series.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Updates a series with new information.
  # Can be accessed by PUTting /series/1 or  /series/1.xml
  def update
    @series = Series.find(params[:id])

    respond_to do |format|
      if @series.update_attributes(params[:series])
        format.html { redirect_to(@series, :notice => 'Series was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @series.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a series.
  # Can be accessed by DELETEing /series/1 or  /series/1.xml
  def destroy
    @series = Series.find(params[:id])
    @series.destroy

    respond_to do |format|
      format.html { redirect_to(serial_index_url) }
      format.xml  { head :ok }
    end
  end
end
