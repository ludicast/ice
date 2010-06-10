function label_tag(name) {
    return "<label for=\"" + name + "\">" + name.charAt(0).toUpperCase() + name.substr(1) + "</label>"
}