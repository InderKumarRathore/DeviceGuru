Pod::Spec.new do |spec|
  spec.name = 'DeviceGuru'
  spec.version = '6.0.3'
  spec.license = 'MIT'
  spec.summary = 'DeviceGuru helps identifying the exact harware type of the device. e.g. iPhone 6 or iPhone 6s.'
  spec.homepage = 'https://github.com/InderKumarRathore/DeviceGuru'
  spec.social_media_url    = "https://twitter.com/ikr_303"
  spec.authors = { 'Inder Kumar Rathore' => '' }
  spec.source = { :git => 'https://github.com/InderKumarRathore/DeviceGuru.git', :tag => spec.version }
  spec.ios.deployment_target = '8.0'
  spec.source_files = 'Source/*.swift'
  spec.resource_bundles = {spec.name => ['Source/DeviceList.plist']}
  spec.requires_arc = true
  spec.swift_versions = ['3.2', '4.0', '4.2', '5.0']
  spec.ios.deployment_target = '8.0'
  spec.tvos.deployment_target = '9.0'
  spec.watchos.deployment_target = '2.0'
end
