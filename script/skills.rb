#!script/runner

models = %w(portfolios)

models.each do |model|
  glob = File.join(Rails.root, "data", model, "*.xml")
  Dir.glob(glob).each do |file|
    xml = File.read(file)
    hash = Hash.from_xml(xml).values.first

    object = Portfolio.find_by_name hash["name"]

    skills = hash.delete('skills')
    unless skills.nil? or skills.empty?
      object.skills = skills.collect { |skill|
        skill.delete_if { |k,v| k =~ /_id$/ }
        Skill.exists?( :name => skill["name"] ) ? Skill.find_by_name(skill["name"]) : Skill.create(skill)
      }
    else
      puts "Not doing skills, it's empty"
    end
  end
end

