#Ice Ice Baby

The Ice system for Javascript templating allows people to serve Javascript templates thanks to [The Ruby Racer](http://github.com/cowboyd/therubyracer), a gem letting you use Google's V8 Javascript engine.  These templates are then compiled and served to the browser.

One of the key advantages of this approach is that the templates execute in their own sandbox.  This is the approach taken by [Liquid](http://github.com/tobi/liquid) and some of the other template systems.

The template parser we currently use is Eco, (written by [Sam Stephenson](https://github.com/sstephenson/eco)).  This allows you to use Coffeescript with HTML in an ERB-ish fashion.

You can then write Eco templates like:

    <table>
        <tr><th>Name</th><th>Email</th></tr>
        <% for user in @users %>
            <tr>
                <td><%= user.name %></td><td><%= @mailTo(user.email) %></td>
            </tr>
        <% end %>
    </table>

Eco-formatted files may also exist in your filesystem, provided they have a .eco extension.  Also, the templates may be compiled on demand with the method:

    Ice.convert_eco_template(template_text, vars = {})

## Installation

Ice is currently being developed only for Rails 3.  Simply add to your Gemfile

    gem 'ice'

## to_ice

Every object is revealed to the templates via its to_ice method.  This helps sanitize the objects that are passed into Ice, so people editing the template only have access to a limited subset of the data.

Instances of some classes like String and Numeric just return themselves as the result of to_ice.  Hashes and Arrays run to_ice recursively on their members.

If you want an object to map to a different representation, simply define a to_ice object that returns whatever object you want to represent it within the eco template.  These objects are referred to as "Cubes", and are equivalent to "Drops" for those used to the Liquid template.

## ActiveModel and to_ice

To make life easy, since most complex objects passed to the templates will be classes including ActiveModel::Serializable, the default to_ice behaviour of these classes is to pass itself in to a class with the same name, but followed by the word "Cube".

Therefore calling to_ice on instance of a User class will invoke

    UserCube.new self

## BaseCube Class

You can have your cubes inherit from our Ice::BaseCube class.  Your cubes inheriting from it can then determine what additional attributes they want to reveal.  For example

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

Partials may now be written in Eco, and included in Erb (and other) templates.

## NavBar

To make it easier to generate links, we added a `@navBar` helper.

    <%- @navBar (bar) => %>
        <%- bar.linkTo("Bar", "/foo") %>
        <%- bar.linkTo("http://ludicast.com") %>
    <% end %>

This then generates the following html

    <ul class="linkBar">
        <li><a href="/foo">Bar</a></li>
        <li><a href="http://ludicast.com">http://ludicast.com</a></li>
    </ul>

The `@navBar` helper also takes options so if the above was instead instantiated with:

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
* Haml support
* Use [Moneta](http://github.com/wycats/moneta) for caching autogenerated javascript files.
* Allowing Ice to render Rails partials
* Allowing Ice to serve as Rails layout files.

## Copyright

MIT Licence. See MIT-LICENSE file for details.