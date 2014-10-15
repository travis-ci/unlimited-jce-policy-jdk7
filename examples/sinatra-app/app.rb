require 'java'
require 'sinatra'
require 'base64'

require 'unlimited-jce-policy-jdk7'

before do
  jce = java.lang.Class.for_name('javax.crypto.JceSecurity')
  field = jce.get_declared_field('isRestricted')
  field.accessible = true
  headers['Jce-Restricted'] = field.get(nil).to_s
end

get '/' do
  aes = OpenSSL::Cipher::AES.new(256, :CBC)
  aes.encrypt
  aes.key = 'notasecretnotevenalittlebitnopenope'
  aes.iv = 'thisisnotasecreteitherjustforgetit'

  raw = aes.update(headers.to_s + params.to_s + Time.now.utc.to_s) + aes.final
  Base64.strict_encode64(raw)
end

delete '/' do
  Thread.new do
    sleep 1
    Process.kill(:TERM, Process.pid)
  end
  "so long!\n"
end
