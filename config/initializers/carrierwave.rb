CarrierWave.configure do |config|

    # Use local storage if in development or test
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => ENV["S3_ACCESS_KEY"],            # required
    :aws_secret_access_key  => ENV["S3_SECRET_KEY"],     # required
    :region                 => 'eu-east-1'                        # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = ENV["S3_BUCKET"]               # required
  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
