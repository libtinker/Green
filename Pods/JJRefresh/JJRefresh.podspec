
Pod::Spec.new do |s|

  s.name         = "JJRefresh"
  s.version      = "0.0.1"
  s.summary      = "下拉刷新，分装MJRefresh."

  s.description  = <<-DESC
    JJRefresh for Green
  DESC

  s.source       = { :local => './', :tag => '0.0.1' }
  s.homepage     ="https://github.com/zhengjunjie11/Green/tree/master/locallib/JJRefresh"
  s.author             = { "天空吸引我" => "2028002516@qq.com" }

  s.dependency 'MJRefresh'
  s.ios.deployment_target = '9.0'

  s.source_files  = '*.{h,m,mm,cpp,c}', '*/*.{h,m,mm,cpp,c}', '*/*/*.{h,m,mm,cpp,c}'
  s.public_header_files = '*.h', '*/*.h', '*/*/*.h'
  s.resources = 'Resouce/*.{png,bundle,mp4}'

end
