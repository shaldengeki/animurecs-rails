class TagtypesController < ApplicationController
  # GET /tagtypes
  # GET /tagtypes.xml
  def index
    @tagtypes = Tagtype.all
	@title = "Tag types"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tagtypes }
    end
  end

  # GET /tagtypes/1
  # GET /tagtypes/1.xml
  def show
    @tagtype = Tagtype.find(params[:id])
	@title = @tagtype.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tagtype }
    end
  end

  # GET /tagtypes/new
  # GET /tagtypes/new.xml
  def new
    @tagtype = Tagtype.new
	@title = "New tag type"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tagtype }
    end
  end

  # GET /tagtypes/1/edit
  def edit
    @tagtype = Tagtype.find(params[:id])
	@title = "Editing "+@tagtype.name	
  end

  # POST /tagtypes
  # POST /tagtypes.xml
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

  # PUT /tagtypes/1
  # PUT /tagtypes/1.xml
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

  # DELETE /tagtypes/1
  # DELETE /tagtypes/1.xml
  def destroy
    @tagtype = Tagtype.find(params[:id])
    @tagtype.destroy

    respond_to do |format|
      format.html { redirect_to(tagtypes_url) }
      format.xml  { head :ok }
    end
  end
end
