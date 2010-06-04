function view_path(item) {
  return "/" + item.class_path + "/" + item.id
}

function edit_path(item) {
  return "/" + item.class_path + "/" + item.id + "/edit"
}

function view_link(item, opts) {
  return link_to(view_path(item), "View", opts)
}

function edit_link(item, opts) {
  return link_to(edit_path(item), "Edit", opts)
}

function index_link(table, opts) {
  return link_to("/" + table, "List", opts)
}

function link_to(location, default_label, opts) {
  label = (opts && opts.label) || default_label
  return "<a href=\"" + location + "\">" + label + "</a>"
}


var NavBar = function () {

    

}

NavBar.prototype.link_to = function (link) {
  return "<li>" + link + "</li>"
}

NavBar.prototype.open = function () {
    return "<ul class=\"linkBar\">"
}

NavBar.prototype.close = function() {
    return "</ul>"
}