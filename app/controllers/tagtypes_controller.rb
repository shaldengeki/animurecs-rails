class TagtypesController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :create, :update, :destroy]

  # Displays list of tagtypes.
  # Can be accessed by GETting /tagtypes or  /tagtypes.xml
  def index
    @tagtypes = Tagtype.all
	@title = "Tag types"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tagtypes }
    end
  end

  # Displays a tagtype's information.
  # Can be accessed by GETting /tagtypes/1 or  /tagtypes/1.xml
  def show
    @tagtype = Tagtype.find(params[:id])
	@title = @tagtype.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tagtype }
    end
  end

  # Displays the form to add a new tagtype.
  # Can be accessed by GETting /tagtypes/new or  /tagtypes/new.xml
  def new
    @tagtype = Tagtype.new
	@title = "New tag type"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tagtype }
    end
  end

  # Displays the form to edit a tagtype's information.
  # Can be accessed by GETting /tagtypes/edit/1
  def edit
    @tagtype = Tagtype.find(params[:id])
	@title = "Editing "+@tagtype.name	
  end

  # Creates a tagtype.
  # Can be accessed by POSTING /tagtypes or  /tagtypes.xml
  def create
    @tagtype = Tagtype.new(params[:tagtype])

    respond_to do |format|
      if @tagtype.save
        format.html { redirect_to(@tagtype, :notice => 'Tagtype was successfully created.') }
        format.xml  { render :xml => @tagtype, :status => :created, :location => @tagtype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tagtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Updates a tagtype with new information.
  # Can be accessed by PUTting /tagtypes/1 or  /tagtypes/1.xml
  def update
    @tagtype = Tagtype.find(params[:id])

    respond_to do |format|
      if @tagtype.update_attributes(params[:tagtype])
        format.html { redirect_to(@tagtype, :notice => 'Tagtype was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tagtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a tagtype.
  # Can be accessed by DELETEing /tagtypes/1 or  /tagtypes/1.xml
  def destroy
    @tagtype = Tagtype.find(params[:id])
    @tagtype.destroy

    respond_to do |format|
      format.html { redirect_to(tagtypes_url) }
      format.xml  { head :ok }
    end
  end
  
  private

	def authenticate
	  deny_access unless signed_in?
	end

end
