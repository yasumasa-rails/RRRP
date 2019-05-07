class UploadSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id,:excel,:title,:contents,:updated_at
  def excel
    return unless object.excel.attached?

    object.excel.blob.attributes
        .slice('filename', 'byte_size')
        .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  end

  def excel_url
      url_for(object.excel)
  end
  def updated_at
    object.updated_at.to_date
  end
end
