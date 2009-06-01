class Cms::PharmacyPrescriptionsController < ApplicationController
  layout 'cms'
  before_filter :find_appointment ,:except => [:pharamacy_item_detail ,:calculate_end_date]
  def index
    @pharmacy_prescriptions = @appointment.pharmacy_prescriptions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cms_pharmacy_prescriptions }
    end
  end


  def show
    @pharmacy_prescription = PharmacyPrescription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pharmacy_prescription }
    end
  end


  def new
    @pharmacy_prescription = PharmacyPrescription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pharmacy_prescription }
    end
  end


  def edit
    @pharmacy_prescription = PharmacyPrescription.find(params[:id])
  end


  def create
    @pharmacy_prescription = PharmacyPrescription.new(params[:pharmacy_prescription])
    @pharmacy_prescription.appointment_id = @appointment.id

    respond_to do |format|
      if @pharmacy_prescription.save
        flash[:notice] = 'Cms::PharmacyPrescription was successfully created.'
        format.html { redirect_to() }
        format.xml  { render :xml => @pharmacy_prescription, :status => :created, :location => @pharmacy_prescription }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pharmacy_prescription.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @pharmacy_prescription = PharmacyPrescription.find(params[:id])

    respond_to do |format|
      if @pharmacy_prescription.update_attributes(params[:pharmacy_prescription])
        flash[:notice] = 'Cms::PharmacyPrescription was successfully updated.'
        format.html { redirect_to(cms_appointment_pharmacy_prescription_path(:appointment_id => @appointment,:id =>@pharmacy_prescription)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pharmacy_prescription.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @pharmacy_prescription = PharmacyPrescription.find(params[:id])
    @pharmacy_prescription.destroy

    respond_to do |format|
      format.html { redirect_to(cms_appointment_pharmacy_prescriptions_path(:appointment_id => @appointment)) }
      format.xml  { head :ok }
    end
  end

  def pharamacy_item_detail
    unless params[:pharamacy_item_information_id].blank?
  	  @pharmacy_item = PharamacyItemInformationDetail.find_by_pharamacy_item_information_id(params[:pharamacy_item_information_id])
      puts "ppppppppppppppppppppppppppppppppppp#{@pharmacy_item.other_remarks}"
  	  render :update do |page|
        page << "$('pharmacy_prescription_pharmacy_dosage_list_id').value = #{@pharmacy_item.pharmacy_dosage_list_id}"
        page << "$('pharmacy_prescription_other_remarks').value = 11111111"
        page << "$('pharmacy_prescription_course_duration').value =#{@pharmacy_item.course_duration}"
        page << "$('pharmacy_prescription_quantity').value = #{@pharmacy_item.quantity}"
        page << "$('pharmacy_prescription_pharmacy_course_list_id').value = #{@pharmacy_item.pharmacy_course_list_id}"
     end
   else
      render :update do |page|
        page << "$('pharmacy_prescription_pharmacy_dosage_list_id').value = '' "
        page << "$('pharmacy_prescription_other_remarks').value = '' "
        page << "$('pharmacy_prescription_course_duration').value = ' '"
        page << "$('pharmacy_prescription_quantity').value = ''"
        page << "$('pharmacy_prescription_pharmacy_course_list_id').value = ''"
     end
   end

 	end

 	def calculate_end_date
 		if params[:duration].blank? || params[:start_date].blank?
 			render :update do |page|
        page << "$('pharmacy_prescription_course_end_date').value = '' "
      end
		else
			date  = params[:start_date].to_date.advance(:days => params[:duration].to_i)
			date1 = date.to_s(:db)

			puts "qqqqqqqqqqqqqqqqqqqqqqq#{date1}"
			render :update do |page|
			  page << "$('pharmacy_prescription_course_end_date').value = #{date1}"
      end
		end

	end

  private

  def find_appointment
  	@appointment = Appointment.find(params[:appointment_id])
 	end

end
