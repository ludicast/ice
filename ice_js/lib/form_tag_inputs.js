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
      case "checked":
        return opts[type] ? "checked" : ""
    }
    return opts[type]
}

function get_attribute_string(type, opts) {
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

function get_checked_string(opts) {
    return get_attribute_string('checked', opts)
}

function get_maxlength_string(opts) {
    return get_attribute_string('maxlength', opts)
}

function label_tag(name, opts) {
    label = ((typeof opts == 'string') && opts) || humanize(name)
    class_string = get_class_string(opts)
    return "<label "+ class_string + "for=\"" + name + "\">" + label.charAt(0).toUpperCase() + label.substr(1) + "</label>"
}

var BaseInputTag = function(tag_type) {
   this.tag_type = tag_type
}

BaseInputTag.prototype.render = function () {
  return "<input "+ this.checked_string + this.disabled_string + this.class_string +"id=\"" + this.name +"\" " + this.maxlength_string + "name=\"" + this.name +"\" " + this.size_string + "type=\"" + this.tag_type + "\" " + this.value + "/>"
}

BaseInputTag.prototype.set_opts = function () {
    this.class_string = get_class_string(opts)
    this.size_string = get_size_string(opts)
    this.disabled_string = get_disabled_string(opts)
    this.maxlength_string = get_maxlength_string(opts)
}


function password_field_tag(name) {
    tag = new BaseInputTag("password")
    tag.name = name
    tag.value = ((typeof arguments[1] == 'string') && "value=\"" + arguments[1] + "\" ") || ""
    opts = arguments[2] || arguments[1]


    tag.set_opts(opts)
    tag.checked_string = ""
    return tag.render()

}

function check_box_tag(name) {
    tag = new BaseInputTag("checkbox")
    tag.name = name
    tag.value = "value=\"" + (((typeof arguments[1] == 'string') && arguments[1]) || 1) + "\" "
    tag.checked_string = (arguments[2] === true) ? "checked=\"checked\" " : ""
    
    opts = arguments[2] || arguments[1]



    tag.set_opts(opts)
    return tag.render()
}