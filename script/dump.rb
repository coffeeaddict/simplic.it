#!script/runner

models = %w(blogs bounces comments favorites portfolios skills tags users)
modelles = %w(blogs_tags portfolios_skills)

models.each do |model|
  klass = model.singularize.camelize

  all = eval "#{klass}.all"

  puts "#{klass} : #{all.count}"

  all.each do |object|
    xml = case model
          when "blogs"
            object.to_xml :include => :tags 
          when "portfolios"
            object.to_xml :include => :skills
          else
            object.to_xml
          end

    file_name = File.join(Rails.root, "data", model, "#{object.id}.xml")
    File.open(file_name, File::CREAT|File::TRUNC|File::WRONLY) { |f| f.puts xml } 
  end
end
