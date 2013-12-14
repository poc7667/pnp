# encoding: utf-8
desc "Import branches."
# http://robots.thoughtbot.com/post/18070048430/anonymizing-customer-company-and-location-data-using
namespace :import do
    task :branches => :environment do

      # b=Branch.last
      # b.name="古今書廊-博雅館"
      # b.save()

      Branch.create(
        name: "古今書廊-人文館",
        address: "100台灣台北市中正區羅斯福路三段244巷17號"
        )
      Branch.create(
        name: "古今書廊-博雅館",
        address: "100台灣台北市中正區羅斯福路三段244巷17號"
        )

      Sunspot.commit
      
      end

end
