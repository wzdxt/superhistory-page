class Page < ActiveRecord::Base
  before_create :set_default
  module STATUS
    NOT_PROCESSED = 10
  end

  def self.link(url)
    if (target = self.find_by_url(url))
      return target.id
    end
    page = self.create! :url => url
    page.id
  end

  def set_default
    self.status ||= STATUS::NOT_PROCESSED
  end
end
