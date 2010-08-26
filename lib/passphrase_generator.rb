class PassphraseGenerator
  WORDS_LIST   = "/usr/share/dict/words"
  @@words      = nil
  CONJUNCTIONS = %w(and or but you me we him + the -)
  FUZZ         = %w(! @ # $ % ^ & * - + ~ ` , . < > / ?);

  # make a phrase of two words and a conjuction
  #
  # fuzz the words and return the fuzzed phrase and the original phrase
  #
  def get_passphrase
    word1 = words[rand(words.length)]
    word2 = words[rand(words.length)]
    con = CONJUNCTIONS[rand(CONJUNCTIONS.length)]

    return [ 
      [ strong_word(word1), con, strong_word(word2) ].join(" "),
      [ word1, con, word2 ].join(" "),
    ]
  end
 
  # attr_reader
  def words
    @@words ||= get_words
  end

  # load words no longer then 7 chars from the dictionary
  def get_words
    IO.readlines(WORDS_LIST).select { |i|
      i.length <= 8
    }.collect { |i|
      i.downcase.gsub("\n", "")
    }
  end

  # fuzz a word
  def strong_word(word)
    letters = word.split(//)

    fuzz_pos = rand(letters.length)

    begin
      letters[fuzz_pos] << FUZZ[rand(FUZZ.length)]

      if letters[fuzz_pos + 1]
        letters[fuzz_pos+1].upcase!
      else
        letters[fuzz_pos][0].upcase!
      end
    rescue
      # fix issues with array length and fixnums by ignoring them
    end
    

    return letters.flatten.join("");
  end

  private :strong_word, :get_words
end
