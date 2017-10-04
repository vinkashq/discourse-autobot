require_dependency 'yt'

if SiteSetting.autobot_enabled? && SiteSetting.google_api_server_key.present?
  Yt.configure do |config|
    config.api_key = SiteSetting.google_api_server_key
  end
end

DiscourseEvent.on(:site_setting_saved) do |sitesetting|
  isEnabledSetting = sitesetting.name == 'autobot_enabled'
  isGoogleApiServerKey =  sitesetting.name == 'google_api_server_key'

  if (isEnabledSetting || isGoogleApiServerKey)
    enabled = isEnabledSetting ? sitesetting.value == 't' : SiteSetting.autobot_enabled
    if enabled
      Yt.configure do |config|
        config.api_key = SiteSetting.google_api_server_key
      end
    end
  end
end
