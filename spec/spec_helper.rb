$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ice'

require 'ice/cube_association'
require 'spec'
require 'spec/autorun'
require 'active_support'

class ChildModel
  def parent
    "parent"
  end

  def parent_id
    15
  end

  def tags
    ["tag1", "tag2"]
  end

  def tag_ids
    [1, 2]
  end

  def children
    []
  end

end


Spec::Runner.configure do |config|
  
end
