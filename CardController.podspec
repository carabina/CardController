#
# Be sure to run `pod lib lint CardController.podspec' to ensure this is a
# valid spec before submitting.
#


Pod::Spec.new do |s|
  s.name             = 'CardController'
  s.version          = '0.1.0'
  s.summary          = 'Container View Controller to manage and animate a list of child view controllers.'


  s.description      = <<-DESC
CardController is a simple container view controller that manages a list of child view controllers
and allows them to be presented full screen, and dismissed into a custom menu configuration.
All the view animations are customizable and interruptible.
                       DESC

  s.homepage         = 'https://github.com/manuelcarlos/CardController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Manuel Carlos' => 'manuelcarlosLopes@icloud.com' }
  s.source           = { :git => 'https://github.com/manuelcarlos/CardController.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'CardController/Classes/**/*'
  

end
