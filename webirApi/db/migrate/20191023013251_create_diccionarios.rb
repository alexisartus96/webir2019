class CreateDiccionarios < ActiveRecord::Migration[6.0]
  def change
    create_table :diccionarios do |t|
      t.string :clave
      t.string :valor

      t.timestamps
    end
  end
end
