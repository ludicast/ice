function link_to(location, default_label, opts) {
  if (! default_label) {
    default_label = location
  }
  label = (opts && opts.label) || default_label
  return "<a href=\"" + location + "\">" + label + "</a>"
}

var NavBar = function (options) {
    var defaults = NavBar.default_options
    for (var default_option in defaults) {
        if (defaults.hasOwnProperty(default_option)) {
            this[default_option] = defaults[default_option]
        }
    }

    for (var option in options) {
        if (options.hasOwnProperty(option)) {
            this[option] = options[option]
        }
    }
}

NavBar.prototype.link_to = function (link, default_label) {
    link_code = link_to(link, default_label)

    if (this.link_wrapper) {
        link_data =  this.link_wrapper(link_code)
    } else {
        link_data = "<li>" + link_to(link, default_label) + "</li>"
    }
    if (this.link_data && this.separator) {
      link_data = this.separator + link_data  
    }
    this.link_data = link_data
    return link_data;
}


NavBar.prototype.open = function () {
    return this.nav_open || "<ul class=\"linkBar\">"
}

NavBar.prototype.close = function () {
    return this.nav_close || "</ul>"
}

NavBar.default_options = {}