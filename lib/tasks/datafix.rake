desc 'fix visit 1623'
task :fix_visit_1623  => :environment do
  p Visit.find(1623).link_to_page
end