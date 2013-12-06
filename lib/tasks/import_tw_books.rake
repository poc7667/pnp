# encoding: UTF-8
desc "Import books"

namespace :import do
  task :tw_books => :environment do

    require "faker"
    real_sn = 23011

    1.upto(3).each do
      File.open("lib/tasks/tw_books.txt", "r").each do |line|

        location = Faker::Lorem.words(5)

        (book_name,
        author,
        publisher,
        isbn,
        comment ) = line.strip.split("|||")

        p book_name

        isbn = isbn[/\d+/]
        real_sn += 1

        bk = Book.new(:sn => real_sn,
        :name => book_name,
        :isbn=>isbn.to_s,
        :price =>Random.rand(200..5000),
        :location=>location,
        :category=>["商業","歷史","體育","政治"].sample,
        :author => author,
        :sale_type => [
          :fix_priced,
          :normal,
          :promotion
        ].sample,
        :publisher => publisher,
        :release_date => rand(10.years).ago,
        :comment => comment
        )

        if bk.save()
          puts book_name if (real_sn % 5000 and real_sn > 5000 )==0
          # Sunspot.commit
        else
          puts bk.errors.full_messages
        end
      end


    end
  end

end
