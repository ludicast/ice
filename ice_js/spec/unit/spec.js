describe "nav bar helper"
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