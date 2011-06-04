<% var nav = new NavBar() %>
<%= nav.open() %>
<%= nav.linkTo("Bar", "/foo") %>
<%= nav.linkTo("http://ludicast.com") %>
<%= nav.close() %>