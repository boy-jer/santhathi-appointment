class Laboratory::LaboratoryReportsController < ApplicationController
  layout proc{ |c| ['show','new', 'create'].include?(c.action_name)? 'laboratory_single_column' : 'laboratory'}
  def index

  end

  def show
    @prescribed_test = PrescribedTest.find(params[:prescribed_test_id])
    @lab_test = @prescribed_test.service

    unless @lab_test.laboratory_test_group_id.blank?
      @prescreption = @prescribed_test.prescription
      prescribe_test_ids = @prescreption.prescribed_tests.collect(&:id)
      prescribe_test_ids = prescribe_test_ids - [@prescribed_test.id]
      @other_prescribed_tests = if prescribe_test_ids.blank?
         []
      else
        PrescribedTest.find(:all,:joins => [:service],
      :conditions => ["prescribed_tests.id in (?) and services.laboratory_test_group_id = ?", prescribe_test_ids, @lab_test.laboratory_test_group_id])
      end
    end

    @appointment = @prescribed_test.prescription.appointment
    @patient = @appointment.patient
    @specifications = @lab_test.parameter_specifications.gender_filter(@patient.gender)
    @laboratory_report = LaboratoryReport.find(params[:id])
    @laboratory_test_results =  @laboratory_report.laboratory_test_results

    @results = {}
    @laboratory_test_results.map{|r|  @results[r.parameter_specification_id] = [r.result, r.remarks] }

    respond_to do |format|
      format.html
      format.pdf { options = {:left_margin   => 20,
                               :right_margin  => 20,
                               :top_margin    => 20,
                               :bottom_margin => 20
    			     }
                             prawnto :inline=>true, :prawn=> options, :filename => "appointments.pdf"
                   render :layout => false
                 }


    end
  end

  def new
    @prescribed_test = PrescribedTest.find(params[:prescribed_test_id])
    @appointment = @prescribed_test.prescription.appointment
    @patient = @appointment.patient
    @specifications = @prescribed_test.service.parameter_specifications.gender_filter(@patient.gender)
    @laboratory_report = LaboratoryReport.new

    respond_to do |format|
      format.html
      format.js {   }
    end
  end

  def create
    @laboratory_report = LaboratoryReport.new(params[:laboratory_report])
    @laboratory_report.save

    #reduce the inventory item balance
    inventory_items = PrescribedTest.find(params[:prescribed_test_id]).service.inventory_items_used_for_tests
    unless inventory_items.blank?
      inventory_items.each do |it|
        item = InventoryItem.find(it.inventory_item_id)
        transaction = user_default_branch.inventory_transaction_items.new(:quantity => it.quantity, :price => item.unit_buy_price, :total_price => (item.unit_buy_price * it.quantity), :category => 'LaboratoryUse', :unit_type => 'Main')
        transaction.inventory_item_id = it.inventory_item_id
        transaction.save!
      end
    end

    specs = params[:specifications]
    unless specs.blank?
      specs[:ids].each_pair{ |key, value| LaboratoryTestResult.create(:parameter_specification_id => key,
                                                                     :result => value,
                                                                     :remarks => specs[:remarks]["r_#{key}"],
                                                                     :laboratory_report_id =>  @laboratory_report.id,
                                                                     :position => ParameterSpecification.find(key).position
                                                                    )
                                                                 }
    end

    flash[:notice] = 'Report is successfully created.'
    redirect_to laboratory_prescribed_tests_url
  end

  def edit
  	@prescribed_test = PrescribedTest.find(params[:prescribed_test_id])
    @prescription, @lab_test = @prescribed_test.prescription, @prescribed_test.service
    @appointment = @prescription.appointment
    @patient = @appointment.patient
    @specifications = @lab_test.parameter_specifications.gender_filter(@patient.gender)

    @laboratory_report = LaboratoryReport.find(params[:id])
  end

  def update
    @laboratory_report = LaboratoryReport.find(params[:id])
    if @laboratory_report.update_attributes(params[:laboratory_report])
      specs = params[:specifications]
      specs[:ids].each_pair{ |key, value|

      laboratory_test_result = LaboratoryTestResult.find_by_parameter_specification_id_and_laboratory_report_id(key,@laboratory_report.id)
      laboratory_test_result.update_attributes(:parameter_specification_id => key,
                                               :result => value,
                                               :remarks => specs[:remarks]["r_#{key}"],
                                               :laboratory_report_id =>  @laboratory_report.id ) }

      flash[:notice] = 'Laboratory Report is successfully updated.'
      redirect_to laboratory_prescriptions_url
    else
      render :action => "edit"
    end
  end

  def destroy
    @laboratory_report = LaboratoryReport.find(params[:id])
    @laboratory_report.destroy
    redirect_to(laboratory_laboratory_reports_url)
  end

  def sort_results
    params[:results].map{|r|
                              test_result = ParameterSpecification.find(r).laboratory_test_result
                              test_result.update_attribute('position', params[:results].index(r) + 1) unless test_result.blank? }
  end

end

