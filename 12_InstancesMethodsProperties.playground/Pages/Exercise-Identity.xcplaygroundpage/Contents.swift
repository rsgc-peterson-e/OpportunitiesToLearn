/*:
 ## Exercise: Identity
 
 What does it really mean for an instance value to have its own identity?

 - callout(Exercise):
 Create a variable for `myPlans`, initialized to a string describing your evening plans.\
Create a second variable for `friendPlans`, but initialize it to `myPlans`. (Your friend takes less initiative than you at planning.)\
Below the declaration of `friendPlans`, update `myPlans` by using the addition operator `+` to add one more activity.\
Check the values of `myPlans` and `friendPlans`. Are they the same or different?
 */
// Create your variables here:
var myPlans = "Dinner"


// Update `myPlans` here:
myPlans += " and Skating"
var friendPlans = myPlans
// the values are the same




/*:
 - callout(Exercise):
 Create a function `addDance` that takes a string, appends a phrase about dancing (like `"and then we dance!"` or `"but no dancing"`, according to your taste), and returns the new string.\
Call the `addDance` function on `myPlans`, and assign the result to `friendPlans`.
 */
// Define and call your function here:
func addDance(input : String) -> String {
    return input + " but no dancing"
}
/*:
 - callout(Exercise):
 How do you expect `friendPlans` to change? How do you expect `myPlans` to change?\
 Print both instances to to find out.
 */
// Check your guess by printing here:
// The variable itself should not change but the string printed after a call to the function will have " but no dancing appended to it"
addDance(input: friendPlans)
addDance(input: myPlans)
myPlans
friendPlans



/*:
 _Copyright (C) 2016 Apple Inc. All Rights Reserved.\
 See LICENSE.txt for this sample’s licensing information_
 
[Previous](@previous)  |  page 17 of 17
 */
