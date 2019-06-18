

Pod::Spec.new do |s|

s.name         = "ZJJCommon"    #存储库名称
s.version      = "0.0.1"      #版本号，与tag值一致
s.summary      = "公共组件"  #简介

s.author             = { "zhengjunjie" => "2028002516@qq.com" }  #作者

s.requires_arc = true #是否支持ARC

s.description  = <<-DESC
ZJJCommon for Green
DESC

s.source       = { :local => './', :tag => '0.0.1' }
s.homepage     = "https://github.com/zhengjunjie11/Green/tree/master/locallib/ZJJCommon"
s.author             = { "天空吸引我" => "2028002516@qq.com" }

s.dependency 'SDWebImage'
s.ios.deployment_target = '9.0'

s.subspec 'JJKit' do |ss|
ss.source_files = 'JJKit/*.{h,m}'
end

s.subspec 'Macro' do |ss|
  ss.source_files = 'Macro/*.{h,m,pch}'
end

end
