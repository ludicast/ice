function view_path(item) {
  return "/" + item.class_path + "/" + item.id
}

function edit_path(item) {
  return "/" + item.class_path + "/" + item.id + "/edit"
}

function view_link(item, opts) {
  label = (opts && opts.label) || "View"
  return "<a href=\"" + view_path(item) + "\">" + label + "</a>"
}

function edit_link(item, opts) {
  label = (opts && opts.label) || "Edit"
  return "<a href=\"" + edit_path(item) + "\">" + label + "</a>"
}

function index_link(table, opts) {
  label = (opts && opts.label) || "List"
  return "<a href=\"/" + table + "\">" + label + "</a>"
}