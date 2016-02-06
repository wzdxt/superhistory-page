class Page < ActiveRecord::Base
  before_create :set_default
  module STATUS
    NOT_PROCESSED = 10
  end

  def check_redirect!
    begin
      client = HTTPClient.new
      client.connect_timeout = 3
      client.send_timeout = 3
      client.receive_timeout = 3
      res = client.head(self.url)
      if redirect_url = res.headers.transform_keys { |k| k.downcase }['content-location']
        self.update_attribute :target_page_id, Page.link(redirect_url)
        return
      end
      raise if res.status != 200
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
      page.check_redirect!
    end
    begin
      client = HTTPClient.new
      client.receive_timeout = 0.0001
      client.get Settings.http_triggers.self
    ensure
      return page.id
    end
  end

  def set_default
    self.status ||= STATUS::NOT_PROCESSED
  end
end
