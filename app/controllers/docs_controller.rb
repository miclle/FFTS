class DocsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def show
    @doc = Doc.find params[:id]

    primitive_url = "http://ffts.qiniudn.com/#{@doc.key}?e=#{@doc.deadline}"
    @download_url = Qiniu::Auth.authorize_download_url(primitive_url)

    code, result, response_headers = Qiniu::Storage.stat 'ffts', @doc.key

    @fsize = result["fsize"]
  end

  def new
    put_policy = Qiniu::Auth::PutPolicy.new('ffts')
    # put_policy.callback_url = "http://ffts.io/file"
    # put_policy,callback_body = "key=$(key)&hash=$(hash)"
    @uptoken = Qiniu::Auth.generate_uptoken(put_policy)
  end

  def create
    @doc = Doc.create(:hash => params[:hash], :key => params[:key], :deadline => Time.now.to_i + 60 * 30)

    render :json => doc_root_url(@doc).to_json
  end

  def destroy

  end

end
