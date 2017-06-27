require 'mini_exiftool'
this_dir = File.expand_path(File.dirname(__FILE__))
image_dir = File.join(this_dir,'images')
puts "*** Finding images"

images = Dir.glob('**/*.{jpg,jpeg,png,gif,tif}')
images.each do |image|
	puts "Found image: #{File.basename(image)}"
end

# inspect images for metadata
# puts "***inspect images"
#puts images.first
# image_data = MiniExiftool.new(images.first)
#puts image_data.inspect
# puts image_data.caption_abstract

images.map! do |image|
	filename = File.basename(image)

	image_data = MiniExiftool.new(image)
	title = image_data.caption_abstract # IPTC
	title ||= image_data.caption         # XMP 
	title ||= image_data.description	# PNG
	title ||= filename.split(',').first

	puts "Filename: #{filename}; Title: #{title}"
	{:path => image, :filename => filename, :title => title}
end

puts images.inspect