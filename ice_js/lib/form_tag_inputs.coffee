humanize = (name) ->
	match = name.match(/(.*)_id$/)
	if match
		name = match[1]
	name.split('_').join(' ')

getTypeValue = (type, opts) ->
	switch type
		when "disabled"
			if opts[type] then "disabled" else ""
		when "checked" then (opts[type] ? "checked" : "")
		else opts[type]

getAttributeString = (type, opts) ->
	(opts && opts[type] && type + "=\"" + getTypeValue(type,opts) + "\" ") || ""

getSizeString = (opts) ->
	getAttributeString('size', opts)

getClassString = (opts) ->
	getAttributeString('class', opts)

getDisabledString = (opts) ->
	getAttributeString('disabled', opts)

getCheckedString = (opts) ->
	getAttributeString('checked', opts)

getMaxlengthString = (opts) ->
	getAttributeString('maxlength', opts)

labelTag = (name, opts) ->
	label = if typeof opts == 'string' then opts else humanize(name)
	classString = getClassString(opts)
	"<label #{classString}for=\"#{name}\">#{label.charAt(0).toUpperCase()}#{label.substr(1)}</label>"

class BaseInputTag
	constructor: (@tagType) ->
	
	render: ->
		"<input #{@checkedString}#{@disabledString}#{@classString}id=\"#{@name}\" #{@maxlengthString}name=\"#{@name}\" #{@sizeString}type=\"#{@tagType}\" #{@value}/>"

	setOpts: (opts) ->
		@classString = getClassString opts
		@sizeString = getSizeString opts
		@disabledString = getDisabledString(opts)
		@maxlengthString = getMaxlengthString(opts)


passwordFieldTag = (name) ->
    tag = new BaseInputTag("password")
    tag.name = name
    tag.value = ((typeof arguments[1] == 'string') && "value=\"" + arguments[1] + "\" ") || ""
    opts = arguments[2] || arguments[1]
    tag.setOpts(opts)
    tag.checkedString = ""
    tag.render()

checkBoxTag = (name) ->
    tag = new BaseInputTag("checkbox")
    tag.name = name
    tag.value = "value=\"" + (((typeof arguments[1] == 'string') && arguments[1]) || 1) + "\" "
    tag.checkedString = if arguments[2] is true then "checked=\"checked\" " else ""
    opts = arguments[2] || arguments[1]
    tag.setOpts(opts)
    tag.render()