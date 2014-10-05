class Doc
  include Mongoid::Document

  field :name
  field :desc
  field :hash
  field :key
  field :dntoken
  field :deadline, type: Integer

end
