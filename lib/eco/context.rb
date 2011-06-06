module Eco

  class Context < Hash

    def initialize(hash)
      add_routes
      add_links
      add_nav_bar
      hash.each_pair do |key, value|
        self[key] = value.to_ice
      end
    end

    private

    def add_routes
      Ice::BaseCube.subclasses.map(&:name).each do |cube_model_name|
        model_name = cube_model_name.sub(/Cube/, "")
        name = model_name[0].downcase + model_name[1..-1]

        self["edit" + model_name + "Path"]= lambda do |object|
          "/#{name.tableize}/#{object.id}/edit"
        end

        self["new" + model_name + "Path"]= lambda do
          "/#{name.tableize}/new"
        end

        self[name + "Path"]= lambda do |object|
          "/#{name.tableize}/#{object.id}"
        end

        self[name.pluralize + "Path"]= lambda do
          "/#{name.tableize}"
        end

      end
    end

    def add_links
      self["linkTo"] = lambda do |label, link|
        if (!link)
          link = label
        end
        %{<a href="#{link}">#{label}</a>}
      end
    end

    def try_config(opts, var, config_class)
      opts.first.try(var) ||
          config_class.try(:[], var)
    end

    def try_nav_config(opts, sym)
      try_config opts, sym, NavBarConfig
    end

    def add_nav_bar


      self["navBar"] = lambda do |*opts, yield_func|
        nav_prefix = try_nav_config(opts, :nav_prefix) || '<ul class="linkBar">'
        nav_postfix = try_nav_config(opts, :nav_postfix) || '</ul>'
        link_prefix = try_nav_config(opts, :link_prefix) || '<li>'
        link_postfix = try_nav_config(opts, :link_postfix) || '</li>'
        ctx = {}
        ctx['linkTo'] = lambda do |label, link = nil|
          "#{link_prefix}#{self["linkTo"].call label, link}#{link_postfix}"
        end
        body = yield_func.call(ctx)
        %{#{nav_prefix}#{body}#{nav_postfix}}
      end
    end
  end
end