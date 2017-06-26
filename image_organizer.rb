this_dir = File.expand_path(File.dirname(__FILE__))
image_dir = File.join(this_dir,'images')
puts "*** Finding images"
@image_exts = ['.jpg','.jpeg','.gif','.png','.tif']
require 'pathname'

def gather(path)
	path.children.collect do |child|
		if child.file? && @image_exts.include?(File.extname(child))
			child
		elsif child.directory?
			# go deeper
			gather(child)
		end
	end.flatten.compact
end


image_path = Pathname.new(image_dir)
images = gather(image_path)
images.each do |image|
	puts "Found image: #{File.basename(image)}"
end

