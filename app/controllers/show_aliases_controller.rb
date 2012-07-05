class ShowAliasesController < ApplicationController
  load_and_authorize_resource
  # GET /show_aliases
  # GET /show_aliases.json
  def index
    @show_aliases = ShowAlias.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @show_aliases }
    end
  end

  # GET /show_aliases/1
  # GET /show_aliases/1.json
  def show
    @show_alias = ShowAlias.find(params[:id])
    respond_to do |format|
      format.html { redirect_to @show_alias.show }
      format.json { render json: @show_alias }
    end
  end

  # GET /show_aliases/new
  # GET /show_aliases/new.json
  def new
    @show_alias = ShowAlias.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @show_alias }
    end
  end

  # GET /show_aliases/1/edit
  def edit
    @show_alias = ShowAlias.find(params[:id])
  end

  # POST /show_aliases
  # POST /show_aliases.json
  def create
    @show_alias = ShowAlias.new(params[:show_alias])

    respond_to do |format|
      if @show_alias.save
        format.html { redirect_to @show_alias, notice: 'Show alias was successfully created.' }
        format.json { render json: @show_alias, status: :created, location: @show_alias }
      else
        format.html { render action: "new" }
        format.json { render json: @show_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /show_aliases/1
  # PUT /show_aliases/1.json
  def update
    @show_alias = ShowAlias.find(params[:id])

    respond_to do |format|
      if @show_alias.update_attributes(params[:show_alias])
        format.html { redirect_to @show_alias, notice: 'Show alias was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @show_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /show_aliases/1
  # DELETE /show_aliases/1.json
  def destroy
    @show_alias = ShowAlias.find(params[:id])
    @show_alias.destroy

    respond_to do |format|
      format.html { redirect_to show_aliases_url }
      format.json { head :no_content }
    end
  end
end
