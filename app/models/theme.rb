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

  attr_protected :profile_id, :created_at, :updated_at

  after_create { profile.new_theme_alert! }

  blank_to_nil

  # filename or info hash
  def bg_image=(filename)
    if filename.to_s.blank?
      info = {}
    elsif filename.is_a?(String)
      info = self.class.backgrounds_by_filename[filename] 
    else
      info = filename
    end
    write_attribute(:bg_image, info['filename'])
    self.bg_image_name   = info['name']
    self.bg_image_byline = info['credit'].to_s + (info['license-short'] ? " (#{info['license-short']})" : '')
    self.bg_image_tiled  = info['format'] == 'tiled'
    self.bg_class        = info['class']
    self.box_pos         = info['box_pos']
  end

  def bg_color_top=(color)
    write_attribute(:bg_color_top, color)
    self.bg_class = nil
  end

  class << self
    extend ActiveSupport::Memoizable

    def build_with_defaults
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
        :bio_color            => '#fff'
      )
    end

    def build_random
      if 'color' == %w(color image).sample
        build_random_color
      else
        build_from_image_info(backgrounds[:tiled].sample)
      end
    end

    def build_random_color
      build_with_defaults.tap do |theme|
        theme.bg_color_top = '#' + (1..3).map { (rand(128) + 128).to_s(16) }.join
        theme.bg_class     = 'light'
        theme.box_pos      = VALID_BOX_POSITIONS.sample
      end
    end

    def build_from_image_info(info)
      build_with_defaults.tap do |theme|
        theme.bg = info
      end
    end

    def image_info
      YAML::load_file(Rails.root.join('app/assets/images/bg/info.yml'))
    end

    memoize :image_info

    def backgrounds
      {
        scaled: image_info.select { |bg| bg['format'] != 'tiled' },
        tiled:  image_info.select { |bg| bg['format'] == 'tiled' }
      }
    end

    def backgrounds_by_filename
      image_info.each_with_object({}) { |bg, h| h[bg['filename']] = bg }
    end
  end
end
