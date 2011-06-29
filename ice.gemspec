# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "ice"
  s.summary = %q{User templates written in javascript}
  s.authors = ["Nate Kidwell"]
  s.date = %q{2011-06-29}
  s.description = %q{User templates written in javascript}
  s.email = %q{nate@ludicast.com}
  s.files = Dir["{app,lib,config,js}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.markdown"]
  s.version = "0.4.4"
  s.add_dependency("eco", '>= 1.0.0')
  s.add_dependency("therubyracer", '>= 0.9.1')
  s.rdoc_options = ["--charset=UTF-8"]
  s.homepage = %q{http://github.com/ludicast/ice}
end
