/*:
 ![Make School Banner](./swift_banner.png)
 # A wild bear appears!

 Zoe says your program is really helping her keep track of the tigers! As a result, Zoe has been promoted at the zoo. She's now in charge of tigers and bears, which means your program now needs to describe bear behaviors as well!

 - callout(Challenge): Create a class called `Bear`, which should be very similar to your `Tiger` class. The `Bear` class should also have `name` and `favoriteFood` instance variables, because `Bear`s have a `name` and a `favoriteFood`, just like `Tiger`s. The initializer method should take one argument, `name`, and set the `name` instance variable to its given value, and `favoriteFood` to `"fish"`.  The `eat` method for the `Bear` class should also be exactly the same as in the `Tiger` class. Remember, if `eat` is called with anything other than their `favoriteFood` then it will sleep!  _`Bear`s sleep very differently than `Tiger`s, so the `sleep` method for the `Bear` class should instead print `"<name> hibernates for 4 months"` instead to reflect the difference in their sleeping behavior._

 Finally, create `Tiger` and `Bear` objects, and then call their `eat` method to test its behavior.

 */

class Tiger {
    // put your instance variables here!
    var favoriteFood : String = "meat"
    var name : String = ""
    
    
    init(name: String) {
        // put your initializer content here
        self.name = name
    }
    
    func sleep() {
        // complete your sleep function here, noting the change from global to instance variables
        print("\(name) sleeps for 8 hours")
    }
    
    func eat(food: String) {
        // complete your eat function here!
        print("\(name) eats \(food)")
        if (favoriteFood == food) {
            print("YUM!!! \(name) wants more \(food)")
        } else {
            sleep()
        }
    }
}

class Bear {
    // complete the Bear class here!
    var favoriteFood : String = "fish"
    var name : String = ""
    
    
    init(name: String) {
        // put your initializer content here
        self.name = name
    }
    
    func sleep() {
        // complete your sleep function here, noting the change from global to instance variables
        print("\(name) hibernates for 4 months")
    }
    
    func eat(food: String) {
        // complete your eat function here!
        print("\(name) eats \(food)")
        if (favoriteFood == food) {
            print("YUM!!! \(name) wants more \(food)")
        } else {
            sleep()
        }
    }

}



/*:
 ## Testing

 When you're done, uncomment the below lines of code, and it should output the following:

    Tigger eats meat
    YUM!!! Tigger wants more meat
    Tigger eats kibble
    Tigger sleeps for 8 hours
    Pooh eats fish
    YUM!!! Pooh wants more fish
    Pooh eats meat
    Pooh hibernates for 4 months

 - callout(Hint): Refer to the previous page if you need any help!

 */

let tigger = Tiger(name: "Tigger")
tigger.eat(food: "meat")
tigger.eat(food: "kibble")
let pooh = Bear(name: "Pooh")
pooh.eat(food: "fish")
pooh.eat(food: "meat")






//: [Previous](@previous) | [Next](@next)
