require 'v8'

class Object
  def to_ice
    nil
  end
end

[FalseClass, TrueClass, Numeric, String].each do |cls|
  cls.class_eval do
    def to_ice
      self
    end
  end
end

class Array
  def to_ice
    map &:to_ice
  end
end

class Hash
  def to_ice
    res = {}
    each_pair do |key,value|
      res[key] = value.to_ice
    end
    res
  end
end

module Ice
  def self.add_routes(env)
    Ice::BaseCube.subclasses.map(&:name).each do |name|
      name = name.sub(/Cube/, "")
      name = name[0].downcase + name[1..-1]

      env[name.pluralize + "Path"] = lambda do
        "/#{name.tableize}"
      end

    end
  end

  def self.add_helper_functions(env)
    add_routes env
    env["linkTo"] = lambda do |label, link|
      if (! link)
		    link = label
	    end
	    %{<a href="#{link}">#{label}</a>}
    end

    env["navBar"] = lambda do |yield_func|
      ctx = {}
      ctx['linkTo'] = lambda do |label, link = nil|
        env["linkTo"].call label, link
      end
      body = yield_func.call(ctx)
      %{<ul class="linkBar">#{body}</ul>}
    end
  end

 def self.convert_template(template_text, vars = {})
   env = {}
   vars.each_pair do |key, value|
     env[key] = value.to_ice
   end
    add_helper_functions env
    require 'eco'
    Eco.render template_text, env
  end

end

