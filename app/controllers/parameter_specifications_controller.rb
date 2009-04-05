class ParameterSpecificationsController < ApplicationController
  layout 'laboratory'
  before_filter :find_lab_test, :except => 'load_fields'

  def index
    @parameter_specifications = @lab_test.parameter_specifications.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parameter_specifications }
    end
  end


  def show
    @parameter_specification =@lab_test.parameter_specifications.find(params[:id])

    respond_to do |format|

      format.js { render :layout => false }
    end
  end


  def new
    @parameter_specification = @lab_test.parameter_specifications.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @parameter_specification }
      format.js {parameter = Parameter.find(params[:parameter_id])
                 partial_name = case parameter.value_type
                      when 'Text' then 'text_fields'
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
        flash[:notice] = 'ParameterSpecification was successfully created.'
        format.html { redirect_to(lab_test_parameter_specifications_path(@lab_test) )}
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
        format.html { redirect_to(lab_test_parameter_specifications_path(@lab_test)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @parameter_specification.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @parameter_specification = @lab_test.parameter_specifications.find(params[:id])
    @parameter_specification.destroy

    respond_to do |format|
      format.html { redirect_to(lab_test_parameter_specifications_path(@lab_test) ) }
      format.xml  { head :ok }
    end
  end


  private

  def find_lab_test
  	@lab_test = LabTest.find(params[:lab_test_id])
  end


end