function link_to(location, default_label, opts) {
  if (! default_label) {
    default_label = location
  }
  label = (opts && opts.label) || default_label
  return "<a href=\"" + location + "\">" + label + "</a>"
}

var NavBar = function () {

}

NavBar.prototype.link_to = function (link) {
  return "<li>" + link_to(link) + "</li>"
}

NavBar.prototype.open = function () {
    return "<ul class=\"linkBar\">"
}

NavBar.prototype.close = function () {
    return "</ul>"
}

