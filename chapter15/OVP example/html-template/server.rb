require 'rubygems'
require 'mongrel'
require 'net/http'
require 'uri'

# Usage: ruby server <host> </host><port> </port><docroot>
host    = ARGV[0] || "127.0.0.1"
port    = ARGV[1] || 3333
docroot = ARGV[2] || "./"



# Logging DirHandler
class LoggingDirHandler < Mongrel::DirHandler
  def process(request, response)
    super
    puts "#{request.params["REQUEST_PATH"]}   #{response.status}"
  end
end



# Configure Mongrel and handlers
config = Mongrel::Configurator.new :host => host, :port => port do
  listener do
    uri "/",  :handler => LoggingDirHandler.new(docroot)
  end
  # CTRL+C to stop server
  trap("INT") { stop }
  run
end


# Start Mongrel
puts "Mongrel listening on '#{host}:#{port}', serving documents from '#{docroot}'."
config.join
