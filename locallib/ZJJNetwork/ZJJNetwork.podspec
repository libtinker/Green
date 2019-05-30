
Pod::Spec.new do |s|

  s.name         = "ZJJNetwork"
  s.version      = "0.0.1"
  s.summary      = "小型网络库，封装AFNetworking."

  s.description  = <<-DESC
    ZJJNetwork for Live
  DESC

  s.source       = { :local => './', :tag => '0.0.1' }
  s.homepage     = "https://github.com/zhengjunjie11/ZJJNetWork"
  s.author             = { "天空吸引我" => "2028002516@qq.com" }

  s.dependency 'AFNetworking'
  s.ios.deployment_target = '8.0'

  s.source_files  = 'Core/*.{h,m,mm,cpp,c}', 'Core/*/*.{h,m,mm,cpp,c}', 'Core/*/*/*.{h,m,mm,cpp,c}'
  s.public_header_files = 'Core/*.h', 'Core/*/*.h', 'Core/*/*/*.h'

end
