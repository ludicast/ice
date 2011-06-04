linkTo = (label, link, opts) ->
	if (! link)
		link = label
	"<a href='#{link}'>#{label}</a>"
	
class NavBar
	@defaultOptions = {}
	
	assignValues: (options) ->
		for optionName, optionValue of options
			if options.hasOwnProperty(optionName)
				this[optionName] = optionValue
					
	constructor: (options) ->
		@assignValues(NavBar.defaultOptions)
		@assignValues(options)

	linkTo: (label, link) ->
		linkCode = linkTo(label, link)
		if @linkWrapper
			linkData = @linkWrapper(linkCode)
		else
			linkData = "<li>#{linkCode}</li>"
		if linkData
			if @linkData && @separator
				linkData = @separator + linkData
			@linkData = linkData
		linkData
		
	open: () ->
		@navOpen || '<ul class="linkBar">'


	close: () ->
    @navClose || '</ul>'