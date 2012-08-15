class Document
  include Mongoid::Document

  field :name
  mount_uploader :file, DocumentUploader
  
end
