

Pod::Spec.new do |s|
  s.name                = "DeviceGuru"
  s.version             = "1.0.0"
  s.summary             = "DeviceGuru is a simple lib (Swift) to know the exact type of the device instead of just iPhone or iPad"
  s.homepage            = "https://github.com/InderKumarRathore/DeviceGuru.git"
  s.license             = { :type => "MIT", :file => "LICENSE" }
  s.author              = { "Inder Kumar Rathore" => "contact.mr.rathore@gmail.com" }
  s.social_media_url    = "http://facebook.com/InderKumarRathore"
  s.source              = { :git => "https://github.com/InderKumarRathore/DeviceGuru.git", :tag => '1.0.0' }
  s.source_files        = "DeviceGuru.swift"
  s.platform            = :ios, "8.0"
  s.requires_arc        = false
end
