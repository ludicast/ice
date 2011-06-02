<% var nav = new NavBar() %>
<%= nav.open() %>
<%= nav.link_to("Bar", "/foo") %>
<%= nav.link_to("http://ludicast.com") %>
<%= nav.close() %>