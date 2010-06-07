function link_to(location, default_label, opts) {
  if (! default_label) {
    default_label = location
  }
  label = (opts && opts.label) || default_label
  return "<a href=\"" + location + "\">" + label + "</a>"
}

var NavBar = function (options) {
    for (var option in options) {
        if (options.hasOwnProperty(option)) {
            this[option] = options[option]
        }
    }
}

NavBar.prototype.link_to = function (link, default_label) {
    link_code = link_to(link, default_label)
    if (this.link_wrapper) {
        return this.link_wrapper(link_code)
    } else {
        return "<li>" + link_to(link, default_label) + "</li>"
    }
}


NavBar.prototype.open = function () {
    return this.nav_open || "<ul class=\"linkBar\">"
}

NavBar.prototype.close = function () {
    return this.nav_close || "</ul>"
}

