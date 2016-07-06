# Paperclip::Attachment.default_options[:s3_host_name] = 'us-west-2'

Rails.application.config.before_initialize do
  Paperclip::Attachment.default_options[:url] = ':popstar.s3.amazonaws.com'

  Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
end

Paperclip::Attachment.default_options[:s3_host_name] = 'us-standard.amazonaws.com'
Paperclip::Attachment.default_options[:s3_region] = ENV['AWS_REGION']
Paperclip::Attachment.default_options[:bucket] = ENV['S3_BUCKET_NAME']
