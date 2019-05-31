

Pod::Spec.new do |s|

s.name         = "Project"    #存储库名称
s.version      = "0.0.2"      #版本号，与tag值一致
s.summary      = "项目"  #简介

s.author             = { "zhengjunjie" => "2028002516@qq.com" }  #作者

s.requires_arc = true #是否支持ARC

s.description  = <<-DESC
Project for Green
DESC

s.source       = { :local => './', :tag => '0.0.2' }
s.homepage     = "https://github.com/zhengjunjie11/ZJJNetWork"
s.author             = { "天空吸引我" => "2028002516@qq.com" }

s.ios.deployment_target = '9.0'

s.subspec 'Home' do |ss|
ss.source_files = 'Home/ViewController/*.{h,m}'
end

s.subspec 'Mine' do |ss|
ss.source_files = 'Mine/ViewController/*.{h,m}'
end

s.subspec 'Base' do |ss|
ss.source_files = 'Base/*.{h,m}'
end

end
