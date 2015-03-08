# you can use puts for debugging purposes, e.g.
# puts "this is a debug message"

class Counter
  def initialize(n)
    @counter = Array.new(n, 0)
    @max = 0
    @is_max_saved = false
  end

  def increase(x)
    restore_max
    
    @counter[x-1] += 1
    @max = [@counter[x-1], @max].max
  end

  def max_counter
    save_max
  end

  def to_a
    restore_max

    @counter
  end

  private

  def save_max
    @is_max_saved = true
  end

  def restore_max
    if @is_max_saved
      @counter = Array.new(@counter.length, @max)
      @is_max_saved = false
    end
  end
end

def solution(n, a)
  counter = Counter.new(n)

  a.each do |i|
    if i > 0 && i <= n
      counter.increase(i)
    elsif i == n+1
      counter.max_counter
    end
  end

  return counter.to_a
end
