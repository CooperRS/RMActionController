Pod::Spec.new do |s|

  s.name                 = "RMActionController"
  s.version              = "1.2.1"
  s.platform             = :ios, '8.0'
  s.summary              = "This is an iOS control for presenting any UIView in an UIAlertController like manner"
  s.description          = "This framework allows you to present just any view as an action sheet. In addition, it allows you to add actions arround the presented view which behave like a button and can be tapped by the user. The result looks very much like an UIActionSheet or UIAlertController with a special UIView and some UIActions attached."
  
  s.homepage             = "https://github.com/CooperRS/RMActionController"
  s.screenshots          = "http://cooperrs.github.io/RMActionController/Images/Blur-Screen-Portrait.png", "http://cooperrs.github.io/RMActionController/Images/Blur-Screen-Landscape.png", "http://cooperrs.github.io/RMActionController/Images/Blur-Screen-Portrait-Black.png"
  
  s.license              = { :type => 'MIT', :file => 'LICENSE' }
  s.author               = { "Roland Moers" => "rm@cooperrs.de" }
  
  s.source               = { :git => "https://github.com/CooperRS/RMActionController.git", :tag => "1.2.1" }
  s.source_files         = 'RMActionController/**/*.{h,m}'
  s.public_header_files  = 'RMActionController/RMActionController.h', 'RMActionController/Actions/RMAction.h', 'RMActionController/Actions/RMImageAction.h', 'RMActionController/Grouping Actions/RMGroupedAction.h', 'RMActionController/Grouping Actions/RMScrollableGroupedAction.h'
  
  s.requires_arc         = true
  s.framework            = 'CoreGraphics', 'QuartzCore'
end
