# name: autobot
# about: Automatic content creator bot for Discourse
# version: 0.0.1
# authors: Vinoth Kannan (@vinothkannans)
# url: https://github.com/vinkashq/discourse-autobot

enabled_site_setting :autobot_enabled

register_asset "stylesheets/admin/autobot.scss", :admin

after_initialize do
  SeedFu.fixture_paths << Rails.root.join("plugins", "autobot", "db", "fixtures").to_s

  [
    '../lib/autobot/store.rb',
    '../lib/autobot/campaign.rb',
    '../app/controllers/autobot/campaigns.rb'
  ].each { |path| load File.expand_path(path, __FILE__) }

  module ::Autobot
    PLUGIN_NAME = "autobot".freeze

    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace Autobot
    end
  end

  Autobot::Engine.routes.draw do
    get "/campaigns" => "campaigns#list", constraints: StaffConstraint.new
    post "/campaigns" => "campaigns#create", constraints: StaffConstraint.new
    put "/campaigns" => "campaigns#update", constraints: StaffConstraint.new
    delete "/campaigns" => "campaigns#delete", constraints: StaffConstraint.new
  end

  Discourse::Application.routes.prepend do
    mount Autobot::Engine, at: "/autobot"
  end

  add_admin_route "autobot.title", "autobot"

  Discourse::Application.routes.append do
    get "/admin/plugins/autobot" => "admin/plugins#index", constraints: StaffConstraint.new
    get "/admin/plugins/autobot/:page" => "admin/plugins#index", constraints: StaffConstraint.new
  end
end
