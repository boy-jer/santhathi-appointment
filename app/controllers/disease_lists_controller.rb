class DiseaseListsController < ApplicationController
  layout 'cms'

  def index
    @disease_lists = DiseaseList.paginate :page => params[:page],:per_page => 10


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @disease_lists }
    end
  end

  # GET /disease_lists/1
  # GET /disease_lists/1.xml
  def show
    @disease_list = DiseaseList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @disease_list }
       format.js { render :layout => false }
    end
  end

  # GET /disease_lists/new
  # GET /disease_lists/new.xml
  def new
    @disease_list = DiseaseList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @disease_list }
    end
  end

  # GET /disease_lists/1/edit
  def edit
    @disease_list = DiseaseList.find(params[:id])
  end

  # POST /disease_lists
  # POST /disease_lists.xml
  def create
    @disease_list = DiseaseList.new(params[:disease_list])

    respond_to do |format|
      if @disease_list.save
        flash[:notice] = 'DiseaseList was successfully created.'
        format.html { redirect_to(@disease_list) }
        format.xml  { render :xml => @disease_list, :status => :created, :location => @disease_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @disease_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /disease_lists/1
  # PUT /disease_lists/1.xml
  def update
    @disease_list = DiseaseList.find(params[:id])

    respond_to do |format|
      if @disease_list.update_attributes(params[:disease_list])
        flash[:notice] = 'DiseaseList was successfully updated.'
        format.html { redirect_to(@disease_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @disease_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /disease_lists/1
  # DELETE /disease_lists/1.xml
  def destroy
    @disease_list = DiseaseList.find(params[:id])
    @disease_list.destroy

    respond_to do |format|
      format.html { redirect_to(disease_lists_url) }
      format.xml  { head :ok }
    end
  end
end
