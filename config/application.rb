require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DockerTestBlogApp4
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Psychの設定を追加
    config.before_configuration do
      path = File.join(Rails.root, 'config', 'database.yml')
      config.database_configuration = YAML.load(ERB.new(File.read(path)).result, aliases: true)
    end
  end
end
