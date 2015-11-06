Pod::Spec.new do |s|
  s.name         = "Sworm"
  s.version      = "0.0.1"
  s.summary      = "Sworm is a Swift ORM library for RESTfull APIs."
  s.description  = "Sworm is a client library for RESTfull Apis created to be simple and smart."
  s.homepage     = "https://github.com/wilbert/sworm"
  s.license      = "MIT"
  s.author       = { "Wilbert Ribeiro" => "wkelyson@gmail.com" }
  s.source       = { :git => "https://github.com/wilbert/sworm.git", :tag => "0.0.1" }
  s.source_files = "Sworm/*"
  s.platform     = :ios, '9.0'
  s.dependency "Alamofire", "~> 3.0"
end
