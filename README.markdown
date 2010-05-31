# ice

This project allows user-submitted templates to be written in the javascript programming language.  It is similar to liquid, but uses javascript to leverage the powers of a language most developers are familiar with.

It uses the fantastic gem therubyracer to compile the javascript using google's v8 javascript engine.  Soon, it will have support for using files with a .ice extension.

## to_ice

Every object is revealed to the templates via their to_ice method.  This helps filter the objects that are passed into the javascript.

Instances of some classes like String and Numeric just return themselves as the result of to_ice.  Hashes and Arrays run to_ice recursively on their members.

## ActiveRecord modifications

To make life easy, since most complex objects passed to the templates will be subclasses of ActiveRecord::Base, the default behaviour of ActiveRecord is to pass itself in to a class with the name name, followed by the word "Cube".

Therefore an instance of a User class will ice itself by calling

  UserCube.new self

## BaseCube Class

In order for everything to work easily, you can have your cubes inherit from our Ice::BaseCube class.

Your Cubes inheriting from it can then add additional attributes.  For example

    class BookCube < Ice::BaseCube
      revealing :title, :author_id, :genre_id
    end

would provide a cube with access to the title, author_id and genre properties of the underlying ActiveRecord.

These cubes also have belongs_to and has_many associations, so you can write things like:

    class ArticleCube < Ice::BaseCube
      has_many :comments, :tags
      belongs_to :author, :section
    end

This brings in association helper functions such as comment_ids, num_comments, has_comments, comments, author_id, and author.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add spec for it. This is important so I don't break it in a future version unintentionally.  In fact, try to write your specs in a test-first manner.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request.

## Copyright

Copyright (c) 2010 Nate Kidwell. See LICENSE for details.