#
# Be sure to run `pod lib lint Stateful.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Stateful'
  s.version          = '2.0.0'
  s.summary          = 'The easiest state machine in Swift'
  s.description      = <<-DESC
A minimalistic, thread-safe, non-boilerplate and super easy to use state machine in Swift.
                       DESC

  s.homepage         = 'https://github.com/albertodebortoli/Stateful'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alberto De Bortoli' => 'albertodebortoli.website@gmail.com' }
  s.source           = { :git => 'https://github.com/albertodebortoli/Stateful.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/albertodebo'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  s.source_files = 'Stateful/Classes/**/*.swift'
  s.frameworks = 'Foundation'

  s.test_spec 'StatefulUnitTests' do |test_spec|
    test_spec.source_files = 'Stateful/UnitTests/**/*.swift'
  end
end
