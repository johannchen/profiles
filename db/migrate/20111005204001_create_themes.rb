class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.integer :profile_id
      t.string  :bg_image,              :limit => 255
      t.boolean :bg_image_tiled,                      :default => false
      t.string  :bg_image_byline,       :limit => 100
      t.string  :bg_class,              :limit => 25
      t.string  :bg_color_top,          :limit => 7
      t.string  :bg_color_bottom,       :limit => 7
      t.string  :box_pos,               :limit => 25
      t.string  :box_bg_color,          :limit => 7
      t.float   :box_bg_opacity
      t.string  :name_font_family,      :limit => 50
      t.string  :name_font_weight,      :limit => 10
      t.string  :name_font_style,       :limit => 10
      t.string  :name_font_variant,     :limit => 10
      t.integer :name_line_height
      t.integer :name_size
      t.string  :name_color,            :limit => 7
      t.string  :headline_font_family,  :limit => 50
      t.string  :headline_font_weight,  :limit => 10
      t.string  :headline_font_style,   :limit => 10
      t.string  :headline_font_variant, :limit => 10
      t.integer :headline_line_height
      t.integer :headline_size
      t.string  :headline_color,        :limit => 7
      t.string  :bio_font_family,       :limit => 50
      t.string  :bio_font_weight,       :limit => 10
      t.string  :bio_font_style,        :limit => 10
      t.string  :bio_font_variant,      :limit => 10
      t.integer :bio_line_height
      t.integer :bio_size
      t.string  :bio_color,             :limit => 7
      t.timestamps
    end
  end
end
