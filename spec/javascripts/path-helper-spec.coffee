describe "NavBar", ->

	describe "by default", ->
		beforeEach ->
			@bar = new NavBar()
		
		it "should generate list by default", ->
			(expect (@bar.open() + @bar.close())).toEqual "<ul class=\"linkBar\"></ul>"
		
		it "should generate list with internal links", ->
			links = (@bar.open() + @bar.linkTo("ff") + @bar.linkTo("aa") + @bar.close())
			(expect links).toEqual "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li><li><a href=\"aa\">aa</a></li></ul>"
		
		it "should take optional titles", ->
			links = (@bar.open() + @bar.linkTo("ff", "aa") + @bar.close())
			(expect links).toEqual "<ul class=\"linkBar\"><li><a href=\"aa\">ff</a></li></ul>"
				
	describe "with options", ->
		beforeEach ->
			opts =
				navOpen: "<div>"
				navClose: "</div>"
				linkWrapper: (link) -> "<span>" + link + "</span>"
			@bar = new NavBar(opts)

		it "should generate list with wrappers", ->
			links = (@bar.open() + @bar.linkTo("ff") + @bar.close())
			(expect links).toEqual "<div><span><a href=\"ff\">ff</a></span></div>"

	describe "with separator", ->
		beforeEach ->
			@separator = " --- "
			separatorObject =
				separator: @separator
			@bar = new NavBar(separatorObject)

		it "should not separate single links", ->
			links = (@bar.open() + @bar.linkTo("ff") + @bar.close())
			(expect links).toEqual "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li></ul>"

		it "should separate multiple links", ->
			links = (@bar.open() + @bar.linkTo("ff") + @bar.linkTo("aa") + @bar.close())
			(expect links).toEqual "<ul class=\"linkBar\"><li><a href=\"ff\">ff</a></li>" + @separator + "<li><a href=\"aa\">aa</a></li></ul>"

		it "should not display for missing links", ->
			@bar.navOpen = "<div>"
			@bar.navClose = "</div>"
			@bar.linkWrapper = (link)->
				if link.match /aa/
					""
				else
					link

			links = (@bar.open() + @bar.linkTo("ff") + @bar.linkTo("aa") + @bar.linkTo("gg") + @bar.close())
			(expect links).toEqual "<div><a href=\"ff\">ff</a>" + @separator + "<a href=\"gg\">gg</a></div>"

	describe "with class-wide options", ->
		beforeEach ->
			NavBar.defaultOptions =
				navOpen: "<div>"
				navClose: "</div>"
				linkWrapper: (link) -> "<span>" + link + "</span>"
			@bar = new NavBar()

		it "should generate list with wrappers", ->
			links = (@bar.open() + @bar.linkTo("ff") + @bar.close())
			(expect links).toEqual "<div><span><a href=\"ff\">ff</a></span></div>"

		afterEach ->
			NavBar.defaultOptions = {}