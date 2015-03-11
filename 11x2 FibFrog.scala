/*
 * The Fibonacci sequence is defined using the following recursive formula:
 * ```
 *     F(0) = 0
 *     F(1) = 1
 *     F(M) = F(M - 1) + F(M - 2) if M >= 2
 * ```
 *
 * A small frog wants to get to the other side of a river. The frog is
 * initially located at one bank of the river (position −1) and wants to get to
 * the other bank (position N). The frog can jump over any distance F(K), where
 * F(K) is the K-th Fibonacci number. Luckily, there are many leaves on the
 * river, and the frog can jump between the leaves, but only in the direction
 * of the bank at position N.
 * 
 * The leaves on the river are represented in a zero-indexed array A consisting
 * of N integers. Consecutive elements of array A represent consecutive
 * positions from 0 to N − 1 on the river. Array A contains only 0s and/or 1s:
 * * 0 represents a position without a leaf;
 * * 1 represents a position containing a leaf.
 *
 * The goal is to count the minimum number of jumps in which the frog can get
 * to the other side of the river (from position −1 to position N). The frog
 * can jump between positions −1 and N (the banks of the river) and every
 * position containing a leaf.
 * 
 * For example, consider array A such that:
 * 
 *     A[0] = 0
 *     A[1] = 0
 *     A[2] = 0
 *     A[3] = 1
 *     A[4] = 1
 *     A[5] = 0
 *     A[6] = 1
 *     A[7] = 0
 *     A[8] = 0
 *     A[9] = 0
 *     A[10] = 0
 * The frog can make three jumps of length F(5) = 5, F(3) = 2 and F(5) = 5.
 * 
 * Write a function:
 * ```
 * object Solution { def solution(A: Array[Int]): Int }
 * ```
 * that, given a zero-indexed array A consisting of N integers, returns the
 * minimum number of jumps by which the frog can get to the other side of the
 * river. If the frog cannot reach the other side of the river, the function
 * should return −1.
 * 
 * For example, given:
 * ```
 *     A[0] = 0
 *     A[1] = 0
 *     A[2] = 0
 *     A[3] = 1
 *     A[4] = 1
 *     A[5] = 0
 *     A[6] = 1
 *     A[7] = 0
 *     A[8] = 0
 *     A[9] = 0
 *     A[10] = 0
 * ```
 * the function should return 3, as explained above.
 * 
 * Assume that:
 * * N is an integer within the range [0..100,000];
 * * each element of array A is an integer that can have one of the following
 *   values: 0, 1.
 *
 * Complexity:
 * * expected worst-case time complexity is O(N*log(N));
 * * expected worst-case space complexity is O(N), beyond input storage (not
 *   counting the storage required for input arguments).
 *
 * Elements of input arrays can be modified.
 */

import scala.collection.JavaConversions._

object Solution {
  var fibonacci: Array[Int] = _

  def solution(A: Array[Int]): Int = {
    fibonacci = calculateFibonacci(A.length+1)

    var minimumJumps = new Array[Int](A.length)
    var currentPositions: List[Int] = Nil
    var nextPositions = List(-1)
    var jumpCounter = 0
    while (!nextPositions.isEmpty) {
      jumpCounter += 1
      currentPositions = nextPositions
      nextPositions = List[Int]()

      for (position <- currentPositions) {
        for (jump <- fibonacci; if (position+jump <= A.length)) {
          if (position+jump == A.length) {
            return jumpCounter
          }

          if (A(position+jump) == 1 && minimumJumps(position+jump) == 0) {
            minimumJumps(position+jump) = jumpCounter
            nextPositions ::= position+jump
          }
        }
      }
    }

    -1
  }

  def calculateFibonacci(max: Int): Array[Int] = max match {
    case 0 | 1 =>
      Array(1)
    case 3 =>  // Wrong formula approximation
      Array(1, 2, 3)
    case _ =>
      val L = Math.floor((Math.log(max+1/2)+Math.log(5)/2) / Math.log((1+Math.sqrt(5))/2)).toInt
      val result = new Array[Int](L)

      result(0) = 1
      result(1) = 1
      for (i <- 2 to L-1) {
        result(i) = result(i-1) + result(i-2)
      }

      result.tail  // Ignores the initial and duplicate 1
  }
}