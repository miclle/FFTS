class DocsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def show

  end

  def create
    render :json => { :result => true }
  end

  def destroy

  end

end
