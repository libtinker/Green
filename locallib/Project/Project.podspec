

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
s.homepage     = "https://github.com/zhengjunjie11/Green/tree/master/locallib/Project"
s.author             = { "天空吸引我" => "2028002516@qq.com" }

s.ios.deployment_target = '9.0'

s.subspec 'Home' do |ss|
  ss.resources = 'Home/Resouce/*.{png,bundle,mp4}'
  ss.subspec 'ViewController' do |sss|
    sss.source_files = 'Home/ViewController/*.{h,m}'
  end
  ss.subspec 'View' do |sss|
    sss.source_files = 'Home/View/*.{h,m}'
  end

end

s.subspec 'Mine' do |ss|
  ss.subspec 'ViewController' do |sss|
    sss.source_files = 'Mine/ViewController/*.{h,m}'
  end

  ss.subspec 'View' do |sss|
    sss.source_files = 'Mine/View/*.{h,m}'
  end

  ss.subspec 'Model' do |sss|
    sss.source_files = 'Mine/Model/*.{h,m}'
  end



  ss.subspec 'MineService' do |sss|
    sss.source_files = 'Mine/MineService/*.{h,m}'
  end

end

s.subspec 'Base' do |ss|
  ss.source_files = 'Base/*.{h,m}'
  ss.resources = 'Base/Resouce/*.{png,bundle,mp4}'
  ss.subspec 'BaseView' do |sss|
    sss.source_files = 'Base/BaseView/*.{h,m}'
  end
end

s.subspec 'LocalService' do |ss|
  ss.source_files = 'LocalService/*.{h,m}'
end

end
