import java.io.File

fun getNumberFromInput(line: String): Int {
  return line.substring(2).toInt()
}

fun axisAlignedMoveTowards(head: Int, tail: Int): Int {
  if(head < tail) {
    return tail - 1
  }
  if(head > tail){
    return tail + 1
  }
  return tail
}

fun moveTowards(head: Pair<Int, Int>, tail: Pair<Int, Int>): Pair<Int, Int> {
  // everything ok

  if( Math.abs(head.first - tail.first) <= 1 && 
      Math.abs(head.second - tail.second) <= 1) 
  {
    return tail
  }

  // update one axis 
  if(head.first == tail.first) {
    return Pair(tail.first, axisAlignedMoveTowards(head.second, tail.second))
  }
  if(head.second == tail.second) {
    return Pair(axisAlignedMoveTowards(head.first, tail.first), tail.second)
  }

  //update both axis
  return Pair(axisAlignedMoveTowards(head.first, tail.first), axisAlignedMoveTowards(head.second, tail.second))
}


fun main () {
  val listOfLines = mutableListOf<String>()

  File ("data.in").reader().useLines{ lines ->lines.forEach {
    listOfLines.add (it) }
  }

  val visitedPointsPart1 = mutableSetOf<Pair<Int, Int>>(Pair(0, 0))
  val visitedPointsPart2 = mutableSetOf<Pair<Int, Int>>(Pair(0, 0))

  var knots = arrayOf(
    Pair(0, 0), Pair(0, 0), Pair(0, 0), Pair(0, 0), Pair(0, 0),
    Pair(0, 0), Pair(0, 0), Pair(0, 0), Pair(0, 0), Pair(0, 0)
  )

  listOfLines.forEach{
    val num = getNumberFromInput(it)
    val dir = it[0]

    for(i in 1..num) {
      if(dir == 'U') {
        knots[0] = Pair(knots[0].first + 1, knots[0].second)
      }
      else if(dir == 'D') {
        knots[0] = Pair(knots[0].first - 1, knots[0].second)
      }
      else if(dir == 'L') {
        knots[0] = Pair(knots[0].first, knots[0].second - 1)
      }
      else if(dir == 'R') {
        knots[0] = Pair(knots[0].first, knots[0].second + 1)
      }

      for(j in 1..9) {
        knots[j] = moveTowards(knots[j - 1], knots[j])
      }
      
      visitedPointsPart1.add(knots[1])
      visitedPointsPart2.add(knots[9])
    }
    
  }

  println(visitedPointsPart1.count())
  println(visitedPointsPart2.count())
}