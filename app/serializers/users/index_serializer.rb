module Users
  class IndexSerializer < ActiveModel::Serializer
    attributes :id, :name, :email_address
  end
end
