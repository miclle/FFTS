class Doc
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :desc
  field :hash
  field :key
  field :dntoken
  field :deadline, type: Integer

end
