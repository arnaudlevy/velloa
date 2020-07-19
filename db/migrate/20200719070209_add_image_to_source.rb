class AddImageToSource < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :image, :text
  end
end
