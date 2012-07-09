class ListEntriesController < ApplicationController
  load_and_authorize_resource
  # GET /list_entries
  # GET /list_entries.json
  def index
    @list_entries = ListEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @list_entries }
    end
  end

  # GET /list_entries/1
  # GET /list_entries/1.json
  def show
    @list_entry = ListEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list_entry }
    end
  end

  # GET /list_entries/new
  # GET /list_entries/new.json
  def new
    @list_entry = ListEntry.new()
    @list_entry.list = List.find(params[:list_id])

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.json { render json: @list_entry }
    end
  end

  # GET /list_entries/1/edit
  def edit
    @list_entry = ListEntry.find(params[:id])
  end

  # POST /list_entries
  # POST /list_entries.json
  def create
    @list_entry = ListEntry.find_or_initialize_by_list_id_and_show_id(params[:list_entry][:list_id], params[:list_entry][:show_id])
    respond_to do |format|
      if @list_entry.update_attributes(params[:list_entry])
        @list = @list_entry.list
        format.js { render :template => 'lists/show' }
        format.html { redirect_to @list_entry, notice: 'List entry was successfully created.' }
        format.json { render json: @list_entry, status: :created, location: @list_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @list_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /list_entries/1
  # PUT /list_entries/1.json
  def update
    @list_entry = ListEntry.find(params[:id])

    respond_to do |format|
      if @list_entry.update_attributes(params[:list_entry])
        format.html { redirect_to @list_entry, notice: 'List entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_entries/1
  # DELETE /list_entries/1.json
  def destroy
    @list_entry = ListEntry.find(params[:id])
    @list_entry.destroy

    respond_to do |format|
      format.html { redirect_to list_entries_url }
      format.json { head :no_content }
    end
  end
end
