# Returns sauce username if env is set and not empty.
# If env isn't defined then nil is returned.
def sauce_user
  env = ENV['SAUCE_USERNAME']
  (env && !env.empty?) ? env : nil
end

# Returns sauce key if env is set and not empty.
# If env isn't defined then nil is returned.
def sauce_key
  env = ENV['SAUCE_ACCESS_KEY']
  (env && !env.empty?) ? env : nil
end

# Returns true if both sauce user and sauce key are defined.
# Returns false if they're not defined.
def sauce?
  !!(sauce_user && sauce_key)
end

# Returns true if env is set and not empty
# Returns false if env is not set or empty.
def jenkins?
  env = ENV['JENKINS_SERVER_COOKIE']
  env && !env.empty?
end

Sauce.config do |config|
  start_tunnel    = false
  #start_tunnel    = sauce? && !jenkins?
  #sauce_connect_4 = File.expand_path('../sauce)connect/sc-sc4.3.8-osx/bin/sc', __FILE__)

  puts "tunnel? #{start_tunnel}"
  puts " sauce? #{sauce?}"

  config[:start_local_application]    = false
  config[:start_tunnel]               = false
  #config[:sauce_connect_4_executable] = sauce_connect_4

  config['screen-resolution']         = '1280x1024'

  config[:browsers] = [
    ["OS X 10.10", "Chrome", "45.0"],
    ["Windows 7", "Firefox", "39.0"],
  ]
end
