# Ice Ice Baby!

The Ice project allows user-created templates to be written in the Coffeescript programming language.  Thanks to the [therubyracer](http://github.com/cowboyd/therubyracer) they are then interpreted using Google's V8 javascript engine.

Ice is similar to Liquid in terms of safety, but uses Coffeescript to utilize a powerful language.  Ice runs the templates through the eco parser (written by [sstephenson@gmail.com](https://github.com/sstephenson/eco)).

Your users can then write Ice templates like:

    <table>
        <tr><th>Name</th><th>Email</th></tr>
        <% for user in @users %>
            <tr>
                <td><%= user.name %></td><td><%= @mailTo(user.email) %></td>
            </tr>
        <% end %>
    </table>

These templates can be run from the appropriate views directory, provided they have a .eco extension.  Also, the templates may be compiled on demand with the method:

    Ice.convert_template(template_text, vars = {})

## Why another templating engine when there is Liquid?

[Liquid](http://github.com/tobi/liquid) is excellent but it showing its age in a few ways:

* Hard to extend without knowing Liquid internals
* Introduces yet-another-language, whereas many designers/developers are getting familiar with Coffeescript
* Doesn't allow template creators to use a rich object model and easily create their own functions
* Doesn't have a rich set of support libraries like what Javascript (and Coffeescript) bring to the table

Note that we're still big fans of Liquid.  In fact, we call this project "Ice" as a tribute (extending the metaphor, we use "Cubes" where they have "Drops").

## Installation

Ice is currently being developed only for Rails 3.  Simply add to your Gemfile

    gem 'ice'

## to_ice

Every object is revealed to the templates via its to_ice method.  This helps sanitizes the objects that are passed into eco, so people editing the template only have access to a limited subset of the data.

Instances of some classes like String and Numeric just return themselves as the result of to_ice.  Hashes and Arrays run to_ice recursively on their members.

If you want an object to map to a different representation, simply define a to_ice object that returns whatever object you want to represent it within the coffeescript template.  These objects are referred to as "Cubes", and are equivalent to "Drops" for those used to the Liquid template.

## ActiveModel and to_ice

To make life easy, since most complex objects passed to the templates will be classes including ActiveModel::Serializable, the default to_ice behaviour of these classes is to pass itself in to a class with the same name, but followed by the word "Cube".

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

would provide a cube with access to the title, author_id and genre properties of the underlying ActiveModel.  In addition, it exposes a reviewer_names function that uses the @source instance variable to get at the record which is being filtered.  Note that if no call to `revealing` occurs, the cube generates a mapping for the `@source` object's serializable `attributes`.

These cubes also have simple belongs_to and has_many associations, so you can write things like:

    class ArticleCube < Ice::BaseCube
      has_many :comments, :tags
      belongs_to :author, :section
    end

This generates association helper functions such as comment_ids, num_comments, has_comments, comments, author_id, and author.

Note that the results of all associations and revealed functions are also sanitized via to_ice.

## Partials

Partials may now be written in Ice, and included in Erb (and other) templates.

## NavBar

To make it easier to generate links, we added a NavBar class to the javascript helpers.  THis class has an open and close method, as well as a link_to mehod which either takes a url, or a url and a link label.

    <%- @navBar (bar) => %>
        <%- bar.linkTo("Bar", "/foo") %>
        <%- bar.linkTo("http://ludicast.com") %>
    <% end %>

This then generates the following html

    <ul class="linkBar">
        <li><a href="/foo">Bar</a></li>
        <li><a href="http://ludicast.com">http://ludicast.com</a></li>
    </ul>

The NavBar also takes options so if the NavBar above was instead instantiated with:

    <% @opts = nav_prefix:'<div>', nav_postfix: '</div>', link_prefix: '<span>', link_postfix: '</span>' %>
    <%- @navBar @opts, (bar)=> %>

it would generate

    <div>
        <span><a href="/foo">Bar</a></span>
        <span><a href="http://ludicast.com">http://ludicast.com</a></span>
    </div>

Also, if you want to make a site-wide change to the default NavBar settings, all you need to do is add these options to the NavBarConfig class (in Ruby) like

    NavBarConfig[:nav_prefix] = "<div>"
    NavBarConfig[:nav_postfix] = "</div>"
    NavBarConfig[:link_prefix] = "<span>"
    NavBarConfig[:link_postfix] = "</span>"

Then all links will generate with these options, unless overridden in the values passed it to `@navBar`.

## Routes

Assuming that all your cubes are models that you are exposing to your app, we add to your eco templates routing helpers for every class inheriting from BaseCube.  Therefore, if you have a cube class named `NoteDrop`, you will have the following helper methods available:

    @newNotePath
    @notesPath
    @notePath(@note)
    @editNotePath(@note)

which are converted to the appropriate paths.

Note that some people might claim that it is insecure to expose your resources like this, but that probably should be dealt with on a case-by-case basis.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add spec for it. This is important so I don't break it in a future version unintentionally.  In fact, try to write your specs in a test-first manner.
* Commit
* Send me a pull request.

## Todo

* Allow Coffeescript (or Javascript) helpers to be read from an additional file.
* Add in form builders (from clots project)
* Break form builders and helpers out into separate javascript project that can be included in other frameworks like CakePHP
* Haml support (really just deciding what extension those files would use :))
* Use [Moneta](http://github.com/wycats/moneta) for caching autogenerated javascript files.
* Allowing ice to render partials
* Allowing ice to serve as layout files.

## Copyright

MIT Licence. See MIT-LICENSE file for details.