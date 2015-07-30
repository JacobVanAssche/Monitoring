# This script reads CSV fax files and writes the metrics collected to openTSDB

require 'csv'
require 'net/http'
require 'time'
require 'rubygems'
require 'json'

openTSDB_host = '10.8.101.33'
openTSDB_port = '4242'

@csv_file_name = ""

# Get the CSV file name from the command line
unless ARGV.length == 1
	puts "Invalid number of arguments!"
	exit
end

ARGV.each do |arg|
	@csv_file_name = arg
end


# Function for creating the body to send in the POST request
def build_body(metric, timestamp, value)
  {
    "metric" => metric,
    "timestamp" => timestamp,
    "value" => value,
    "tags" => { "status" => "test" }
  }.to_json
end

def check_response(response)
  case response
  when Net::HTTPSuccess then
    puts response
  when Net::HTTPRedirection then
    location = response['location']
    warn "redirected to #{location}"
    fetch(location, limit - 1)
  else
    puts response.value
  end
end

# Create metrics in openTSDB via mkmetric
#path_to_csv = '/ruby_scripts'

# Get names of all CSV files in the directory
#csv_file_names = Dir["#{path_to_csv}/*.csv"]

# Loop through all CSV files
#csv_file_names.each do |csv|
#puts "Started reading CSV file #{csv}"
# Loop through each row of the CSV file
CSV.foreach(@csv_file_name) do |row|
	# Split the row on tab
	fields = row[0].split(/\t/)
	
	time = fields[0]
	send_recv = fields[1]
	speed = fields[2]
	seconds = fields[3]
	pages = fields[4]
	
	# Convert ISO 8601 to UNIX timestamp because openTSDB accepts UNIX timestamps
	time = Time.iso8601(time.sub(/ /, 'T')).to_i
	# Convert speed to actual fax speed using a magic formula
	speed = ((((speed.to_i >> 3) & 15) + 1) * 2400).to_s
	# Convert seconds to minutes
	minutes = seconds.to_i/60.0
	
	pages_metric = "fax.pages"
	minutes_metric = "fax.minutes"
	speed_metric = "fax.speed"
	
	# Format the metric according to SEND or RECV
	if send_recv == "SEND"
		pages_metric += '.send'
		minutes_metric += '.send'
		speed_metric += '.send'
	elsif send_recv == "RECV"
		pages_metric += '.recv'
		minutes_metric += '.recv'
		speed_metric += '.recv'
	end
	
	http = Net::HTTP.new(openTSDB_host, openTSDB_port)
	request =  Net::HTTP::Post.new("/api/put")
	request.add_field('Content-Type', 'application/json')
	
	# Send request for pages
	request.body = build_body(pages_metric, time, pages)
	response = http.request(request)
	#check_response(response)
	
	# Send request for minutes
	request.body = build_body(minutes_metric, time, minutes)
	response = http.request(request)
	#check_response(response)
	
	# Send request for speed
	request.body = build_body(speed_metric, time, speed)
	response = http.request(request)
	#check_response(response)
	
end

#end

puts "All done!"

	
		
			

