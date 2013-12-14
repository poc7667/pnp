# encoding: utf-8
desc "Import User."
# http://robots.thoughtbot.com/post/18070048430/anonymizing-customer-company-and-location-data-using
namespace :import do
    task :users => :environment do

      # b=Branch.last
      # b.name="古今書廊-博雅館"
      # b.save()

      newuser = User.new({
        password: "test",
        password_confirmation: "test",
        role: "admin",
        email: "pnpbook101+01@gmail",
        name: "人文館店員"
        })

      p newuser

      # newuser.confim!
      newuser.save

      newuser = User.new({
        password: "test",
        password_confirmation: "test",
        role: "admin",
        email: "pnpbook101+02@gmail",
        name: "博雅館店員"
        })
      p newuser

      # newuser.confim!
      newuser.save

      Sunspot.commit
      
      end

end
