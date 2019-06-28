
Pod::Spec.new do |s|

  s.name         = "ZJJPhoto"
  s.version      = "0.0.1"
  s.summary      = "相册相关的api."

  s.description  = <<-DESC
    ZJJPhoto for Green
  DESC

  s.source       = { :local => './', :tag => '0.0.1' }
  s.homepage     ="https://github.com/zhengjunjie11/Green/tree/master/locallib/ZJJPhoto"
  s.author             = { "天空吸引我" => "2028002516@qq.com" }

  s.ios.deployment_target = '9.0'

  s.source_files  = '*.{h,m,mm,cpp,c}'
  s.public_header_files = '*.h'

end
