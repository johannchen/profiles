require 'yaml'

namespace :profiles do
  namespace :heroku do
    task :config, :onecmd do |t, args|
      settings = YAML::load_file(File.expand_path('../../../config/settings.yml', __FILE__))
      flattened = Setting.flatten_settings(settings).map { |k, v| "#{k}=\"#{v.to_s.gsub(/"/, "\\\"")}\"" }
      if args[:onecmd]
        puts "Copy and paste the following command (make sure there are no line breaks):"
        puts "heroku config:add #{flattened.join(' ')}"
      else
        puts "Copy and paste the following commands:"
        puts flattened.map { |s| "heroku config:add #{s}" }.join("\n")
      end
    end
  end
end
