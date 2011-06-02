var BaseInputTag, check_box_tag, get_attribute_string, get_checked_string, get_class_string, get_disabled_string, get_maxlength_string, get_size_string, get_type_value, humanize, label_tag, password_field_tag;
humanize = function(name) {
  var match;
  match = name.match(/(.*)_id$/);
  if (match) {
    name = match[1];
  }
  return name.split('_').join(' ');
};
get_type_value = function(type, opts) {
  var _ref;
  switch (type) {
    case "disabled":
      if (opts[type]) {
        return "disabled";
      } else {
        return "";
      }
      break;
    case "checked":
      return (_ref = opts[type]) != null ? _ref : {
        "checked": ""
      };
      break;
    default:
      return opts[type];
  }
};
get_attribute_string = function(type, opts) {
  return (opts && opts[type] && type + "=\"" + get_type_value(type, opts) + "\" ") || "";
};
get_size_string = function(opts) {
  return get_attribute_string('size', opts);
};
get_class_string = function(opts) {
  return get_attribute_string('class', opts);
};
get_disabled_string = function(opts) {
  return get_attribute_string('disabled', opts);
};
get_checked_string = function(opts) {
  return get_attribute_string('checked', opts);
};
get_maxlength_string = function(opts) {
  return get_attribute_string('maxlength', opts);
};
label_tag = function(name, opts) {
  var class_string, label;
  label = typeof opts === 'string' ? opts : humanize(name);
  class_string = get_class_string(opts);
  return "<label " + class_string + "for=\"" + name + "\">" + (label.charAt(0).toUpperCase()) + (label.substr(1)) + "</label>";
};
BaseInputTag = (function() {
  function BaseInputTag(tag_type) {
    this.tag_type = tag_type;
  }
  BaseInputTag.prototype.render = function() {
    return "<input " + this.checked_string + this.disabled_string + this.class_string + "id=\"" + this.name + "\" " + this.maxlength_string + "name=\"" + this.name + "\" " + this.size_string + "type=\"" + this.tag_type + "\" " + this.value + "/>";
  };
  BaseInputTag.prototype.set_opts = function(opts) {
    this.class_string = get_class_string(opts);
    this.size_string = get_size_string(opts);
    this.disabled_string = get_disabled_string(opts);
    return this.maxlength_string = get_maxlength_string(opts);
  };
  return BaseInputTag;
})();
password_field_tag = function(name) {
  var opts, tag;
  tag = new BaseInputTag("password");
  tag.name = name;
  tag.value = ((typeof arguments[1] === 'string') && "value=\"" + arguments[1] + "\" ") || "";
  opts = arguments[2] || arguments[1];
  tag.set_opts(opts);
  tag.checked_string = "";
  return tag.render();
};
check_box_tag = function(name) {
  var opts, tag;
  tag = new BaseInputTag("checkbox");
  tag.name = name;
  tag.value = "value=\"" + (((typeof arguments[1] === 'string') && arguments[1]) || 1) + "\" ";
  tag.checked_string = arguments[2] === true ? "checked=\"checked\" " : "";
  opts = arguments[2] || arguments[1];
  tag.set_opts(opts);
  return tag.render();
};