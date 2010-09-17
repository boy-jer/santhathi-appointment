class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.string :sample_name
      t.string :description
      t.string :used_in_diagnosis_of

      t.timestamps
    end

    [['Blood','Infertility Genetics and routine biochemistry','Blood sample'],
     ['Urine','Urine sample','Pregnancy and routine biochemistry'],
     ['Semen','Semen sample','Infertility'],
     ['In Person','Personal Approach','Scanning of patient'],
     ['TESTICULAR TISSUE SAMPLE','TESE','T']
    ].map{ |p| Sample.create(:sample_name => p[0],:description => p[1],:used_in_diagnosis_of =>p[2])}

  end

  def self.down
    drop_table :samples
  end
end
