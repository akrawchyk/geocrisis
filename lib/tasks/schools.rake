require 'csv'
require 'nokogiri'
require 'open-uri'
require 'cgi'

namespace :public_schools do
  desc "populate db with the most populated cities in the US"
  task :populate => :environment do
    class State; attr_accessor :code, :name, :web_id; end

    states_csv = CSV.read("#{Rails.root}/lib/assets/states.csv", encoding: "ISO8859-1")
    #s = State.new(:name => s_csv[1], :code => s_csv[2], :web_id => s_csv[3])

    #for every state
    states_csv[1..-1].each do |state|
      puts "Processsing state: #{state[2]}"

      #for every county
      County.find_all_by_state_code(state[2]).each do |county|
        puts "Processsing county: #{county.name}"

        puts "Fetching data from: #{"http://nces.ed.gov/ccd/schoolsearch/school_list.asp?Search=1&State=#{state[3]}&County=#{CGI::escape county.name}&SpecificSchlTypes=all&IncGrade=-1&LoGrade=-1&HiGrade=-1"}"

        #get school data
        county_url = "http://nces.ed.gov/ccd/schoolsearch/school_list.asp?Search=1&State=#{state[3][1..-1]}&County=#{CGI::escape county.name}&SpecificSchlTypes=all&IncGrade=-1&LoGrade=-1&HiGrade=-1"
        doc = Nokogiri::HTML(open county_url)

        matches = doc.css('.sfsContent table[4] tr[1]')

        matches.each_with_index do |row,index|
          next if index < 2 or index > matches.length-2
          puts "Processing school..."

          name = row.css('td[2] font a strong').text
          address = row.css('td[2] font font').text
          phone = row.css('td[3] font').text

          Contact.create(:name => name, :address => address, :phone => phone, :type => 'school', :county_id => county.id)
        end
      end
    end
  end
end