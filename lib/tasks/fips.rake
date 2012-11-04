namespace :fips do
  desc "Drop and create the current fips table"
  task :reseed => :environment do
    require 'open-uri'
    open("http://www.nws.noaa.gov/nwr/SameCode.txt") { |f|
      f.each_line { |line|
        fip, name = line.match(/(.,?){2},.?\n?/)[0].split(',')

        name = 'Carson City' if fip == '032510'

        County.create(:fip => fip, :name => name)
      }
    }
  end

  desc "fetch zip code-country relational data"
  task :fetch_zips => :environment do
    require 'nokogiri'
    require 'open-uri'

    #State.all.each do |state|
    states = [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
    ]
    states.each do |state|
      doc = Nokogiri::HTML(open("http://www.unitedstateszipcodes.org/#{state[1].downcase}/"))
      doc.css("table.lined tr").each do |item|
        if !item.attribute('class') or item.attribute('class').text != 'header_row'
          zip = item.at_css('td[1]').text # Zip Code
          county_name = item.at_css('td[4]').text.gsub(/( County)?( Borough)?(Municipality of )?/, '').gsub('St ', 'St. ') # County
          begin
            county = County.find_by_name(county_name)
            county.zipcodes << Zipcode.find_or_create_by_code(zip)
          rescue
            puts item.inspect
          end
        end
      end
    end
  end

  desc "fetch zip code-country relational data"
  task :populate_zips => :environment do
    zipcodes = CSV.read("#{Rails.root}/lib/assets/zipcodes.csv", encoding: "ISO8859-1")
    zipcodes.each do |zip|
      Zipcode.find_or_create_by_code_and_county_id(zip[1].strip, zip[3].strip)
    end
  end
end
