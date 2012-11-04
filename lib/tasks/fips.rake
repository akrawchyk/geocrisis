namespace :fips do
  desc "Drop and create the current fips table"
  task :reseed => :environment do
    require 'open-uri'
    open("http://www.nws.noaa.gov/nwr/SameCode.txt") { |f|
      f.each_line { |line|
        fip, name = line.match(/(.*,?){2},.*?\n?/)[0].split(',')

        County.create(:fip => fip, :name => name)
      }
    }
  end
end