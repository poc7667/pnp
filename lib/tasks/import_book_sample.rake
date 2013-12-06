desc "Import translates."

namespace :import do
    task :books => :environment do

      require "faker"
      real_sn = 1000000000
      File.open("./books.txt", "r").each do |line|
        author = Faker::Lorem.words(2..5).join(' ').gsub('-','').gsub('\s+','\s')
        comment = Faker::Lorem.words(20..50)
        sn, name,publisher, cate, location, isbn  = line.strip.split("|||")
        real_sn += 1
        bk = Book.new(:sn => real_sn,:name => name,
                      :isbn=>isbn, 
                      :price =>Random.rand(200..5000), 
                      :location=>location, 
                      :category=>cate,
                      :author => author,
                      :sale_type => [:fix_priced, :normal, :promotion].sample,
                      :publisher => publisher,
                      :release_date => rand(10.years).ago, 
                      :comment => comment
                     )
        if bk.save()  
            puts name
        else
            puts sn
            puts bk.errors.full_messages
        end

      end
    end

end