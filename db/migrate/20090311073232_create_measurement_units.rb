class CreateMeasurementUnits < ActiveRecord::Migration
  def self.up
    create_table :measurement_units do |t|
      t.string :name
      t.string :abbreviation
      t.string :description

      t.timestamps
    end

    [['ml','ml','Blood samples'],
     ['g/dl','g/dl','hb'],
     ['mg/dl','mg/dl','blood sugar blood urea'],
     ['mIU/ml','mIU/ml','FSH LH BETA HCG'],
     ['ng/ml','ng/ml','PRL,T3'],
     ['mil/ml','mil/ml','SA'],
     ['nmol/L','nmol/L','TESTOSTERONE'],
     ['%','%','percentage'],
     ['min','min','semen analysis'],
     ['pg/ml','pg/ml','e2']
    ].map { |p| MeasurementUnit.create(:name =>p[0],:abbreviation=>p[1],:description=>p[2])

           }

  end

  def self.down
    drop_table :measurement_units
  end
end
