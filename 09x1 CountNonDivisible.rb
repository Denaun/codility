# You are given a non-empty zero-indexed array A consisting of N integers.
#
# For each number A[i] such that 0 ≤ i < N, we want to count the number of
# elements of the array that are not the divisors of A[i]. We say that these
# elements are non-divisors.
#
# For example, consider integer N = 5 and array A such that:
# ```
#     A[0] = 3
#     A[1] = 1
#     A[2] = 2
#     A[3] = 3
#     A[4] = 6
# ```
# For the following elements:
# * A[0] = 3, the non-divisors are: 2, 6,
# * A[1] = 1, the non-divisors are: 3, 2, 3, 6,
# * A[2] = 2, the non-divisors are: 3, 3, 6,
# * A[3] = 3, the non-divisors are: 2, 6,
# * A[6] = 6, there aren't any non-divisors.
#
# Write a function:
# ```
# def solution(a)
# ```
# that, given a non-empty zero-indexed array A consisting of N integers,
# returns a sequence of integers representing the amount of non-divisors.
#
# The sequence should be returned as:
# * a structure Results (in C), or
# * a vector of integers (in C++), or
# * a record Results (in Pascal), or
# * an array of integers (in any other programming language).
#
# For example, given:
# ```
#     A[0] = 3
#     A[1] = 1
#     A[2] = 2
#     A[3] = 3
#     A[4] = 6
# ```
# the function should return [2, 4, 3, 2, 0], as explained above.
#
# Assume that:
# * N is an integer within the range [1..50,000];
# * each element of array A is an integer within the range [1..2 * N].
#
# Complexity:
# * expected worst-case time complexity is O(N*log(N));
# * expected worst-case space complexity is O(N), beyond input storage (not
#   counting the storage required for input arguments).
#
# Elements of input arrays can be modified.

def solution(a)
  count = count_elements(a)
  factorisation = calculate_factorisation_array(2*a.length)

  return a.map do |i|
    non_divisors = a.length - count[1]
    factors = [1]

    # Calculates the factorisation grouping the various powers
    while factorisation[i] > 0
      current_factor = factorisation[i]
      power_divisors = []
      begin
        i /= current_factor
        power_divisors << (power_divisors.last || 1) * current_factor
      end while current_factor == factorisation[i]

      composite_divisors = Array.new(factors.length * power_divisors.length)
      index = 0
      power_divisors.each do |d|
        factors.each do |f|
          non_divisors -= count[d*f]

          composite_divisors[index] = d*f
          index += 1
        end
      end
      factors += composite_divisors
    end

    next non_divisors
  end
end

def count_elements(a)
  result = Array.new(2*a.length + 1, 0)

  a.each do |i|
    result[i] += 1
  end

  return result
end

def calculate_factorisation_array(n)
  result = Array.new(n+1, 0)
  (2..n).each do |i|
    next unless result[i] == 0

    result[i] = i
    (i*i..n).step(i) do |j|
      result[j] = i if result[j] == 0
    end
  end

  return result
end
