Pod::Spec.new do |s|
  s.name         = "MerlinTranscriptApi"
  s.version      = "0.1.0"
  s.summary      = "Swift wrapper for the metadata shorterner needed to generate metadata hash or proof for extrinsic"
  s.homepage     = "https://github.com/novasamatech/merlin-ios"
  s.license      = 'MIT'
  s.author       = {'Ruslan Rezin' => 'ruslan@novasama.io'}
  s.source       = { :git => 'https://github.com/novasamatech/merlin-ios',  :tag => "#{s.version}"}

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.vendored_frameworks = 'bindings/xcframework/merlin_transcript.xcframework'
  s.source_files = 'Sources/**/*.swift'

end
