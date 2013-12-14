# encoding: utf-8
desc "Import translates."
# http://robots.thoughtbot.com/post/18070048430/anonymizing-customer-company-and-location-data-using
namespace :import do
    task :customers => :environment do

      require "faker"
      role =[:platinum, :vip]

      guest_customer = Customer.create(
             :name => :GUEST.to_s,
             :role => :GENERAL.to_s,
             :email => "pnpbook101@gmail.com",
             :address => "100台灣台北市中正區羅斯福路三段244巷17號",
             :expire_date => Array(Date.new(2099,12,31)).sample,
             )

      File.open("./lib/tasks/name.txt", "r").each do |line|
        author = Faker::Lorem.words(2..5).join(' ').gsub('-','').gsub('\s+','\s')
        email = Faker::Internet.email(8..20)
        password = Random.rand(100000000..999999999).to_s
        phone_pre = ["0936","0972","0933","0988"]
        phone =  phone_pre.sample() + Random.rand(100000..999999).to_s 

        location, name = line.strip.split("|||")
        customer = Customer.new(
                     :name => name,
                     :role => role.sample,
                     :email => email,
                     :address => location,
                     :expire_date => Array(Date.new(2013,5,1)..Date.new(2014,12,31)).sample,
                     :phone => phone
                     )

        #Add role_record 
        role_record = RoleRecord.new()
        role_record.expire_date = customer.expire_date
        role_record.role = customer.role 

        customer.role_records << role_record


        if customer.save()  
            puts name
            Sunspot.commit
        else
            puts customer.errors.full_messages
        end

      end
    end

end
