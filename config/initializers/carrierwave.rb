CarrierWave.configure do |config|

    # Use local storage if in development or test
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => "AKIAIZG3GC6YONVB3D4Q",            # required
    :aws_secret_access_key  => "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",     # required
    :region                 => 'eu-east-1'                        # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'appname-bucket'               # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
