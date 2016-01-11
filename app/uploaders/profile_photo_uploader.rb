# encoding: utf-8

class ProfilePhotoUploader < CarrierWave::Uploader::Base

  # process resize_to_fit: [800, 800]

  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
