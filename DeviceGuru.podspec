

Pod::Spec.new do |s|
  s.name = 'DeviceGuru'
  s.version = '1.3.0'
  s.license = 'MIT'
  s.summary = 'DeviceGuru helps identifying the exact harware type of the device. e.g. iPhone 6 or iPhone 6s.'
  s.homepage = 'https://github.com/InderKumarRathore/DeviceGuru'
  s.social_media_url    = "https://twitter.com/InderKRathore"
  s.authors = { 'Inder Kumar Rathore' => 'contact.mr.rathore@gmail.com' }
  s.source = { :git => 'https://github.com/InderKumarRathore/DeviceGuru.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.source_files = '*.swift'
  s.requires_arc = true
end