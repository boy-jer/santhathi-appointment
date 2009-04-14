class ParametersController < ApplicationController
  layout 'laboratory'
  def index
    @parameters = Parameter.paginate(:include => :measurement_unit, :page => params[:page],:per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parameters }
    end
  end

  # GET /parameters/1
  # GET /parameters/1.xml
  def show
    @parameter = Parameter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @parameter }
      format.js { render :layout => false }
    end
  end

  # GET /parameters/new
  # GET /parameters/new.xml
  def new
    @parameter = Parameter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @parameter }
    end
  end

  # GET /parameters/1/edit
  def edit
    @parameter = Parameter.find(params[:id])
  end

  # POST /parameters
  # POST /parameters.xml
  def create
    @parameter = Parameter.create(params[:parameter])
    @parameter.values = params[:values].split(',') unless params[:values].blank?


    respond_to do |format|
      if @parameter.save
        flash[:notice] = 'Parameter was successfully created.'
        format.html { redirect_to(@parameter) }
        format.xml  { render :xml => @parameter, :status => :created, :location => @parameter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @parameter.errors, :status => :unprocessable_entity }
      end
    end


  end

  # PUT /parameters/1
  # PUT /parameters/1.xml
  def update
    @parameter = Parameter.find(params[:id])

    respond_to do |format|
      if @parameter.update_attributes(params[:parameter])
        flash[:notice] = 'Parameter was successfully updated.'
        format.html { redirect_to(@parameter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @parameter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parameters/1
  # DELETE /parameters/1.xml
  def destroy
    @parameter = Parameter.find(params[:id])
    @parameter.destroy

    respond_to do |format|
      format.html { redirect_to(parameters_url) }
      format.xml  { head :ok }
    end
  end

  def muliple_display
  	@values = Parameter.find(params[:id]).values
  	respond_to do |format|
  		 format.js { render :layout => false }
 	end
  end

  def multiple_section
    respond_to do |format|
      format.js {
                 render :update do |page|
                   if params[:value_type] == 'Multiple'
                      page.replace_html 'multiple', :partial => 'multiple_section'
                   else
                      page.replace_html 'multiple', ''
                   end
                 end
                }
    end
  end


end
