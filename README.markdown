# Ice Ice Baby!

The Ice project allows user-created templates to be written in the javascript programming language.  Thanks to the [therubyracer](http://github.com/cowboyd/therubyracer) they are then interpreted using Google's V8 javascript engine.

Ice is similar to Liquid in terms of safety, but uses javascript to leverage the powers of a language most developers are familiar with.  Ice runs the templates through an erb-ish parser (written by [Mark Turansky](http://blog.markturansky.com/BetterJavascriptTemplates.html)). 

Your users can then write Ice templates like:

    <table>
        <tr><th>Name</th><th>Email</th></tr>
        <% for (i = 0; i < users.length; i++) { %>
            <tr>
                <td><%= user.name %></td><td><%= mail_to(user.email) %></td>
            </tr>
        <% } %>
    </table>

These templates can be run from the appropriate views directory, provided they have a .ice extension.  Also, the templates may be compiled on demand with the method:

    Ice.convert_template(template_text, vars = {})

## Why another templating engine when there is Liquid?

[Liquid](http://github.com/tobi/liquid) is excellent but it showing its age in a few ways:

* Hard to extend without knowing Liquid internals
* Introduces yet-another-language, whereas many designers/developers are already familiar with javascript
* Doesn't allow template creators to use a rich object model and easily create their own functions
* Doesn't have a rich set of support libraries like what javascript brings to the table

Note that we're still big fans of Liquid.  In fact, we call this project "Ice" as a tribute (extending the metaphor, we use "Cubes" where they have "Drops").

In addition, our ice_view.rb file is almost directly ripped out of the liquid project.

## Installation

Ice is curently being developed only for Rails 3 (we have a Rails 2 branch as well).  Simply add to your Gemfile

    gem 'ice'

## to_ice

Every object is revealed to the templates via its to_ice method.  This helps filter the objects that are passed into the javascript, so people editing the template only have access to a sanitized version of the data that you want them to format.

Instances of some classes like String and Numeric just return themselves as the result of to_ice.  Hashes and Arrays run to_ice recursively on their members.

If you want an object to map to a different representation, simply define a to_ice object that returns whatever object you want to represent it within the javascript template.  These objects are referred to as "Cubes", and are equivalent to "Drops" for those used to the Liquid template.

## ActiveRecord and to_ice

To make life easy, since most complex objects passed to the templates will be subclasses of ActiveRecord::Base, the default to_ice behaviour of ActiveRecord is to pass itself in to a class with the same name, but followed by the word "Cube".

Therefore calling to_ice on instance of a User class will invoke

    UserCube.new self

## BaseCube Class

In order for everything to work easily, you can have your cubes inherit from our Ice::BaseCube class.  Your cubes inheriting from it can then determine what additional attributes they want to reveal.  For example

    class BookCube < Ice::BaseCube
      revealing :title, :author_id, :genre_id

      def reviewer_names
        @source.reviewers.map(&:name)
      end
    end

would provide a cube with access to the title, author_id and genre properties of the underlying ActiveRecord.  In addition, it exposes a reviewer_names function that uses the @source instance variable to get at the record which is being filtered.

These cubes also have simple belongs_to and has_many associations, so you can write things like:

    class ArticleCube < Ice::BaseCube
      has_many :comments, :tags
      belongs_to :author, :section
    end

This generates association helper functions such as comment_ids, num_comments, has_comments, comments, author_id, and author.

Note that the results of all associations and revealed functions are also sanitized via to_ice.

## NavBar

To make it easier to generate links, we added a NavBar class to the javascript helpers.  THis class has an open and close method, as well as a link_to mehod which either takes a url, or a url and a link label.

    <% var nav = new NavBar() %>
    <%= nav.open() %>
    <%= nav.link_to("Bar", "/foo") %>
    <%= nav.link_to("http://ludicast.com") %>
    <%= nav.close() %>

This then generates the following html

    <ul class="linkBar">
        <li><a href="/foo">Bar</a></li>
        <li><a href="http://ludicast.com">http://ludicast.com</a></li>
    </ul>

You'll notice that the resulting html code is shorter than the generator code, making this look inefficient.  However the NavBar also takes options so if the NavBar above was instantiated with:

    <% var nav = new NavBar({nav_open:"<div>", nav_close:"</div>",link_wrapper:function(link){
      return "<span>" + link + "</span>"

it would automatically generate

    <div>
        <span><a href="/foo">Bar</a></span>
        <span><a href="http://ludicast.com">http://ludicast.com</a></span>
    </div>

Also, if you want to make a site- or page-wide change, all you need to do is add these options to the NavBar class like

    NavBar.default_options = {nav_open:"<div>", nav_close:"</div>",link_wrapper:function(link){
        return "<span>" + link + "</span>"
    }}

Then all links will generate with these options, unless overridden in the NavBar's constructor.  If the NavBar has a separator property added, it will add that separator between links.  If a link is not shown (due to access restrictions or whatever in the link_wrapper function) the separator obviously will not appear for that link.  So the code

    bar.separator = "---"
    bar.link_wrapper = function (link) {
        if (link.match(/aa/)) {
            return ""
        } else {
            return link
        }
    }

would cause 

    bar.open() + bar.link_to("ff") + bar.link_to("aa") + bar.link_to("gg") + bar.close()

to render as:

    links.should.eql "<div><a href=\"ff\">ff</a>----<a href=\"gg\">gg</a></div>"

## Routes

Keeping with our tradition of stealing from other projects, we took the code from [RouteJs middleware](http://coderack.org/users/kossnocorp/middlewares/88-routesjs) to expose to our templates all your routes.  This is a big convenience and lets you put in your templates things like:

    <% var nav = new NavBar() %>
    <%= nav.open() %>
    <%= nav.link_to("List Pizzas", pizzas_path() ) %>
    <%= nav.link_to("Modify Pizza", edit_pizza_path({id: pizza.id})) %>
    <%= nav.close() %>

which is converted into

    <ul class="linkBar">
        <li><a href="/pizzas">List Pizzas</a></li>
        <li><a href="/pizzas/2/edit">Modify Pizza</a></li>
    </ul>

Note that some people might claim that it is insecure to expose your resources like this, but that probably should be dealt with on a case-by-case basis.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add spec for it. This is important so I don't break it in a future version unintentionally.  In fact, try to write your specs in a test-first manner.
* Commit
* Send me a pull request.

## Todo

* Add in form builders (from clots project)
* Break form builders and helpers out into separate javascript project that can be included in other frameworks like CakePHP
* Allow mappings for other ORMs than ActiveRecord
* Haml support (really just deciding what extension those files would use :))

## Copyright

Copyright (c) 2010 Nate Kidwell. See LICENSE for details.