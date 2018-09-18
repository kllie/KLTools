

Pod::Spec.new do |s|

  s.name         = "KLTools"

  s.version      = "0.1.3"

  s.summary      = "This is a tools."

  s.homepage     = "https://github.com/kllie"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "zhaobinhua" => "zbh1019@163.com" }

  s.platform     = :ios, "8.0"

  s.requires_arc = true

  s.source       = { :git => "https://github.com/kllie/KLTools.git", :tag => s.version }


  s.source_files        = "KLTools/Classes/KLTools.h"

  s.public_header_files = "KLTools/Classes/KLTools.h"

  s.subspec 'Category' do |category|
    category.public_header_files   = 'KLTools/Classes/Category/**/*.h'
    category.source_files          = 'KLTools/Classes/Category/**/*'
  end

end
