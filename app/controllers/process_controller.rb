class ProcessController < ApplicationController
  layout false

  def index
    if params.keys.include? 'force'
      Lock.delete_all
    end
    Lock.loop do
      Visit.link_all_to_page
    end
    if params.keys.include? 'pretty'
      render :text => "<pre>#{JSON.pretty_generate(Page.all.last(10).as_json)}</pre>"
    else
      render :text => ''
    end
  end
end
