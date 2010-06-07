describe "NavBar"

  describe "by default"
    before_each
      bar = new NavBar()
    end


    it "should generate list by default"
      (bar.open() + bar.close()).should.eql "<ul class=\"linkBar\"></ul>"
    end

    it "should generate list with internal links"

      links = (bar.open() + bar.link_to("ff") + bar.link_to("aa") + bar.close())

      links.should.eql "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li><li><a href=\"aa\">aa</a></li></ul>"
    end

    it "should take optional titles"

      links = (bar.open() + bar.link_to("ff", "aa") + bar.close())

      links.should.eql "<ul class=\"linkBar\"><li><a href=\"ff\">aa</a></li></ul>"
    end

end

  describe "with options"
    before_each
      bar = new NavBar( {nav_open:"<div>", nav_close:"</div>",link_wrapper:function(link){
        return "<span>" + link + "</span>"
      }} )
    end

    it "should generate list with wrappers"
      links = (bar.open() + bar.link_to("ff") + bar.close())

      links.should.eql "<div><span><a href=\"ff\">ff</a></span></div>"
    end

  end

  describe "with class-wide options"
    before_each
      NavBar.default_options = {nav_open:"<div>", nav_close:"</div>",link_wrapper:function(link){
        return "<span>" + link + "</span>"
      }}


    
      bar = new NavBar( )
    end

    it "should generate list with wrappers"
      links = (bar.open() + bar.link_to("ff") + bar.close())

      links.should.eql "<div><span><a href=\"ff\">ff</a></span></div>"
    end

  end


end

