class Laboratory::ParameterSpecificationsController < ApplicationController
  layout 'laboratory'
  before_filter :find_service, :except => ['load_fields']

  def index
    @parameter_specifications = @lab_test.parameter_specifications.find(:all, :order => 'position ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parameter_specifications }
    end
  end


  def show
    @parameter_specification =@lab_test.parameter_specifications.find(params[:id])
    render :layout => false
  end


  def new
    @parameter_specification = @lab_test.parameter_specifications.new

    respond_to do |format|
      format.html
      format.js { @parameter = Parameter.find(params[:parameter_id])
                 partial_name = case @parameter.value_type
                      when 'Text','Header' then 'text_fields'
                      when 'Numeric' then 'numeric_fields'
                      when 'Multiple' then 'multiple_fields'
                   end

                 render :update do |page|
                   page.replace_html 'parameter_fields', :partial => partial_name, :object => {:parameter_specification => @parameter_specification}
                 end

              }
    end
  end


  def edit
    @parameter_specification = @lab_test.parameter_specifications.find(params[:id])
  end


  def create

    @parameter_specification = @lab_test.parameter_specifications.new(params[:parameter_specification])
    respond_to do |format|
      if @parameter_specification.save
        flash[:notice] = 'Parameter specification is successfully created.'
        format.html { redirect_to(laboratory_lab_test_parameter_specifications_path(@lab_test)) }
        format.xml  { render :xml => @parameter_specification, :status => :created, :location => @parameter_specification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @parameter_specification.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @parameter_specification = @lab_test.parameter_specifications.find(params[:id])

    respond_to do |format|
      if @parameter_specification.update_attributes(params[:parameter_specification])
        flash[:notice] = 'ParameterSpecification was successfully updated.'
        format.html { redirect_to(laboratory_lab_test_parameter_specifications_path(@lab_test)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @parameter_specification.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @parameter_specification = ParameterSpecification.find(params[:id])
    @parameter_specification.destroy

    respond_to do |format|
      format.html { redirect_to(laboratory_lab_test_parameter_specifications_path(@lab_test) ) }
      format.xml  { head :ok }
    end
  end

  def sort

    specs_array = params[:specifications]
    specs_array.map{|spec_id| ParameterSpecification.find(spec_id).update_attribute('position', specs_array.index(spec_id) + 1)}
    @parameter_specifications = @lab_test.parameter_specifications.find(:all, :order => 'position ASC')
    render :update do |page|
                     page.replace_html 'specifications-list', :partial => 'specifications'
                   end
  end

  def move_one_up
    parameter_specification = ParameterSpecification.find(params[:id])
    parameter_specification.move_higher
    @parameter_specifications = @lab_test.parameter_specifications.find(:all, :order => 'position ASC')
    render :update do |page|
                       page.replace_html 'specifications-list', :partial => 'specifications'
                   end
  end


  def move_one_down
    parameter_specification = @lab_test.parameter_specifications.find(params[:id])
    parameter_specification.move_lower
    @parameter_specifications = @lab_test.parameter_specifications.find(:all, :order => 'position ASC')
    render :update do |page|
                       page.replace_html 'specifications-list', :partial => 'specifications'
                   end
  end


  private

  def find_service
     @lab_test = Service.find(params[:lab_test_id])
  end


end
