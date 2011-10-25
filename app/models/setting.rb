module Setting
  # This module loaded pre-application; it cannot use Rails.root or really any Rails facilities
  FILENAME = File.expand_path('../../../config/settings.yml', __FILE__)

  def from_file?
    File.exist?(FILENAME)
  end
  module_function :from_file?

  def flatten_settings(settings)
    flattened = {}
    settings.each do |section, section_settings|
      section_settings.each do |name, value|
        flattened["#{section.upcase}_#{name.upcase}"] = value
      end
    end
    flattened
  end
  module_function :flatten_settings

  SETTINGS = from_file? ? flatten_settings(YAML::load(File.read(FILENAME))) : ENV

  def s(key)
    SETTINGS[key.upcase.gsub(/\./, '_')]
  end
  module_function :s
end
