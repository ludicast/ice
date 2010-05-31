$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require File.dirname(__FILE__) + "/../init"
require 'spec'
require 'spec/autorun'
require 'active_support'



Spec::Runner.configure do |config|
  
end
