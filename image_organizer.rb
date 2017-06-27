require 'mini_exiftool'
this_dir = File.expand_path(File.dirname(__FILE__))
image_dir = File.join(this_dir,'images')
puts "*** Finding images"

images = Dir.glob('**/*.{jpg,jpeg,png,gif,tif}')
images.each do |image|
	puts "Found image: #{File.basename(image)}"
end

# inspect images for metadata
puts "***inspect images"
puts images.first