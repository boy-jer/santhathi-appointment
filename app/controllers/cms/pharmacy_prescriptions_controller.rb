class Cms::PharmacyPrescriptionsController < ApplicationController
  layout 'cms'
  before_filter :find_appointment ,:except => [:pharamacy_item_detail, :pharamacy_item_informations]


  def new
    @pharmacy_prescription = PharmacyPrescription.new
    @pharmacy_prescriptions = @appointment.pharmacy_prescriptions
    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html 'pharmacy_prescription_replace', :partial => '/cms/pharmacy_prescriptions/new' 
                  end
                }
    end

  end


  def create
    @pharmacy_prescription = PharmacyPrescription.new(params[:pharmacy_prescription])
    @pharmacy_prescription.appointment_id = @appointment.id
    @pharmacy_prescriptions = @appointment.pharmacy_prescriptions

    if @pharmacy_prescription.save
        #flash[:notice] = 'Pharmacy prescription is successfully created.'
        render :update do |page|
           page.replace_html 'pharmacy_prescription-new', :partial => '/cms/pharmacy_prescriptions/new'
           page.replace_html 'pharmacy_prescription-list', :partial => '/cms/pharmacy_prescriptions/prescreptions'
        end
        
      else
        render :update do |page|
          page.replace_html 'pharmacy_prescription-list', " <div id='error'> #{@pharmacy_prescription.errors.full_messages.join('<br />')} </div>"
        end 
      end

 
  end


  def destroy
    @pharmacy_prescription = PharmacyPrescription.find(params[:id])
    @pharmacy_prescription.destroy

    @pharmacy_prescriptions = @appointment.pharmacy_prescriptions

   respond_to do |format|

      format.js {
                  render :update do |page|
                    page.replace_html 'pharmacy_prescription-new', :partial => '/cms/pharmacy_prescriptions/new'
                  end
                }
    end
  end
  
  def pharamacy_item_informations
     unless params[:pharamacy_item_id].blank?
       inventory_item =  InventoryItem.find(params[:pharamacy_item_id])
       render :update do |page|
       	     page << "$('#pharmacy_prescription_pharmacy_dosage_list_id').val('#{inventory_item.pharmacy_dosage_list_id}');"
        page << "$('#pharmacy_prescription_other_remarks').val('#{inventory_item.other_remarks.to_s}');"
        page << "$('#pharmacy_prescription_course_duration').val('#{inventory_item.course_duration}');"
        page << "$('#pharmacy_prescription_quantity').val('#{inventory_item.quantity}');"
        page << "$('#pharmacy_prescription_pharmacy_course_list_id').val('#{inventory_item.pharmacy_course_list_id}');"
       	 
       	 
       end  
     end
  end

  def pharamacy_item_detail
    unless params[:pharamacy_item_information_id].blank?
  	  @pharmacy_item = PharamacyItemInformationDetail.find_by_pharamacy_item_information_id(params[:pharamacy_item_information_id])

  	  render :update do |page|
        page << "$('pharmacy_prescription_pharmacy_dosage_list_id').value = #{@pharmacy_item.pharmacy_dosage_list_id}"
        page << "$('pharmacy_prescription_other_remarks').value = '#{@pharmacy_item.other_remarks.to_s}'"
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





  private

  def find_appointment
  	@appointment = Appointment.find(params[:appointment_id])
 	end

end
