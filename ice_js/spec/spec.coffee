describe "NavBar", ->

	describe "by default", ->
		beforeEach ->
			@bar = new NavBar()
		
		it "should generate list by default", ->
			(expect (@bar.open() + @bar.close())).toEqual "<ul class=\"linkBar\"></ul>"
		
		it "should generate list with internal links", ->
			links = (@bar.open() + @bar.link_to("ff") + @bar.link_to("aa") + @bar.close())
			(expect links).toEqual "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li><li><a href=\"aa\">aa</a></li></ul>"
		
		it "should take optional titles", ->
			links = (@bar.open() + @bar.link_to("ff", "aa") + @bar.close())
			(expect links).toEqual "<ul class=\"linkBar\"><li><a href=\"aa\">ff</a></li></ul>"
				
	describe "with options", ->
		beforeEach ->
			opts =
				nav_open: "<div>"
				nav_close: "</div>"
				link_wrapper: (link) -> "<span>" + link + "</span>"
			@bar = new NavBar(opts)

		it "should generate list with wrappers", ->
			links = (@bar.open() + @bar.link_to("ff") + @bar.close())
			(expect links).toEqual "<div><span><a href=\"ff\">ff</a></span></div>"

	describe "with separator", ->
		beforeEach ->
			@separator = " --- "
			separatorObject =
				separator: @separator
			@bar = new NavBar(separatorObject)

		it "should not separate single links", ->
			links = (@bar.open() + @bar.link_to("ff") + @bar.close())
			(expect links).toEqual "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li></ul>"

		it "should separate multiple links", ->
			links = (@bar.open() + @bar.link_to("ff") + @bar.link_to("aa") + @bar.close())
			(expect links).toEqual "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li>" + @separator + "<li><a href=\"aa\">aa</a></li></ul>"

		it "should not display for missing links", ->
			@bar.nav_open = "<div>"
			@bar.nav_close = "</div>"
			@bar.link_wrapper = (link)->
				if link.match /aa/
					""
				else
					link

			links = (@bar.open() + @bar.link_to("ff") + @bar.link_to("aa") + @bar.link_to("gg") + @bar.close())
			(expect links).toEqual "<div><a href=\"ff\">ff</a>" + @separator + "<a href=\"gg\">gg</a></div>"

	describe "with class-wide options", ->
		beforeEach ->
			NavBar.default_options =
				nav_open: "<div>"
				nav_close: "</div>"
				link_wrapper: (link) -> "<span>" + link + "</span>"
			#alert NavBar.default_options.nav_open	
			@bar = new NavBar()

		it "should generate list with wrappers", ->
			links = (@bar.open() + @bar.link_to("ff") + @bar.close())
			(expect links).toEqual "<div><span><a href=\"ff\">ff</a></span></div>"

		afterEach ->
			NavBar.default_options = {}