class WelcomeController < ApplicationController

  def index
    @doc = Doc.new

    put_policy = Qiniu::Auth::PutPolicy.new('ffts')
    put_policy.callback_url = "http://ffts.io/file"

    @uptoken = Qiniu::Auth.generate_uptoken(put_policy)

  end

end
