var BaseInputTag, checkBoxTag, getAttributeString, getCheckedString, getClassString, getDisabledString, getMaxlengthString, getSizeString, getTypeValue, humanize, labelTag, passwordFieldTag;
humanize = function(name) {
  var match;
  match = name.match(/(.*)_id$/);
  if (match) {
    name = match[1];
  }
  return name.split('_').join(' ');
};
getTypeValue = function(type, opts) {
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
getAttributeString = function(type, opts) {
  return (opts && opts[type] && type + "=\"" + getTypeValue(type, opts) + "\" ") || "";
};
getSizeString = function(opts) {
  return getAttributeString('size', opts);
};
getClassString = function(opts) {
  return getAttributeString('class', opts);
};
getDisabledString = function(opts) {
  return getAttributeString('disabled', opts);
};
getCheckedString = function(opts) {
  return getAttributeString('checked', opts);
};
getMaxlengthString = function(opts) {
  return getAttributeString('maxlength', opts);
};
labelTag = function(name, opts) {
  var classString, label;
  label = typeof opts === 'string' ? opts : humanize(name);
  classString = getClassString(opts);
  return "<label " + classString + "for=\"" + name + "\">" + (label.charAt(0).toUpperCase()) + (label.substr(1)) + "</label>";
};
BaseInputTag = (function() {
  function BaseInputTag(tagType) {
    this.tagType = tagType;
  }
  BaseInputTag.prototype.render = function() {
    return "<input " + this.checkedString + this.disabledString + this.classString + "id=\"" + this.name + "\" " + this.maxlengthString + "name=\"" + this.name + "\" " + this.sizeString + "type=\"" + this.tagType + "\" " + this.value + "/>";
  };
  BaseInputTag.prototype.setOpts = function(opts) {
    this.classString = getClassString(opts);
    this.sizeString = getSizeString(opts);
    this.disabledString = getDisabledString(opts);
    return this.maxlengthString = getMaxlengthString(opts);
  };
  return BaseInputTag;
})();
passwordFieldTag = function(name) {
  var opts, tag;
  tag = new BaseInputTag("password");
  tag.name = name;
  tag.value = ((typeof arguments[1] === 'string') && "value=\"" + arguments[1] + "\" ") || "";
  opts = arguments[2] || arguments[1];
  tag.setOpts(opts);
  tag.checkedString = "";
  return tag.render();
};
checkBoxTag = function(name) {
  var opts, tag;
  tag = new BaseInputTag("checkbox");
  tag.name = name;
  tag.value = "value=\"" + (((typeof arguments[1] === 'string') && arguments[1]) || 1) + "\" ";
  tag.checkedString = arguments[2] === true ? "checked=\"checked\" " : "";
  opts = arguments[2] || arguments[1];
  tag.setOpts(opts);
  return tag.render();
};