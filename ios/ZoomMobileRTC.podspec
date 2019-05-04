Pod::Spec.new do |s|

  s.name         = "ZoomMobileRTC"
  s.authors      = "Zoom.us"
  s.homepage     = "https://github.com/zoom/zoom-sdk-ios"
  s.libraries    =  "sqlite3", "z.1.2.5"
  s.license      = 'MIT'
  s.summary      = "ZOOM iOS SDK"
  s.version      = "4.3.47201.0322"
  s.source       = { :http => "https://github.com/zoom/zoom-sdk-ios/releases/download/v4.3.1.47201.0322/ios-mobilertc-all-4.3.47201.0322-n.zip" }
  s.platform     = :ios, "9.0"
  
  s.description  = <<-DESC
                   Zoom SDK makes it easy to integrate Zoom with your iOS applications, and boosts up your applications with the power of Zoom.
                   DESC
  
  s.source_files        = "ios-mobilertc/lib/MobileRTC.framework/Headers/*.{h}"
  s.header_dir          = "ios-mobilertc/lib/MobileRTC"
  s.public_header_files = "ios-mobilertc/lib/MobileRTC.framework/Headers/*.h"
  s.vendored_frameworks = "ios-mobilertc/lib/MobileRTC.framework"
  s.resources           = "ios-mobilertc/lib/MobileRTCResources.bundle"
  s.frameworks          = "MobileRTC", "VideoToolbox"

  s.xcconfig = {"ENABLE_BITCODE" => "NO"}

end
