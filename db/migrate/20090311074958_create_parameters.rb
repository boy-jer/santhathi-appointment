class CreateParameters < ActiveRecord::Migration
  def self.up
    create_table :parameters do |t|
      t.string :parameter_name
      t.string :value_type
      t.string :measurement_unit
      t.string :description

      t.timestamps
    end

    [['Hb', 'Text','GMS%', 'Hb'],
     ['LIQUIFACTION', 'Multiple', 'min', 'count'],
     ['Motility','Numeric','ml','Motility'],
     ['APPEARANCE','Multiple','None[T]','SA'],
     ['VOLUME','Numeric','ml', 'SA'],
     ['VISCOSITY','Multiple','None[T]','SA'],
     ['PH','Multiple','nmol/L','SA'],
     [ 'SPERM CONCENTRATION','Text','mil/ml','SA'],
     ['AGGLUTINATION','Multiple','None[T]','SA'],
     ['CLUMPING','Multiple','None[T]','SA']
    ].map {|p|
               Parameter.create(:parameter_name => p[0],:value_type => p[1],:measurement_unit =>p[2],:description => p[3])

    }

  end

  def self.down
    drop_table :parameters
  end
end
