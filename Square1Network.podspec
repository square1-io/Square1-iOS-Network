Pod::Spec.new do |s|

  s.name         = "Square1Network"
  s.version      = "1.0.3"
  s.summary      = "A group of helpers to create networks requests and handle their responses easily."
  s.description  = "This is a group of types and protocols to help to create simple network requests."
  s.homepage     = "https://github.com/square1-io/Square1-iOS-Network"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = "Square1"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/square1-io/Square1-iOS-Network.git", :tag => s.version }
  s.source_files  = "Source/**/*.swift"

  s.dependency "Kingfisher"
  s.dependency "Square1Tools"
end
