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

      links.should.eql "<ul class=\"linkBar\"><li><a href=\"aa\">ff</a></li></ul>"
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

  describe "with separator"
    before_each
      separator = " --- "
      bar = new NavBar({separator: separator})
    end

    it "should not separate single links"
      links = (bar.open() + bar.link_to("ff") + bar.close())
      links.should.eql "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li></ul>"
    end

    it "should separate multiple links"
      links = (bar.open() + bar.link_to("ff") + bar.link_to("aa") + bar.close())
      links.should.eql "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li>" + separator + "<li><a href=\"aa\">aa</a></li></ul>"
    end

    it "should not display for missing links"
      bar.nav_open = "<div>"
      bar.nav_close = "</div>"
      bar.link_wrapper = function (link) {
          if (link.match(/aa/)) {
            return ""
          } else {
            return link
          }
      }

      links = (bar.open() + bar.link_to("ff") + bar.link_to("aa") + bar.link_to("gg") + bar.close())
      links.should.eql "<div><a href=\"ff\">ff</a>" + separator + "<a href=\"gg\">gg</a></div>"

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

    after_each
      NavBar.default_options = {}
    end

  end


end


describe "Form Builder Tags"
  describe "label_tag"
    it "assigns default value"
      tag = label_tag('name')
      tag.should.eql '<label for="name">Name</label>'
    end
    it "assigns humanized default value"
      tag = label_tag('supervising_boss_id')
      tag.should.eql '<label for="supervising_boss_id">Supervising boss</label>'
    end
    it "allows alternative value"
      tag = label_tag('name', 'Your Name')
      tag.should.eql '<label for="name">Your Name</label>'
    end
    it "allows class to be assigned"
      tag = label_tag('name', {'class':'small_label'})
      tag.should.eql '<label class="small_label" for="name">Name</label>'
    end

  end

  describe "for password_field_tag"
    it "should generate regular password tag"
      tag = password_field_tag('pass')
      tag.should.eql '<input id="pass" name="pass" type="password" />'
    end

    it "should have alternate value"
      tag = password_field_tag('secret', 'Your secret here')
      tag.should.eql '<input id="secret" name="secret" type="password" value="Your secret here" />'
    end

    it "should take class"
      tag = password_field_tag('masked', {'class':'masked_input_field'})
      tag.should.eql '<input class="masked_input_field" id="masked" name="masked" type="password" />'
    end

    it "should take size"
      tag = password_field_tag('token','', {size:15})
      tag.should.eql '<input id="token" name="token" size="15" type="password" value="" />'
    end

    it "should take maxlength"
      tag = password_field_tag('key',{maxlength:16})
      tag.should.eql '<input id="key" maxlength="16" name="key" type="password" />'
    end


    it "should take disabled option"
      tag = password_field_tag('confirm_pass',{disabled:true})
      tag.should.eql '<input disabled="disabled" id="confirm_pass" name="confirm_pass" type="password" />'
    end

    it "should take multiple options"
      tag = password_field_tag('pin','1234',{maxlength:4,size:6, 'class':'pin-input'})
      tag.should.eql '<input class="pin-input" id="pin" maxlength="4" name="pin" size="6" type="password" value="1234" />'
    end

  end

  describe "for check_box_tag"

    it "should generate basic checkbox"
      tag = check_box_tag('accept')
      tag.should.eql '<input id="accept" name="accept" type="checkbox" value="1" />'
    end

    it "should take alternate values"
      tag = check_box_tag('rock', 'rock music')
      tag.should.eql '<input id="rock" name="rock" type="checkbox" value="rock music" />'
    end
    it "should take parameter for checked"
      tag = check_box_tag('receive_email', 'yes', true)
      tag.should.eql '<input checked="checked" id="receive_email" name="receive_email" type="checkbox" value="yes" />'
    end
  end

end

