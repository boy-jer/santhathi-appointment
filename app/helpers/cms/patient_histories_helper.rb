module Cms::PatientHistoriesHelper
  def lab_report_for_prescribed_test(test)
     LaboratoryReport.find_by_prescription_id_and_lab_test_id(test.prescription_id, test.lab_test_id )
  end
end
