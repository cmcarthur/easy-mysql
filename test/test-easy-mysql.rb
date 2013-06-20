require 'test/unit'
require 'easy-mysql'

class EasyMysqlTest < Test::Unit::TestCase

	# These tests are somewhat non-deterministic which is annoying.
	# TODO: Come up with a better way to test that these functions are working
	# as intended.

	def test_makeRandomCharacter
		(0..10).each do |n|
			assert_match( /[0-9A-Z]{1}/i, EasyMysql.makeRandomCharacter )
		end
	end

	def test_makeRandomPassword
		(0..10).each do |n|
			assert_match( /[0-9A-Z]+/i, EasyMysql.makeRandomPassword )
		end
	end

	def test_makeRandomPassword_length
		(0..10).each do |n|
			assert_equal( EasyMysql.makeRandomPassword(n).length, n )
		end
	end

end