var linkTo, navBar;
var __slice = Array.prototype.slice;
linkTo = function(label, link, opts) {
  if (!link) {
    link = label;
  }
  return a({
    href: link
  }, function() {
    return label;
  });
};
navBar = function() {
  var args, f, linkWrap, methods, navWrap, opts;
  args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  if (args.length === 2) {
    opts = args.shift();
  } else {
    opts = {};
  }
  f = args[0];
  navWrap = opts.navWrap || ul;
  linkWrap = opts.linkWrap || li;
  methods = {
    linkTo: function(name, href) {
      if (!href) {
        href = name;
      }
      return linkWrap(function() {
        return linkTo(name, href);
      });
    }
  };
  return navWrap(function() {
    return f(methods);
  });
};