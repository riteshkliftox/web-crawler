class CreateWebsites < ActiveRecord::Migration[6.0]
  def change
    create_table :websites do |t|
      t.string :name
      t.string :host_url
      t.string :sub_links, array: true, default: []
      t.integer :total_sub_links

      t.timestamps
    end
  end
end
