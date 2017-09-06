# Reference
# 1. https://en.wikipedia.org/wiki/Pig_Latin (rules)
# 2. https://stackoverflow.com/questions/27150091/pig-latin-converter

class PigLatinizer

  def piglatinize(word)
    vowels = %w(a e i o u A E I O U)
    consonants = []

    if vowels.include?(word[0])
      word << 'way'
    else
      while !vowels.include?(word[0])
        consonants << word[0]
        word = word.split('')[1..-1].join
      end
      word + consonants.join + 'ay'
    end
  end

  def to_pig_latin(string)
    string.split.collect{|word| piglatinize(word)}.join(" ")
  end

end
