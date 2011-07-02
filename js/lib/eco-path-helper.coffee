safe = (value)->
    result = new String(value)
    result.ecoSafe = true
    result

linkTo = (label, link, opts) ->
	if (! link)
		link = label
	'<a href="' + link + '">' + label + '</a>'

navBar = (options, yield)->
    config = try
        NavBarConfig
    catch error
        {}
    config["linkPrefix"] ||= "<li>"
    config["linkPostfix"] ||= "</li>"
    config["navPrefix"] ||= "<ul>"
    config["navPostfix"] ||= "</ul>"

    linkPrefix = ()-> options["linkPrefix"] || config["linkPrefix"]
    linkPostfix = ()-> options["linkPostfix"] || config["linkPostfix"]
    navPrefix = ()-> options["navPrefix"] || config["navPrefix"]
    navPostfix = ()-> options["navPostfix"] || config["navPostfix"]
    bar =
        linkTo: (label, link = null) =>
            safe "#{linkPrefix()}#{linkTo label, link}#{linkPostfix()}"

    links = yield(bar)
    safe "#{navPrefix()}#{links}#{navPostfix}"