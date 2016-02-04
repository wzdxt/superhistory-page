class Visit < ActiveRecord::Base
  establish_connection "#{Rails.env}_main"
  scope :no_page, ->{where :page_id => nil}

  def link_to_page
    target_url = self.url.split('#').first
    self.update_attribute :page_id, Page.link(target_url)
  end

  def self.link_all_to_page
    Visit.no_page.each { |v| v.link_to_page }
  end
end
