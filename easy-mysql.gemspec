Gem::Specification.new do |s|
	s.name        = 'easy-mysql'
	s.version     = '0.1.0'
	s.date        = '2013-06-21'
	s.summary     = "easy-mysql"
	s.description = "A simple way to set up a secure MySQL connection."
	s.authors     = ["Connor McArthur"]
	s.files       = ["lib/easy-mysql.rb"]
	s.executables << "easy-mysql"
	s.homepage    =
	'http://rubygems.org/gems/easy-mysql'

	s.add_dependency('mysql')
	s.add_dependency('rainbow')
end