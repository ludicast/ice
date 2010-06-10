function humanize(name) {
  match = name.match(/(.*)_id$/)
  if (match) {
      name = match[1]
  }

  return name.split('_').join(' ') 
}

function label_tag(name, opts) {
    label = ((typeof opts == 'string') && opts) || humanize(name)
    class_string = (opts && opts['class'] && "class=\"" + opts['class'] + "\" ") || ""
    return "<label "+ class_string + "for=\"" + name + "\">" + label.charAt(0).toUpperCase() + label.substr(1) + "</label>"
}