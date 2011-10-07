class Theme < ActiveRecord::Base

  VALID_BOX_POSITIONS = %w(left right)

  belongs_to :profile

  validates_presence_of :box_pos,              :box_bg_color,  :box_bg_opacity,
                        :name_font_family,     :name_size,     :name_color,
                        :headline_font_family, :headline_size, :headline_color,
                        :bio_font_family,      :bio_size,      :bio_color

  validates_inclusion_of :box_pos, :in => VALID_BOX_POSITIONS
  validates_inclusion_of :name_size, :headline_size, :bio_size, :in => 10..32
  validates_inclusion_of :name_size, :headline_size, :bio_size, :in => 10..32
  validates_format_of :box_bg_color, :name_color, :headline_color, :bio_color, :bg_color_top, :bg_color_bottom,
                      :with => /^#[0-9a-f]{3}[0-9a-f]{3}?$/, :allow_nil => true

  after_create { profile.new_theme_alert! }

  blank_to_nil

  def self.background_images
    YAML::load_file(Rails.root.join('app/assets/images/bg/info.yml'))
  end

  def self.tiled_background_images
    background_images.select { |img| img['format'] == 'tiled' }
  end

  def self.build_image_byline(img)
    img['credit'] + (img['license-short'] ? " (#{img['license-short']})" : '')
  end

  def self.build_random_color
    # FIXME select a random color from a pre-defined list
    # (sometimes the truly random color is UGLY)
    '#' + (1..3).map { (rand(128) + 128).to_s(16) }.join
  end

  def self.build_with_defaults
    theme = Theme.new(
      :box_bg_color         => '#000',
      :box_bg_opacity       => 0.6,
      :name_font_family     => 'Ubuntu',
      :name_size            => 28,
      :name_color           => '#fff',
      :headline_font_family => 'Ubuntu',
      :headline_font_style  => 'italic',
      :headline_size        => 16,
      :headline_color       => '#fff',
      :bio_font_family      => 'Ubuntu',
      :bio_size             => 12,
      :bio_color            => '#777'
    )
  end

  # yes, we're putting style info in the data layer
  # but I've justified it since this is data-driven theming ;-)
  def self.build_random(attributes)
    theme = build_with_defaults
    theme.box_pos           = VALID_BOX_POSITIONS.sample
    if 'color' == %w(color image).sample
      theme.bg_color_top    = build_random_color
      theme.bg_class        = 'light'
    else
      img = tiled_background_images.sample
      theme.bg_image        = "/assets/bg/#{img['filename']}"
      theme.bg_image_byline = build_image_byline(img)
      theme.bg_image_tiled  = img['format'] == 'tiled'
      theme.bg_class        = img['class']
    end
    theme.attributes = attributes
    theme
  end
end
