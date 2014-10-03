#!/usr/bin/env ruby

require 'qiniu'

Qiniu.establish_connection! :access_key => Rails.application.secrets.qiniu_access_key,
                            :secret_key => Rails.application.secrets.qiniu_secret_key