module Setting
  # This module loaded pre-application; it cannot use Rails.root or really any Rails facilities
  SETTINGS = YAML::load(File.read(File.expand_path('../../../config/settings.yml', __FILE__)))

  def s(key)
    key.split('.').inject(SETTINGS) { |h, k| h[k] }
  end
  module_function :s
end
