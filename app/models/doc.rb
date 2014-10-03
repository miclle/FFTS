class Doc
  include Mongoid::Document

  field :name
  field :desc
  field :expires, type: DateTime

end
