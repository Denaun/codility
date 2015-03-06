# A non-empty zero-indexed array A consisting of N integers is given.
#
# A peak is an array element which is larger than its neighbours. More
# precisely, it is an index P such that 0 < P < N - 1 and A[P - 1] < A[P] > A[P
# + 1].
#
# For example, the following array A:
# ```
#     A[0] = 1
#     A[1] = 5
#     A[2] = 3
#     A[3] = 4
#     A[4] = 3
#     A[5] = 4
#     A[6] = 1
#     A[7] = 2
#     A[8] = 3
#     A[9] = 4
#     A[10] = 6
#     A[11] = 2
# ```
# has exactly four peaks: elements 1, 3, 5 and 10.
#
# You are going on a trip to a range of mountains whose relative heights are
# represented by array A, as shown in a figure below. You have to choose how
# many flags you should take with you. The goal is to set the maximum number of
# flags on the peaks, according to certain rules.
#
# Flags can only be set on peaks. What's more, if you take K flags, then the
# distance between any two flags should be greater than or equal to K. The
# distance between indices P and Q is the absolute value |P - Q|.
#
# For example, given the mountain range represented by array A, above, with N =
# 12, if you take:
# * two flags, you can set them on peaks 1 and 5;
# * three flags, you can set them on peaks 1, 5 and 10;
# * four flags, you can set only three flags, on peaks 1, 5 and 10.
#
# You can therefore set a maximum of three flags in this case.
#
# Write a function:
# ```
# def solution(a)
# ```
# that, given a non-empty zero-indexed array A of N integers, returns the
# maximum number of flags that can be set on the peaks of the array.

# For example, the following array A:
# ```
#     A[0] = 1
#     A[1] = 5
#     A[2] = 3
#     A[3] = 4
#     A[4] = 3
#     A[5] = 4
#     A[6] = 1
#     A[7] = 2
#     A[8] = 3
#     A[9] = 4
#     A[10] = 6
#     A[11] = 2
# ```
# the function should return 3, as explained above.
#
# Assume that:
# * N is an integer within the range [1..200,000];
# * each element of array A is an integer within the range [0..1,000,000,000].
#
# Complexity:
# * expected worst-case time complexity is O(N);
# * expected worst-case space complexity is O(N), beyond input storage (not
#   counting the storage required for input arguments).
#
# Elements of input arrays can be modified.

def solution(a)
  peaks = find_peaks(a)
  return 0 if peaks.empty?

  min_flags = 1
  max_flags = Math.sqrt(a.length).ceil + 1
  while min_flags != max_flags
    mid_flags = min_flags + ((max_flags-min_flags)/2.0).ceil
    if check(peaks, mid_flags)
      min_flags = mid_flags
    else
      max_flags = mid_flags-1
    end
  end

  return max_flags
end

def find_peaks(a)
  return (1...a.length-1).select{ |i| a[i-1] < a[i] && a[i] > a[i+1] }
end

def check(peaks, flags)
  min_distance = flags
  position = peaks[0]  # Always pick the first peak
  next_peak = 1
  flags -= 1
  while next_peak < peaks.length && flags > 0
    next_peak += 1 while (next_peak < peaks.length \
                          && peaks[next_peak] < position + min_distance)

    return false unless next_peak < peaks.length

    position = peaks[next_peak]
    flags -= 1
    next_peak += 1
  end

  return flags <= 0
end
