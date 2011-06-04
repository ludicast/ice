describe("NavBar", function() {
  describe("by default", function() {
    beforeEach(function() {
      return this.bar = new NavBar();
    });
    it("should generate list by default", function() {
      return (expect(this.bar.open() + this.bar.close())).toEqual("<ul class=\"linkBar\"></ul>");
    });
    it("should generate list with internal links", function() {
      var links;
      links = this.bar.open() + this.bar.linkTo("ff") + this.bar.linkTo("aa") + this.bar.close();
      return (expect(links)).toEqual("<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li><li><a href=\"aa\">aa</a></li></ul>");
    });
    return it("should take optional titles", function() {
      var links;
      links = this.bar.open() + this.bar.linkTo("ff", "aa") + this.bar.close();
      return (expect(links)).toEqual("<ul class=\"linkBar\"><li><a href=\"aa\">ff</a></li></ul>");
    });
  });
  describe("with options", function() {
    beforeEach(function() {
      var opts;
      opts = {
        navOpen: "<div>",
        navClose: "</div>",
        linkWrapper: function(link) {
          return "<span>" + link + "</span>";
        }
      };
      return this.bar = new NavBar(opts);
    });
    return it("should generate list with wrappers", function() {
      var links;
      links = this.bar.open() + this.bar.linkTo("ff") + this.bar.close();
      return (expect(links)).toEqual("<div><span><a href=\"ff\">ff</a></span></div>");
    });
  });
  describe("with separator", function() {
    beforeEach(function() {
      var separatorObject;
      this.separator = " --- ";
      separatorObject = {
        separator: this.separator
      };
      return this.bar = new NavBar(separatorObject);
    });
    it("should not separate single links", function() {
      var links;
      links = this.bar.open() + this.bar.linkTo("ff") + this.bar.close();
      return (expect(links)).toEqual("<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li></ul>");
    });
    it("should separate multiple links", function() {
      var links;
      links = this.bar.open() + this.bar.linkTo("ff") + this.bar.linkTo("aa") + this.bar.close();
      return (expect(links)).toEqual("<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li>" + this.separator + "<li><a href=\"aa\">aa</a></li></ul>");
    });
    return it("should not display for missing links", function() {
      var links;
      this.bar.navOpen = "<div>";
      this.bar.navClose = "</div>";
      this.bar.linkWrapper = function(link) {
        if (link.match(/aa/)) {
          return "";
        } else {
          return link;
        }
      };
      links = this.bar.open() + this.bar.linkTo("ff") + this.bar.linkTo("aa") + this.bar.linkTo("gg") + this.bar.close();
      return (expect(links)).toEqual("<div><a href=\"ff\">ff</a>" + this.separator + "<a href=\"gg\">gg</a></div>");
    });
  });
  return describe("with class-wide options", function() {
    beforeEach(function() {
      NavBar.defaultOptions = {
        navOpen: "<div>",
        navClose: "</div>",
        linkWrapper: function(link) {
          return "<span>" + link + "</span>";
        }
      };
      return this.bar = new NavBar();
    });
    it("should generate list with wrappers", function() {
      var links;
      links = this.bar.open() + this.bar.linkTo("ff") + this.bar.close();
      return (expect(links)).toEqual("<div><span><a href=\"ff\">ff</a></span></div>");
    });
    return afterEach(function() {
      return NavBar.defaultOptions = {};
    });
  });
});