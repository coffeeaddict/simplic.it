#!script/runner

models = %w(blogs bounces comments favorites portfolios users)
modelles = %w(blogs_tags portfolios_skills)

models.each do |model|
  klass = model.singularize.camelize

  glob = File.join(Rails.root, "data", model, "*.xml")
  Dir.glob(glob).each do |file|
    xml = File.read(file)
    object = eval "#{klass}.new"
    hash = Hash.from_xml(xml).values.first

    if model == "blogs"
      tags = hash.delete('tags')
      object.tags = tags.collect { |tag| 
        tag.delete_if { |k,v| k =~ /_id$/ }
        Tag.create(tag)
      } unless tags.nil? or tags.empty?
    
   elsif model == "portfolios"
      skills = hash.delete('skills')
      object.skills skils.collect { |skill|
        skill.delete_if { |k,v| k =~ /_id$/ }
        Skill.create(skill)
      } unless skills.nil? or skills.empty?

    end

    puts hash.inspect
    object.update_attributes( hash )
      
  end
end

