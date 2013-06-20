require 'mysql'
require 'rainbow'

class EasyMysql
	def self.driver
		puts " easy-mysql, created by Connor McArthur "

		begin
			new_mysql_user_info = self.getInputAndMakeMySQLUser
			new_linux_user_info = self.getInputAndMakeLinuxUser
		rescue
			return false
		end

		puts "\r\nMySQL".background(:yellow).bright
		puts "Username: {#new_mysql_user_info.username}"
		puts "Password: {#new_mysql_user_info.password}"

		puts "\r\nLinux User".background(:yellow).bright
		puts "Username: {#new_linux_user_info.username}"
		puts "Password: {#new_linux_user_info.password}"

		puts "\r\nSUCCESS!".background(:red).bright
	end

	def self.getInputAndMakeLinuxUser
		puts "\n\rEnter a username for the new Linux user: "

		print "Username: ".bright
		linux_username = gets.chomp

		puts "\n\rPaste in the public key for the new Linux user: "

		print "Public Key Text: ".bright
		linux_pubkey = gets.chomp

		new_linux_user_info = self.addLinuxUser(linux_username)
		self.setUpLinuxUserFilesystem(linux_username, linux_pubkey)
	end

	def self.addLinuxUser(username)
		group = username
		password = self.makeRandomPassword

		output = `useradd -p #{password.crypt("JU")} -g #{group} #{username}`

		unless $?.to_i == 0
			raise $?
		end

		return { username: username, password: password }
	end

	def self.setUpLinuxUserFilesystem(username, pubkeytext)
		begin
			Dir.mkdir("/home/#{username}") unless File.exists?("/home/#{username}")
			Dir.mkdir("/home/#{username}/.ssh") unless File.exists?("/home/#{username}/.ssh")

			File.open("/home/#{username}/.ssh/authorized_keys", 'w') do |file| 
				file.write pubkeytext
			end

			`chown -R #{username}:#{username} /home/#{username}`
			`chmod -R 0600 /home/#{username}/.ssh`
		rescue => e
			puts "\r\nERROR! #{e.message}".background(:red).bright
			raise e
		end
	end

	def self.getInputAndMakeMySQLUser
		puts "\n\rEnter your MySQL admin login credentials: "
		
		print "Username: ".bright
		mysql_admin_username = gets.chomp
		print "Password: ".bright
		mysql_admin_password = gets.chomp

		begin
			connection = self.makeMySQLConnection(mysql_admin_username, mysql_admin_password)
		rescue => e
			puts "\r\nERROR! #{e.message}".background(:red).bright
			raise e
		end

		puts "\n\rEnter a username for the new MySQL user: "

		print "Username: ".bright
		mysql_new_username = gets.chomp

		begin
			new_user = self.addMySQLUser(connection, mysql_new_username)
		rescue => e
			puts "\r\nERROR! #{e.message}".background(:red).bright
			raise e
		end

		return new_user
	end

	def self.makeMySQLConnection(username, password)
		Mysql::new('127.0.0.1', username, password)
	end

	def self.addMySQLUser(connection, new_username)
		puts "Creating a new MySQL user..."

		new_password = self.makeRandomPassword

		query = "GRANT SELECT ON *.* TO `#{new_username}`@`127.0.0.1` IDENTIFIED BY '#{new_password}'";

		connection.query(query)

		return { username: new_username, password: new_password }
	end

	def self.makeRandomPassword(len = 24)
		(0...len).map{self.makeRandomCharacter}.join
	end

	def self.makeRandomCharacter
		type = rand(3)

		if type == 0
			# uppercase letters
			return (65+rand(26)).chr
		elsif type == 1
			# lowercase letters
			return (97+rand(26)).chr
		else
			# numbers
			return rand(9).to_s
		end
	end
end