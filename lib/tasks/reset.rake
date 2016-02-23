desc 'reset page'
task :reset  => :environment do
  p Visit.reset_page_id
  p Page.reset_table
end