class CreatePartidos < ActiveRecord::Migration[6.0]
  def change
    create_table :partidos do |t|
      t.string :visitante
      t.string :local
      t.float :dividendoLocalSM
      t.float :dividendoVisitanteSM
      t.float :dividendoEmpateSM
      t.float :dividendoLocalBet
      t.float :dividendoVisitanteBet
      t.float :dividendoEmpateBet
      t.datetime :fecha
      t.string :clave

      t.timestamps
    end
  end
end
