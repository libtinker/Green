
Pod::Spec.new do |s|

s.name         = "ZJJNetwork"
s.version      = "0.0.1"
s.summary      = "小型网络库，封装AFNetworking."
s.description  = <<-DESC
DESC
s.description  = <<-DESC
ZJJNetwork for Live
DESC
s.source       = { :local => './', :tag => '0.0.1' }
s.homepage     = "https://github.com/zhengjunjie11/ZJJNetWork"
s.author             = { "天空吸引我" => "2028002516@qq.com" }
s.dependency 'AFNetworking'
s.ios.deployment_target = '8.0'

#文件夹
s.subspec 'Core' do |ss|
ss.source_files  = 'ZJJNetwork/Core/*.{h,m}'
end
end
