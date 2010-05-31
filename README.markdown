# Ice Ice Baby!

The Ice project allows user-created templates to be written in the javascript programming language.  They are then interpreted in a sandboxed environment.  Ice is similar to Liquid in terms of safety, but uses javascript to leverage the powers of a language most developers are familiar with.

Ice runs the templates through an erb-ish parser and then uses the [therubyracer](http://github.com/cowboyd/therubyracer) to interpet the javascript using Google's V8 javascript engine.  Your users can then write Ice templates like:

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

Liquid is excellent but has several disadvantages

* Hard to extend without knowing Liquid internals
* Introduces yet-another-language, whereas many designers/developers are already familiar with javascript
* Doesn't allow template creators to use a rich object model and easily create their own functions
* Doesn't have a rich set of support libraries like what javascript brings to the table

Note that we're still big fans of Liquid.  In fact, we call this project "Ice" as a tribute (extending the metaphor, we use "Cubes" where they have "Drops").

## Installation

For Rails:

    config.gem 'ice'

Otherwise:

    gem install ice

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