module Laboratory::PrescribedTestsHelper
  
  def lab_report_for_prescribed_test(test)
     LaboratoryReport.find_by_prescription_id_and_service_id(test.prescription_id, test.service_id )
  end

end
