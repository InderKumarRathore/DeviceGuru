

Pod::Spec.new do |s|
  s.name = 'DeviceGuru'
  s.version = '1.1.0'
  s.license = 'MIT'
  s.summary = 'DeviceGuru is a simple lib (Swift) to know the exact type of the device instead of just iPhone or iPad'
  s.homepage = 'https://github.com/InderKumarRathore/DeviceGuru'
  s.social_media_url = 'http://facebook.com/InderKumarRathore'
  s.authors = { 'Inder Kumar Rathore' => 'contact.mr.rathore@gmail.com' }
  s.source = { :git => 'https://github.com/InderKumarRathore/DeviceGuru.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.source_files = '*.swift'
  s.requires_arc = true
end