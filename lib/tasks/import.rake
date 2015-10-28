require 'roo'
require 'securerandom'
namespace :import do

	desc "Import users from .xsl file to database"
	task xls: :environment do

		data = Roo::Spreadsheet.open("lib/tasks/users.xls", extension: :xlsx) 
		p data.inspect

    i = 0
    data.each do |row|
    	begin
    		next if row[0] == 'Imię'

	    	first_name = row[0].titleize
	    	last_name = modify_last_name(row[1])
	    	email = row[2].downcase
	    	expiration_date = row[3]
	    	username = (first_name + last_name).slice!(0..4) + rand(100..999).to_s
	    	username.downcase!	    	
	    	if username.length < 8
	    		username = [*('a'..'z')].sample(6).join + rand(10..99).to_s
	    	end
				password = SecureRandom.hex(8)

	    	User.create!(
	    		email: email,
	    		username: username,
	    		first_name: first_name,
	    		last_name: last_name,
	    		expiration_date: expiration_date,
	    		password: password,
	    		password_confirmation: password)

	    	i = i + 1
	    	p i.to_s + ' record added'
	    rescue => e
	    	p e.message
	    end
    end

    p 'Records added: ' + i.to_s
	end
end

def modify_last_name(name)
	name = name.downcase
	if name.include? "-"
		name.gsub!(/-/, ' ')
		name = name.titleize
		name.gsub!(/ /, '-')
	else
		name.titleize
	end
end