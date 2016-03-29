require 'json'
load 'config.rb'

if ARGV[0].match(/:/)
  query_role = ARGV.shift
end
query_hostname = ARGV[0]

json_file = '/var/tmp/mackerel_hosts.json'

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
    hostname = i['name']
    id = i['id']

    roles = []
    i['roles'].each{|s,r| r.each{|q| roles << "#{s}:#{q}"}}
    urls["#{hostname}"] = {
      url:    "https://mackerel.io/orgs/#{@organization}/hosts/#{id}",
      roles:  roles,
    }
  end
end

xmlstring = "<?xml version=\"1.0\"?>\n<items>\n"

urls.each_with_index do |(k, v), i|
  if k.match(%r{[^\/]*#{query_hostname}[^\/]*$}i)
    if v[:roles].grep(%r{#{query_role}}i).empty?
      next
    end
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
