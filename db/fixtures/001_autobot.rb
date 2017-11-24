autobot_username = 'autobot'
user = User.find_by(id: -3)

if !user
  suggested_username = UserNameSuggester.suggest(autobot_username)

  UserEmail.seed do |ue|
    ue.id = -3
    ue.email = "autobot_email"
    ue.primary = true
    ue.user_id = -3
  end

  User.seed do |u|
    u.id = -3
    u.name = autobot_username
    u.username = suggested_username
    u.username_lower = suggested_username.downcase
    u.password = SecureRandom.hex
    u.active = true
    u.approved = true
    u.trust_level = TrustLevel[4]
  end

  # # TODO Design a unique bot icon
  # if !Rails.env.test?
  #   begin
  #     UserAvatar.import_url_for_user(
  #       "",
  #       User.find(-3),
  #       override_gravatar: true
  #     )
  #   rescue
  #     # In case the avatar can't be downloaded, don't fail seed
  #   end
  # end
end

bot = User.find(-3)

bot.user_option.update!(
  email_private_messages: false,
  email_direct: false
)

if !bot.user_profile.bio_raw
  bot.user_profile.update!(
    bio_raw: I18n.t('autobot.bio', site_title: SiteSetting.title, autobot_username: bot.username)
  )
end

Group.user_trust_level_change!(-3, TrustLevel[4])
