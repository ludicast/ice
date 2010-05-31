$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ice'
require 'ice/cubeable'
require 'ice/cube_association'
require 'ice/base_cube'
require 'spec'
require 'spec/autorun'
require 'active_support'



Spec::Runner.configure do |config|
  
end
