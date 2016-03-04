require 'json'
load 'config.rb'

# refs http://blog.mah-lab.com/2014/07/10/sudden-death-workflow/
thequery  = ARGV[0].dup.force_encoding('utf-8')
json_file = '/var/tmp/mackerel_dashboards.json'

begin
  result = open(json_file) do |io|
    JSON.load(io)
  end
rescue
  puts "#{json_file} not found."
  exit
end

urls = {}

result.each_value do |v|
  v.each do |i|
    title = i['title']
    urlPath = i['urlPath']
    urls["#{title}"] = {
      url: "https://mackerel.io/orgs/#{@organization}/dashboards/#{urlPath}"
    }
  end
end

xmlstring = "<?xml version=\"1.0\"?>\n<items>\n"

urls.each_with_index do |(k, v), i|
  if k.match(%r{[^\/]*#{thequery}[^\/]*$}i)
    thisxmlstring = "\t<item uid=\"#{i}\" autocomplete=\"#{k}\" arg=\"#{v[:url]}\" valid=\"YES\">
    <title>#{k}</title>
    <subtitle>#{v[:url]}</subtitle>
    </item>\n"
    xmlstring += thisxmlstring
  else
    next
  end
end

xmlstring += '</items>'

puts xmlstring
