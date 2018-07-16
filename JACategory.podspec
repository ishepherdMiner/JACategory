Pod::Spec.new do |s|
  s.name         = "JACategory"
  s.version      = "0.0.8"
  s.summary      = "Category"
  s.description  = <<-DESC
  Daily collection of some categories
                   DESC
  s.homepage     = "https://github.com/ishepherdMiner/JACategory"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author       = { "Jason" => "iJason92@yahoo.com" }
  s.platform     = :ios, "7.0" # #{s.version}
  s.source       = { :git => "https://github.com/ishepherdMiner/JACategory.git", :tag => "#{s.version}" }
  s.source_files =  "JACategory","JACategory/*.{h,m}"
  s.public_header_files = "JACategory/*.h"
  s.frameworks   = "UIKit", "QuartzCore","Foundation"
  s.requires_arc = true
  s.module_name  = "JACategory"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
