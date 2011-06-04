link_to = (label, link, opts) ->
	if (! link)
		link = label
	"<a href=\"#{link}\">#{label}</a>"
	
class NavBar
	@default_options = {}
	
	assignValues: (options) ->
		for optionName, optionValue of options
			if options.hasOwnProperty(optionName)
				this[optionName] = optionValue	
				
	constructor: (options) ->
		@assignValues(NavBar.default_options)
		@assignValues(options)

	link_to: (label, link) ->
		link_code = link_to(label, link)
		if @link_wrapper
			link_data = @link_wrapper(link_code)
		else
			link_data = "<li>#{link_code}</li>"
		if link_data
			if @link_data && @separator
				link_data = @separator + link_data
			@link_data = link_data
		link_data
		
	open: () ->
		@nav_open || '<ul class="linkBar">'


	close: () ->
    @nav_close || '</ul>'