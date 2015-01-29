Pod::Spec.new do |s|
  s.name = 'YSAccountsAdditions'
  s.version = '0.2.0'
  s.summary = 'Accounts.framework categories.'
  s.homepage = 'https://github.com/yusuga/YSAccountsAdditions'
  s.license = 'MIT'
  s.author = 'Yu Sugawara'
  s.source = { :git => 'https://github.com/yusuga/YSAccountsAdditions.git', :tag => s.version.to_s }
  s.platform = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source_files = 'Classes/YSAccountsAdditions/*.{h,m}'
  s.requires_arc = true    
  s.compiler_flags = '-fmodules'
end