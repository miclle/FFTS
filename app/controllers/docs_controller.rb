class DocsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:upload]

  def upload
    render :json => { :result => true }
  end

  def show

  end

  def destroy

  end

end
