class CreatePartidos < ActiveRecord::Migration[6.0]
  def change
    create_table :partidos do |t|
      t.string :visitante
      t.string :local
      t.float :dividendoLocal
      t.float :dividendoVisitante
      t.float :dividendoEmpate
      t.datetime :fecha
      t.integer :fuente
      t.string :clave

      t.timestamps
    end
  end
end
