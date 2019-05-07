class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads do |t|
      t.string :title
      t.string :contents
      t.string :result
      t.string :persons_id_upd

      t.timestamps
    end
  end
end
