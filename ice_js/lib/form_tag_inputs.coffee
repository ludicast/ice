humanize = (name) ->
	match = name.match(/(.*)_id$/)
	if match
		name = match[1]
	name.split('_').join(' ')

get_type_value = (type, opts) ->
	switch type
		when "disabled"
			if opts[type] then "disabled" else ""
		when "checked" then (opts[type] ? "checked" : "")
		else opts[type]

get_attribute_string = (type, opts) ->
	(opts && opts[type] && type + "=\"" + get_type_value(type,opts) + "\" ") || ""

get_size_string = (opts) ->
	get_attribute_string('size', opts)

get_class_string = (opts) ->
	get_attribute_string('class', opts)

get_disabled_string = (opts) ->
	get_attribute_string('disabled', opts)

get_checked_string = (opts) ->
	get_attribute_string('checked', opts)

get_maxlength_string = (opts) ->
	get_attribute_string('maxlength', opts)

label_tag = (name, opts) ->
	label = if typeof opts == 'string' then opts else humanize(name)
	class_string = get_class_string(opts)
	"<label #{class_string}for=\"#{name}\">#{label.charAt(0).toUpperCase()}#{label.substr(1)}</label>"

class BaseInputTag
	constructor: (@tag_type) ->
	
	render: ->
		"<input #{@checked_string}#{@disabled_string}#{@class_string}id=\"#{@name}\" #{@maxlength_string}name=\"#{@name}\" #{@size_string}type=\"#{@tag_type}\" #{@value}/>"

	set_opts: (opts) ->
		@class_string = get_class_string opts
		@size_string = get_size_string opts
		@disabled_string = get_disabled_string(opts)
		@maxlength_string = get_maxlength_string(opts)


password_field_tag = (name) ->
    tag = new BaseInputTag("password")
    tag.name = name
    tag.value = ((typeof arguments[1] == 'string') && "value=\"" + arguments[1] + "\" ") || ""
    opts = arguments[2] || arguments[1]
    tag.set_opts(opts)
    tag.checked_string = ""
    tag.render()

check_box_tag = (name) ->
    tag = new BaseInputTag("checkbox")
    tag.name = name
    tag.value = "value=\"" + (((typeof arguments[1] == 'string') && arguments[1]) || 1) + "\" "
    tag.checked_string = if arguments[2] is true then "checked=\"checked\" " else ""
    opts = arguments[2] || arguments[1]
    tag.set_opts(opts)
    tag.render()