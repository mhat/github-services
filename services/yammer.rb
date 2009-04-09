service :yammer do |data, payload|

  ## github-services consumer key and secret, which isn't going to be all that secret
  ##
  consumer_key    = 'K93NMh99lQwl39ZToM6fSw'
  consumer_secret = 'Dk0pMvC155Vg9GqpesITjAbVJPj3h7Sfig7wW6F5Y'

  ## some users access key and  secret, which also will not be terribly secret what 
  ## with them most likely being sent plaintext from github to a sites instance of
  ## github-services. 
  ##
  access_key      = data['access_key']
  access_secret   = data['access_secret']

  repository      = payload['repository']['name']
  yammer_base     = "https://www.yammer.com"
  yammer_messages = "/api/v1/messages/"

  ## this could probably stand to do something reasonable if, for example, there was
  ## some OAuth error ... perhaps if the access key/secret were wrong.
  ##
  consumer        = OAuth::Consumer.new(consumer_key, consumer_secret, :site => yammer_base)
  access_token    = OAuth::AccessToken.new(consumer, access_key, access_secret)
 
  ## foreach commit yammer-away!
  ## 
  payload['commits'].each do |commit|
    status   = "[#{repository}] #{commit['author']['name']} - #{commit['message']} - #{ commit['url']}"
    response = access_token.post(yammer_messages, { 'body' => status });
  end
  
end
