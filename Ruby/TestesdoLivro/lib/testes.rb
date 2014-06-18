def each_vowel(&code_block)
 %w{a e i o u}.each { |vowel| code_block.call(vowel) }
end
each_vowel { |vowel| puts vowel }

def each_vowel
 %w{a e i o u}.each { |vowel| yield vowel }
end
each_vowel { |vowel| puts vowel }

class Fixnum
  def seconds
self end
  def minutes
    self * 60
end
def hours
    self * 60 * 60
  end
  def days
    self * 60 * 60 * 24
end end
puts Time.now
puts Time.now + 10.minutes
puts Time.now + 16.hours
puts Time.now - 7.days
