Pod::Spec.new do |s|
  s.name = 'DeviceGuru'
  s.version = '4.0.4'
  s.license = 'MIT'
  s.summary = 'DeviceGuru helps identifying the exact harware type of the device. e.g. iPhone 6 or iPhone 6s.'
  s.homepage = 'https://github.com/InderKumarRathore/DeviceGuru'
  s.social_media_url    = "https://twitter.com/ikr_303"
  s.authors = { 'Inder Kumar Rathore' => 'contact.mr.rathore@gmail.com' }
  s.source = { :git => 'https://github.com/InderKumarRathore/DeviceGuru.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.source_files = '*.swift'
  s.resource_bundles = {s.name => ['DeviceList.plist']}
  s.requires_arc = true

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
end
