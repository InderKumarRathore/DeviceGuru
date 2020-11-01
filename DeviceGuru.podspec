Pod::Spec.new do |spec|
  spec.name = 'DeviceGuru'
  spec.version = '7.0.0'
  spec.license = 'MIT'
  spec.summary = 'DeviceGuru helps identifying the exact harware type of the device. e.g. iPhone 6 or iPhone 6s.'
  spec.homepage = 'https://github.com/InderKumarRathore/DeviceGuru'
  spec.social_media_url    = "https://twitter.com/ikr_303"
  spec.authors = { 'Inder Kumar Rathore' => '' }
  spec.source = { :git => 'https://github.com/InderKumarRathore/DeviceGuru.git', :tag => spec.version }
  spec.requires_arc = true
  spec.swift_versions = ['3.2', '4.0', '4.2', '5.0', "5.1", "5.2", "5.3"] # we should remove this eventually
  spec.platforms = { :ios => "8.0", :tvos => "9.0", :watchos => "2.0" }

  spec.default_subspec  = "DeviceGuru"

  spec.subspec "DeviceGuru" do |ss|
    ss.dependency "DeviceGuru/Resources"
    ss.source_files = "Sources/*.swift"
  end

  spec.subspec "Resources" do |ss|
    ss.resource_bundle = { spec.name => 'Sources/DeviceList.plist' }
  end

end
