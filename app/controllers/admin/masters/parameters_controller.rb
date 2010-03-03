class Admin::Masters::ParametersController < ApplicationController
 layout proc{ |c| ['show','new', 'create','edit'].include?(c.action_name)? 'admin_single_column' : 'admin'}

  def index
  	@search = Parameter.new_search(params[:search])
    @search.per_page ||= 50
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
    @values = @parameter.parameter_values.map { |ob| ob.value }.join(',') if @parameter.value_type == "Multiple"
    render :layout => false
  end

  def new
    @parameter = Parameter.new
  end

  def edit
    @parameter = Parameter.find(params[:id])
    @type = @parameter.value_type
    @values = @parameter.parameter_values.map { |ob| ob.value }.join(',') if @parameter.value_type == "Multiple"
  end

  def create
    @parameter = Parameter.create(params[:parameter])
   # @parameter.values = params[:values].strip.split(',') unless params[:values].blank?
    if @parameter.save
    	unless params[:values].blank?
    		 value = params[:values].strip.split(',')
    		 ParameterValue.transaction do
    		 	 value.each do |q|
              ParameterValue.create({:parameter_id => @parameter.id ,:value => q.strip})
           end
         end
  		end
      flash[:notice] = 'Parameter was successfully created.'
      redirect_to(admin_masters_parameters_url)
    else
      render :action => "new"
    end
  end

  def update
    @parameter = Parameter.find(params[:id])
    if @parameter.update_attributes(params[:parameter])
    #  @parameter.values = params[:values].split(',') unless params[:values].blank?
      #@parameter.save
      unless params[:values].blank?
      	 @parameter.parameter_values.map { |ob| ob.destroy }
    		 value = params[:values].strip.split(',')
    		 ParameterValue.transaction do
    		 	 value.each do |q|
              ParameterValue.create({:parameter_id => @parameter.id ,:value => q.strip})
           end
         end
  		end
      flash[:notice] = 'Parameter was successfully updated.'
      redirect_to(admin_masters_parameters_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @parameter = Parameter.find(params[:id])
    @parameter.destroy
    redirect_to(admin_masters_parameters_url)
  end

  def muliple_display
  	@values = Parameter.find(params[:id]).parameter_values
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

