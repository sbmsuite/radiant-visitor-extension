# Uncomment this if you reference any of your controllers in activate
# require_dependency "application_controller"
require "radiant-visitor-extension"
require "user-model-extension"

class VisitorExtension < Radiant::Extension
  version     RadiantVisitorExtension::VERSION
  description RadiantVisitorExtension::DESCRIPTION
  url         RadiantVisitorExtension::URL

  # See your config/routes.rb file in this extension to define custom routes

  extension_config do |config|
    # config is the Radiant.configuration object
  end

  def activate
    User.send(:include, UserModelExtension)
  end
end
