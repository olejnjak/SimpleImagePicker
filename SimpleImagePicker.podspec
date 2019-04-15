Pod::Spec.new do |s|
  s.name             = 'SimpleImagePicker'
  s.version          = '2.2'
  s.summary          = 'Simple iOS UI component for picker images from photo library or camera'
  s.description      = <<-DESC
Simple iOS UI component for picker images from photo library or camera. 
Uses nothing more than native UIAlertController. 
Also handles situations when user doesn't give enough permissions (let's say it doesn't crash) and doesn't show empty screens.
                       DESC
  s.homepage         = 'https://github.com/olejnjak/SimpleImagePicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'olejnjak' => 'olejnjak@gmail.com' }
  s.source           = { :git => 'https://github.com/olejnjak/SimpleImagePicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/olejnjak'
  s.ios.deployment_target = '8.3'
  s.swift_version    = '5.0'
  s.source_files     = 'SimpleImagePicker/Classes/**/*.swift'
end
