class ToolsController < ApplicationController

  @@words      = []
  CONJUNCTIONS = %w(and or but you me we him + the -)
  FUZZ         = %w(! @ # $ % ^ & * - + ~ ` , . &lt; > / ?);

  def index
  end

  def pwgen
    @phrases = []

    10.times do 
      @phrases << get_passphrase
    end
  end

  def get_passphrase
    words = get_words()
    
    word1 = words[rand(words.length)]
    word2 = words[rand(words.length)]
    con   = CONJUNCTIONS[rand(CONJUNCTIONS.length)]

    return [ 
      [ strong_word(word1), con, strong_word(word2) ].join(" "),
      [ word1, con, word2 ].join(" "),
    ]
  end

  def get_words
    if @@words == []
      @@words = IO.readlines("/usr/share/dict/words").collect { |i|
        i.downcase.gsub("\n", "")
      }.select { |i|
        i.length <= 7
      }
    end

    return @@words;
  end

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

  private :get_words, :get_passphrase, :strong_word
end
