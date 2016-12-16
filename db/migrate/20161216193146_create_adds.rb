class CreateAdds < ActiveRecord::Migration
  def change
    create_table :adds do |t|
      t.integer :add_count
      t.references :user, index: true
      t.references :song, index: true

      t.timestamps
    end
  end
end
