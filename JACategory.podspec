Pod::Spec.new do |s|
  s.name         = "JACategory"
  s.version      = "0.0.9"
  s.summary      = "Category"
  s.description  = <<-DESC
  Daily collection of some categories
                   DESC
  s.homepage     = "https://github.com/ishepherdMiner/JACategory"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author       = { "Jason" => "iJason92@yahoo.com" }
  s.platform     = :ios, "7.0" # #{s.version}
  s.frameworks   = "UIKit","Foundation"
  s.source       = { :git => "https://github.com/ishepherdMiner/JACategory.git", :tag => "#{s.version}" }
  s.source_files = "JACategory/JACategory.h"
  # "JACategory","JACategory/**/*.{h,m}"
  #s.public_header_files = "JACategory/**/*.h"  
  s.requires_arc = true
  # s.module_name  = "JACategory"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'JACategory/NS*.{h,m}'
  end
  
  s.subspec 'UIKit' do |ss|
  	ss.dependency 'JACategory/Foundation'
    ss.source_files = 'JACategory/UI*.{h,m}'
  end
  
end
