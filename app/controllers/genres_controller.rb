class GenresController < ApplicationController
  # This model is deprecated, and any methods listed here are not guaranteed to provide useful data.

  # Displays list of genres.
  # Can be accessed by GETting /genres or  /genres.xml
  def index
    @genres = Genre.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @genres }
    end
  end

  # Displays a genre's information.
  # Can be accessed by GETting /genres/1 or  /genres/1.xml
  def show
    @genre = Genre.find(params[:id])
    @series = @genre.series

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @genre }
    end
  end

  # Displays the form to add a new genre.
  # Can be accessed by GETting /genres/new or  /genres/new.xml
  def new
    @genre = Genre.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @genre }
    end
  end

  # Displays the form to edit a genre's information.
  # Can be accessed by GETting /genres/edit/1
  def edit
    @genre = Genre.find(params[:id])
  end

  # Creates a genre.
  # Can be accessed by POSTING /genres or  /genres.xml
  def create
    @genre = Genre.new(params[:genre])

    respond_to do |format|
      if @genre.save
        format.html { redirect_to(@genre, :notice => 'Genre was successfully created.') }
        format.xml  { render :xml => @genre, :status => :created, :location => @genre }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @genre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Updates a genre with new information.
  # Can be accessed by PUTting /genres/1 or  /genres/1.xml
  def update
    @genre = Genre.find(params[:id])

    respond_to do |format|
      if @genre.update_attributes(params[:genre])
        format.html { redirect_to(@genre, :notice => 'Genre was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @genre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a genre.
  # Can be accessed by DELETEing /genres/1 or  /genres/1.xml
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy

    respond_to do |format|
      format.html { redirect_to(genres_url) }
      format.xml  { head :ok }
    end
  end
end
