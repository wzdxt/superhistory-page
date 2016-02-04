class ProcessController < ApplicationController
  layout false
  def index
    Visit.no_page.each{|v|v.link_to_page}
    if params.keys.include? 'pretty'
      render :text => "<pre>#{JSON.pretty_generate(Page.all.last(10).as_json)}</pre>"
    else
      render :text => ''
    end
  end
end
