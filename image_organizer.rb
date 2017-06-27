require 'mini_exiftool'
require 'fileutils'
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

#puts images.inspect



#create new directory
puts "*** Organizing images"

sorted_dir = File.join(this_dir, 'images_sorted')
FileUtils.mkdir_p(sorted_dir)


# loop through images

images.each do |image_hash|
	first_char = image_hash[:title] ?
	image_hash[:title][0] : "0"
	caption_dir = File.join(sorted_dir, first_char.upcase,image_hash[:title])
	FileUtils.mkdir_p(caption_dir)

	# copy image to caption named dir

	old_path = File.join(this_dir,image_hash[:path])
	new_path = File.join(caption_dir,image_hash[:filename])
	if File.exists?(new_path)
		puts "Skipping, already exists: #{new_path}"
	else
		puts "Copying image: #{new_path}"
		FileUtils.cp(old_path,new_path)
	end
end



