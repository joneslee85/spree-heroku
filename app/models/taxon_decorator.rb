Spree::Taxon.class_eval do
  if ENV['S3_KEY'] && ENV['S3_SECRET'] && ENV['S3_BUCKET']
    S3_OPTIONS = {
      :storage => 's3',
      :s3_credentials => {
        :access_key_id     => ENV['S3_KEY'],
        :secret_access_key => ENV['S3_SECRET']
      },
      :bucket => ENV['S3_BUCKET'],
      :url => (ENV['S3_URL'] || ":s3_path_url")
    }
  else
    config_file = Rails.root.join('config', 's3.yml')
    S3_CONFIG = YAML.load_file(config_file)[Rails.env]
    S3_OPTIONS = {
      :storage => 's3',
      :s3_credentials => config_file,
      :url => (S3_CONFIG['url'] || ":s3_path_url")
    }
  end

  attachment_definitions[:icon] = (attachment_definitions[:icon] || {}).merge(S3_OPTIONS)
end