# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
  found = Array.new(a.length, false)

  a.each do |value|
    next if value <= 0
    next if value > a.length

    found[value-1] = true
  end

  found.each.with_index do |continue, index|
    return index+1 unless continue 
  end

  return a.length+1
end

