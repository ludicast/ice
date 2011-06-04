var NavBar, link_to;
link_to = function(label, link, opts) {
  if (!link) {
    link = label;
  }
  return "<a href=\"" + link + "\">" + label + "</a>";
};
NavBar = (function() {
  NavBar.default_options = {};
  NavBar.prototype.assignValues = function(options) {
    var optionName, optionValue, _results;
    _results = [];
    for (optionName in options) {
      optionValue = options[optionName];
      _results.push(options.hasOwnProperty(optionName) ? this[optionName] = optionValue : void 0);
    }
    return _results;
  };
  function NavBar(options) {
    this.assignValues(NavBar.default_options);
    this.assignValues(options);
  }
  NavBar.prototype.link_to = function(label, link) {
    var link_code, link_data;
    link_code = link_to(label, link);
    if (this.link_wrapper) {
      link_data = this.link_wrapper(link_code);
    } else {
      link_data = "<li>" + link_code + "</li>";
    }
    if (link_data) {
      if (this.link_data && this.separator) {
        link_data = this.separator + link_data;
      }
      this.link_data = link_data;
    }
    return link_data;
  };
  NavBar.prototype.open = function() {
    return this.nav_open || '<ul class="linkBar">';
  };
  NavBar.prototype.close = function() {
    return this.nav_close || '</ul>';
  };
  return NavBar;
})();