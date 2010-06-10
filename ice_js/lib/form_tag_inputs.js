function humanize(name) {
  match = name.match(/(.*)_id$/)
  if (match) {
      name = match[1]
  }

  return name.split('_').join(' ') 
}

function get_type_value(type, opts){
    switch (type) {
      case "disabled":
        return opts[type] ? "disabled" : ""
    }
    return opts[type]
}

function get_attribute_string(type, opts) {
   // var opts
  //  if (typeof arguments[1] == 'string') {
    //    value = arguments[1]
    //    opts = arguments[2]
   // } else {
      //  opts = arguments[1]
       // value = opts[type]
   // }
    return (opts && opts[type] && type + "=\"" + get_type_value(type,opts) + "\" ") || ""
}

function get_size_string(opts) {
    return get_attribute_string('size', opts)
}

function get_class_string(opts) {
    return get_attribute_string('class', opts)
}

function get_disabled_string(opts) {
    return get_attribute_string('disabled', opts)
}

function get_maxlength_string(opts) {
    return get_attribute_string('maxlength', opts)
}

function label_tag(name, opts) {
    label = ((typeof opts == 'string') && opts) || humanize(name)
    class_string = get_class_string(opts)
    return "<label "+ class_string + "for=\"" + name + "\">" + label.charAt(0).toUpperCase() + label.substr(1) + "</label>"
}

function password_field_tag(name) {

    value = ((typeof arguments[1] == 'string') && "value=\"" + arguments[1] + "\" ") || ""
    opts = arguments[2] || arguments[1]
    class_string = get_class_string(opts)
    size_string = get_size_string(opts)
    disabled_string = get_disabled_string(opts)
    maxlength_string = get_maxlength_string(opts)
    return "<input "+ disabled_string + class_string +"id=\"" + name +"\" " + maxlength_string + "name=\"" + name +"\" " + size_string + "type=\"password\" " + value + "/>"
}