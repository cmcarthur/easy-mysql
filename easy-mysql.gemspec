Gem::Specification.new do |s|
	s.name        = 'easy-mysql'
	s.version     = '0.0.1'
	s.date        = '2013-06-20'
	s.summary     = "easy-mysql"
	s.description = "A simple way to set up a secure MySQL connection."
	s.authors     = ["Connor McArthur"]
	s.email       = 'connormcarthur11@gmail.com'
	s.files       = ["lib/easy-mysql.rb"]
	s.executables << "easy-mysql"
	s.homepage    =
	'http://rubygems.org/gems/easy-mysql'

	s.add_dependency('mysql', '2.9.1')
	s.add_dependency('rainbow', '1.1.4')
end