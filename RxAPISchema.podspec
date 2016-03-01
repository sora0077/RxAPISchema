#
#  Be sure to run `pod spec lint RxAPISchema.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name         = "RxAPISchema"
  s.version      = "0.0.1"
  s.summary      = "RxAPISchema."

  s.description  = <<-DESC
                   API Client using Alamofire and RxSwift
                   DESC

  s.homepage     = "https://github.com/sora0077/RxAPISchema"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "" => "" }
  s.source       = { :git => "https://github.com/sora0077/RxAPISchema.git", :tag => "#{s.version}" }

  s.source_files  = "Sources/**/*.{swift}"

  s.dependency 'Alamofire'
  s.dependency 'RxSwift'

end
