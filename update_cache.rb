require 'json'
require 'uri'
require 'net/http'
load 'config.rb'

%w(
  hosts
  dashboards
).each do |path|
  endpoint         = "https://mackerel.io/api/v0/#{path}"
  uri              = URI.parse("#{endpoint}")
  https            = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl    = true
  req              = Net::HTTP::Get.new(uri.request_uri)
  req["X-Api-Key"] = "#{@apikey}"
  req['Accept']    = 'application/json'
  res              = https.request(req)

  if res.code == '200'
    File.write("/var/tmp/mackerel_#{path}.json", res.body)
    puts "Success. Update Mackerel #{path} URLs Cache."
  else
    puts "#{res.message}"
  end
end
