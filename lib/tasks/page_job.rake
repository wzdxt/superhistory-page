namespace :page do

  desc "Link user visits url to page"
  task :link => :environment do
    while true
      Visit.no_page.each{|v|v.link_to_page}
      sleep 5
    end
  end
end