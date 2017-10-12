if SiteSetting.autobot_enabled? && SiteSetting.google_api_server_key.present?
  Autobot::Youtube::Provider.configure
end

DiscourseEvent.on(:site_setting_saved) do |sitesetting|
  isEnabledSetting = sitesetting.name == 'autobot_enabled'
  isGoogleApiServerKey =  sitesetting.name == 'google_api_server_key'

  if (isEnabledSetting || isGoogleApiServerKey)
    enabled = isEnabledSetting ? sitesetting.value == 't' : SiteSetting.autobot_enabled
    if enabled
      Scheduler::Defer.later("Configure YT") do
        Autobot::Youtube::Provider.configure
      end
    end
  end
end
