# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

def common_pods
    pod 'Pluralize.swift',                         git: 'https://github.com/wilbert/Pluralize.swift'
end

target 'Sworm' do
    common_pods
	pod 'Alamofire',                               '~> 3.0'
end

target 'SwormTests' do
    common_pods
    pod 'Mockingjay',                              '1.1.0'
end

