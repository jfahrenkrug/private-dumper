# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{private-dumper}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Johannes Fahrenkrug"]
  s.date = %q{2011-01-04}
  s.default_executable = %q{private-dumper}
  s.description = %q{The private iOS iPhone and iPad frameworks are full of wonderful goodies that are just waiting to be discovered. The fantastic class-dump tool lets you peek into those frameworks and generates the header files that you need to use them in your project. Private Dumper greatly simplifies the process of dumping the header files of all private frameworks for a given SDK version.}
  s.email = %q{johannes@springenwerk.com}
  s.executables = ["private-dumper"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/private-dumper",
    "helper.rb",
    "lib/private-dumper.rb",
    "test_private-dumper.rb"
  ]
  s.homepage = %q{http://github.com/jfahrenkrug/private-dumper}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{A Ruby class-dump wrapper to create header files from private iOS frameworks}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end
