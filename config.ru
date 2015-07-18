lib = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'lit'
require 'dotenv'
Dotenv.load!

require 'yarp/app'
require 'yarp/initializers/new_relic'

use LIT::Rack::Env do |env|
  if env['REQUEST_URI'].start_with? env['SCRIPT_NAME']
    env['REQUEST_URI'].slice!(0, env['SCRIPT_NAME'].length)
    env['SCRIPT_NAME'] = ''
  end
  env
end

run Yarp::App
