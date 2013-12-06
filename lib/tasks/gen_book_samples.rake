desc "Import books samples"
namespace :db do
    
    task :gen_books => :environment do
        require "faker"
        require "faker-isbn"
        for i in 1..10
            bk_name= Faker::Lorem.words(2..5).join(' ').gsub('-','').gsub('\s+','\s')
            bk = Book.new(:name => bk_name, :isbn=>Faker::ISBN.thirteen_digit, 
                         :price =>Random.rand(200..5000))
            bk.save()
        end
    end

end
