class ProcessController < ApplicationController
  layout false

  def index
    if params.keys.include? 'force'
      Lock.delete_all
    end
    Lock.loop do
      Visit.link_all_to_page
    end
    render :text => ''
  end
end
