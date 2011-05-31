# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "ice"
  s.summary = %q{User templates written in javascript}
  s.authors = ["Nate Kidwell"]
  s.date = %q{2010-10-04}
  s.description = %q{User templates written in javascript}
  s.email = %q{nate@ludicast.com}
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.3.0"
  s.rdoc_options = ["--charset=UTF-8"]
  s.homepage = %q{http://github.com/ludicast/ice}
end