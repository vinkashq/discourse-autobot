TwitterApi.instance_eval do

  protected

  def user_timeline_uri_for(params)
    url = "#{BASE_URL}/1.1/statuses/user_timeline.json?screen_name=#{params[:screen_name]}&count=50&include_rts=false&exclude_replies=true"
    url = "#{url}&since_id=#{params[:since_id]}" if params[:since_id].present?

    URI.parse url
  end

  unless defined? BASE_URL
    BASE_URL = 'https://api.twitter.com'.freeze
  end

end
