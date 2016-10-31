Pod::Spec.new do |s|
  s.name         = "RMActionController"
  s.platform     = :ios, '8.0'
  s.version      = "1.1.0"
  s.summary      = "This is an iOS control for presenting any UIView in UIActionSheet/UIActionController like manner"
  s.homepage     = "https://github.com/CooperRS/RMActionController"
  s.screenshots  = "http://cooperrs.github.io/RMActionController/Images/Blur-Screen-Portrait.png", "http://cooperrs.github.io/RMActionController/Images/Blur-Screen-Landscape.png", "http://cooperrs.github.io/RMActionController/Images/Blur-Screen-Portrait-Black.png"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Roland Moers" => "rm@cooperrs.de" }
  s.source       = { :git => "https://github.com/CooperRS/RMActionController.git", :tag => "1.1.0" }
  s.source_files = 'RMActionController/*'
  s.requires_arc = true
  s.framework    = 'CoreGraphics', 'QuartzCore'
end
