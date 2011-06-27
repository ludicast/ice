# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "ice"
  s.summary = %q{User templates written in javascript}
  s.authors = ["Nate Kidwell"]
  s.date = %q{2010-10-04}
  s.description = %q{User templates written in javascript}
  s.email = %q{nate@ludicast.com}
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.markdown"]
  s.version = "0.4.1"
  s.add_dependency("eco", '>= 1.0.0')
  s.add_dependency("therubyracer", '>= 0.8.2')
  s.rdoc_options = ["--charset=UTF-8"]
  s.homepage = %q{http://github.com/ludicast/ice}
end
