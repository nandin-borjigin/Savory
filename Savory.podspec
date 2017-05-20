Pod::Spec.new do |s|
  s.name         = "Savory"
  s.version      = "0.0.4"
  s.summary      = "Savory is a swift accordion view library."
  s.description  = <<-DESC
  Savory is a swift accordion view library developed on top of UITableView
                   DESC
  s.homepage     = "https://github.com/Nandiin/Savory"
  s.license      = "MIT"
  s.author             = { "Nandiin" => "nandiin@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Nandiin/Savory.git", :tag => s.version.to_s }
  s.source_files  = "Savory", "Savory/*.{h,swift}"
end
