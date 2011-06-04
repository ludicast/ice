var NavBar, linkTo;
linkTo = function(label, link, opts) {
  if (!link) {
    link = label;
  }
  return "<a href='" + link + "'>" + label + "</a>";
};
NavBar = (function() {
  NavBar.defaultOptions = {};
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
    this.assignValues(NavBar.defaultOptions);
    this.assignValues(options);
  }
  NavBar.prototype.linkTo = function(label, link) {
    var linkCode, linkData;
    linkCode = linkTo(label, link);
    if (this.linkWrapper) {
      linkData = this.linkWrapper(linkCode);
    } else {
      linkData = "<li>" + linkCode + "</li>";
    }
    if (linkData) {
      if (this.linkData && this.separator) {
        linkData = this.separator + linkData;
      }
      this.linkData = linkData;
    }
    return linkData;
  };
  NavBar.prototype.open = function() {
    return this.navOpen || '<ul class="linkBar">';
  };
  NavBar.prototype.close = function() {
    return this.navClose || '</ul>';
  };
  return NavBar;
})();