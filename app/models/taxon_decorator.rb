Spree::Taxon.class_eval do
  if Rails.env.production?    
    if ENV['S3_KEY'] && ENV['S3_SECRET'] && ENV['S3_BUCKET']
      S3_OPTIONS = {
        :storage => 's3',
        :s3_credentials => {
          :access_key_id     => ENV['S3_KEY'],
          :secret_access_key => ENV['S3_SECRET']
        },
        :bucket => ENV['S3_BUCKET']
      }
    else
      S3_CONFIG = YAML.load_file(Rails.root.join('config', 's3.yml'))[Rails.env]
      S3_OPTIONS = {
        :storage => 's3',
        :s3_credentials => Rails.root.join('config', 's3.yml'),
        :url => S3_CONFIG['url'] ? S3_CONFIG['url'] : ":s3_domain_url"
      }
    end
  else
    S3_OPTIONS = { :storage => 'filesystem' } unless defined?(S3_OPTIONS)
  end

  attachment_definitions[:icon] = (attachment_definitions[:icon] || {}).merge(S3_OPTIONS)
end