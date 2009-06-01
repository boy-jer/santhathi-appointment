class Laboratory::ParametersController < ApplicationController
  layout 'laboratory'

  def index
  	@search = Parameter.new_search(params[:search])
    @search.per_page ||= 15
    @parameters = @search.all
    respond_to do |format|
      format.html
      format.js  {  render :update do |page|
                      page.replace_html 'parameters_list', :partial => 'parameters_list'
                    end
                 }
     end
  end

  def show
    @parameter = Parameter.find(params[:id])
    render :layout => false
  end

  def new
    @parameter = Parameter.new
  end

  def edit
    @parameter = Parameter.find(params[:id])
    @values = @parameter.values if @parameter.value_type =="Multiple"
  end

  def create
    @parameter = Parameter.create(params[:parameter])
    @parameter.values = params[:values].split(',') unless params[:values].blank?
    if @parameter.save
      flash[:notice] = 'Parameter was successfully created.'
      redirect_to(laboratory_parameters_url)
    else
      render :action => "new"
    end
  end

  def update
    @parameter = Parameter.find(params[:id])
    if @parameter.update_attributes(params[:parameter])
      @parameter.values = params[:values].split(',') unless params[:values].blank?
      @parameter.save
      flash[:notice] = 'Parameter was successfully updated.'
      redirect_to(laboratory_parameters_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @parameter = Parameter.find(params[:id])
    @parameter.destroy
    redirect_to(laboratory_parameters_url)
  end

  def muliple_display
  	@values = Parameter.find(params[:id]).values
  	render :layout => false
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
