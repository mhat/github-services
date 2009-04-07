service :yammer do |data, payload|
  yammer_base     = "https://www.yammer.com"
  yammer_messages = "/api/v1/messages/"
  repository      = payload['repository']['name']
  
  consumer_key    = data['consumer_key']
  consumer_secret = data['consumer_secret']
  access_key      = data['access_key']
  access_secret   = data['access_secret']
  
  consumer     = OAuth::Consumer.new(consumer_key, consumer_secret, :site => yammer_base)
  access_token = OAuth::AccessToken.new(consumer, access_key, access_secret)
  
  payload['commits'].each do |commit|
    status   = "[#{repository}] #{commit['author']['name']} - #{commit['message']} - #{ commit['url']}"
    
    response = access_token.post(yammer_messages, {
      'body' => status
    });
  end
  
end
