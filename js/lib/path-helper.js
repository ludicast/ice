var linkTo, navBar, safe;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
safe = function(value) {
  var result;
  result = new String(value);
  result.ecoSafe = true;
  return result;
};
linkTo = function(label, link, opts) {
  if (!link) {
    link = label;
  }
  return '<a href="' + link + '">' + label + '</a>';
};
navBar = function(options, yield) {
  var bar, config, linkPostfix, linkPrefix, links, navPostfix, navPrefix;
  config = (function() {
    try {
      return NavBarConfig;
    } catch (error) {
      return {};
    }
  })();
  config["linkPrefix"] || (config["linkPrefix"] = "<li>");
  config["linkPostfix"] || (config["linkPostfix"] = "</li>");
  config["navPrefix"] || (config["navPrefix"] = "<ul>");
  config["navPostfix"] || (config["navPostfix"] = "</ul>");
  linkPrefix = function() {
    return options["linkPrefix"] || config["linkPrefix"];
  };
  linkPostfix = function() {
    return options["linkPostfix"] || config["linkPostfix"];
  };
  navPrefix = function() {
    return options["navPrefix"] || config["navPrefix"];
  };
  navPostfix = function() {
    return options["navPostfix"] || config["navPostfix"];
  };
  bar = {
    linkTo: __bind(function(label, link) {
      if (link == null) {
        link = null;
      }
      return safe("" + (linkPrefix()) + (linkTo(label, link)) + (linkPostfix()));
    }, this)
  };
  links = yield(bar);
  return safe("" + (navPrefix()) + links + navPostfix);
};