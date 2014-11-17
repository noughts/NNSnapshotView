Pod::Spec.new do |s|
  s.name         = "NNSnapshotView"
  s.version      = "0.1.0"
  s.summary      = "NNSnapshotView"
  s.homepage     = "https://github.com/noughts/NNSnapshotView"
  s.author       = { "noughts" => "noughts@gmail.com" }
  s.source       = { :git => "https://github.com/noughts/NNSnapshotView.git" }
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.platform = :ios
  s.requires_arc = true
  s.source_files = 'NNSnapshotView/**/*.{h,m}'
end
