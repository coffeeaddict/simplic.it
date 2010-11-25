class Lipsum
  WORDS = %w(bibendum ultrices sodales dui lectus praesent senectus tincidunt
    orci viverra sapien gravida scelerisque fames diam turpis eget metus
    congue morbi sit tortor est sem sagittis iaculis duis faucibus aenean
    ut cras pulvinar massa nunc netus hendrerit mi donec vel lorem mattis
    ligula laoreet fermentum tempus vitae urna ridiculus justo nam pharetra
    tellus montes a rutrum purus vehicula eros primis in enim id facilisis
    libero blandit mollis sollicitudin quam lacinia penatibus odio suspendisse
    cursus felis dapibus condimentum cubilia ornare quisque feugiat risus
    magnis nibh venenatis convallis fringilla magna porttitor placerat
    accumsan nulla pretium semper adipiscing nisi vulputate neque rhoncus
    luctus aliquet etiam elementum mus dictum dignissim ultricies nisl
    phasellus arcu augue nec erat curae lobortis tempor elit proin sed eu
    pellentesque lacus tristique cum amet leo ac molestie maecenas interdum
    mauris fusce non egestas vestibulum consequat dis malesuada ipsum
    habitant integer auctor potenti et commodo volutpat nullam suscipit
    parturient ullamcorper quis euismod aliquam imperdiet posuere nascetur
    sociis facilisi curabitur at consectetur ante varius eleifend dolor velit
    natoque porta vivamus)

  METAL_WORDS = ['exercitationem', 'perferendis', 'excruciating', 'sphere',
    'murder', 'iure', 'metal', 'mass', 'black', 'blood', 'haunted', 'vulgar',
    'kill', 'unholy', 'satan', 'satanic', 'conjuring', 'demons', 'demonic',
    'maims', 'massacre', 'massacres', 'apocalyptic', 'scream', 'screaming',
    'slime', 'nordic', 'church', 'leading', 'feasting', 'goat', 'cow',
    'acts', 'anger', 'rage', 'terror', 'death', 'scent', 'burning', 'flame',
    'undead', 'necro', 'cum', 'flesh', 'chaos', 'decapitate', 'sanity', 'mad',
    'crazy', 'cryptic', 'insane', 'cadaver', 'fest', 'feast', 'witch', 'christian',
    'devil', 'evil', 'funeral', 'divine', 'horse', 'sword', 'axe', 'ax', 'battle', 
    'forge', 'monster', 'horror', 'cunt', 'arcane', 'all', 'whore', 'mother',
    'dragon', 'killing',
  ]

  # Returns a randomly generated sentence of lorem ipsum text.
  # The first word is capitalized, and the sentence ends in either a period or
  # question mark. Commas are added at random.
  def self.sentence
    # Determine the number of comma-separated sections and number of words in
    # each section for this sentence.
    sections = []
    1.upto(rand(5)+1) do
      sections << (WORDS.sort_by{rand}.slice(0...(rand(9)+3)).join(" "))
    end
    s = sections.join(";:,".slice(rand(3),1) + " ")
    return s.capitalize + ".?!".slice(rand(3),1)
  end
  
  # Returns a randomly generated paragraph of lorem ipsum text.
  # The paragraph consists of between 1 and 4 sentences, inclusive.
  def self.paragraph
    ((1..(rand(3)+2)).map{sentence}).join(" ")
  end
end
