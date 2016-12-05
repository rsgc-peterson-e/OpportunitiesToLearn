/*:
 # Mario
 
 Add your Mario solution (however far you got) to the space below.
 
 Then, commit your work.
 
 Finally, push your work to the remote origin for your repository on GitHub.com.
 
 We will go through this together.
 */

// Add your code below
func levelCost(heights : [Int], maxJump : Int) -> Int {
    var points = 0
    for i in stride(from: 0, through: heights.count, by: 1) {
        if (i < heights.count - 1) {
            if (heights[i] == heights[i + 1]) {
                points += 1
            } else if (heights[i] < heights[i + 1] && abs(heights[i + 1] - heights[i]) <= maxJump) {
                let addedPoints = 2 * (abs(heights[i + 1] - heights[i]))
                points += addedPoints
            } else if (heights[i] > heights[i + 1] && abs(heights[i] - heights[i + 1]) <= maxJump) {
                let addedPoints = 2 * (abs(heights[i] - heights[i + 1]))
                points += addedPoints
            } else {
                return -1
            }
        }
    }
    return points
}
