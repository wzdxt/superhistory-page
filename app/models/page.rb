class Page < ActiveRecord::Base
  before_create :set_default
  module STATUS
    NOT_PROCESSED = 10
    REDIRECT = 30
    HTTP_STATUS_NOT_200 = 110
  end

  def check_status
    begin
      client = HTTPClient.new
      client.connect_timeout = client.send_timeout = client.receive_timeout = Settings.http_wait_time
      res = client.head(self.url)
      self.update_attribute :http_status, res.status
      if res.status != 200
        self.update_attribute :status, STATUS::HTTP_STATUS_NOT_200
      end
      if redirect_url = res.headers.transform_keys { |k| k.downcase }['content-location']
        self.update_attributes :target_page_id => Page.link(redirect_url), :status => STATUS::REDIRECT
      end
    rescue HTTPClient::ConnectTimeoutError, HTTPClient::ReceiveTimeoutError => e
# ignored
    rescue => e
      puts e.class, e.backtrace
# ignored
    end
  end

  def self.link(url)
    page = self.find_by_url(url)
    if page.nil?
      page = self.create! :url => url
      page.check_status
    end
    return page.id
  end

  def self.remove_illegal
    self.all.each do |page|
      page.delete unless Visit.find_by_page_id page.id
    end
  end

  def self.reset_table
    self.delete_all
  end

  private

  def set_default
    self.status ||= STATUS::NOT_PROCESSED
  end
end
