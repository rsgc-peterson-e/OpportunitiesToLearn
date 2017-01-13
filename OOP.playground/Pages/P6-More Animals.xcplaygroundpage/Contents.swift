/*:
 ![Make School Banner](./swift_banner.png)
 # Even more animals!

 Today is the day! Zoe now keeps track of giraffes, bees, AND unicorns, so she needs 3 more classes of animals added to the program. Luckily, we're prepared because we have a general Animal class with typical animal behaviors.

 - note: Copy your full `Animal`, `Tiger`, and `Bear` classes from the previous page

 */

class Animal {
    // Put your instance variables here
    var favoriteFood : String = ""
    var name : String = ""
    init(name: String, favoriteFood: String) {
        // put your initializer content here
        self.name = name
        self.favoriteFood = favoriteFood
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

class Tiger : Animal {
    // put your instance variables here!
    
    
    init(name: String) {
        super.init(name: name, favoriteFood: "meat")
    }
    
}

class Bear : Animal {
    // complete the Bear class here!
    
    init(name: String) {
        // put your initializer content here
        super.init(name: name, favoriteFood: "fish")
    }
    
    override func sleep() {
        print("\(super.name) hibernates for 4 months")
    }
}

/*:

 # Unicorns

 We're going to create 3 more subclasses of `Animal`: `Bee`, `Giraffe`, and `Unicorn`. Each class should set their own value for `favoriteFood`, and should override the `sleep` or `eat` methods, or both as appropiate.

 - callout(Challenge): Implement the `Unicorn` class as a subclass of `Animal`. In case you didn't know, unicorns love to eat marshmallows and they sleep in clouds. In other words, their `favoriteFood` is `"marshmallows"` and calling the `sleep` method on a `Unicorn` should print `"<name> sleeps in a cloud"`. We've given you some hints in the provided code below.
 */

// Implement the Unicorn class here as a subclass of Animal
// Hint: Implement the initializer method and override the sleep method
class Unicorn: Animal {
    
    init(name: String) {
        // don't forget to correct the call to the superclass initializer!
        super.init(name: name, favoriteFood: "marshmallows")
    }

    override func sleep() {
        // your overridden sleep code...
        print("\(super.name) sleeps in a cloud")
    }
}

/*:

 # Giraffes

 - callout(Challenge): Implement the `Giraffe` class as a subclass of `Animal`. Giraffes are vegetarian, so they only eat leaves. If you feed `"leaves"` to a `Giraffe`, they will happily tell you `"YUM!!! <name> wants more leaves"` after eating them (just like how `Tiger`s respond to `"meat"`) _and then `sleep`_. However, if you feed them anything else, they will shout `"YUCK!!! <name> will not eat <food>"` to let you know they don't like what you fed them. You'll need to override the `eat` method for the Giraffe class to model this behavior. In some cases, you might be able to call the superclass's implementation of the `eat` method to avoid having to recode the parts of this behavior that's similar to your generic `Animal` class.

 */

// Implement the Giraffe class here as a subclass of Animal
// Hint: Implement the initializer method and override the eat method
class Giraffe: Animal {

    init(name: String) {
        // don't forget to correct the call to the superclass initializer!
        super.init(name: name, favoriteFood: "leaves")
    }

    override func eat(food: String) {
        // check here if you don't like the food you were given...
        // don't forget a call to the superclass eat function!
        //print("\(super.name) eats \(food)")
        if (food == super.favoriteFood) {
            print("YUM!!! \(super.name) wants more leaves")
            super.sleep()
        } else {
            print("YUCK!!! \(super.name) will not eat \(food)")
        }
    }
}


/*:

 # Bees

 - callout(Challenge): Implement the `Bee` class as a subclass of `Animal`. Bees only eat pollen. If they are fed pollen _then print "YUM!!! <name> wants more pollen" and call `sleep`_. If fed anything else, the bee will complain in the same way as giraffes do. Additionally, bees never sleep, so if you call the `sleep` method on the Bee class, it should print `"<name> never sleeps"` instead of the standard sleep behavior.
 */

// Implement the Bee class here as a subclass of Animal
// Hint: Implement the initializer method and override the sleep and eat methods
class Bee: Animal {
    init(name : String) {
        super.init(name: name, favoriteFood: "pollen")
    }
    
    override func sleep() {
        print("\(super.name) never sleeps")
    }
    
    override func eat(food: String) {
        if (food == super.favoriteFood) {
            print("YUM!!! \(super.name) wants more \(super.favoriteFood)")
        } else {
           print("YUCK!!! \(super.name) will not eat \(food)")
        }
    }
}


/*:
 ## Testing

 This time, you'll be in charge of writing your own test code! It should output exactly this:

     Tigger eats meat
     YUM!!! Tigger wants more meat
     Pooh eats fish
     YUM!!! Pooh wants more fish
     Pooh eats meat
     Pooh hibernates for 4 months
     Rarity eats marshmallows
     YUM!!! Rarity wants more marshmallows
     Rarity sleeps in a cloud
     YUCK!!! Gemma will not eat meat
     Gemma eats leaves
     YUM!!! Gemma wants more leaves
     Gemma sleeps for 8 hours
     YUCK!!! Stinger will not eat ice cream
     Stinger eats pollen
     YUM!!! Stinger wants more pollen
     Stinger never sleeps

 - callout(Hint): The zoo currently has one animal of each type. There is:
    - A `Tiger` named Tigger
    - A `Bear` named Pooh
    - A `Unicorn` named Rarity
    - A `Giraffe` named Gemma
    - A `Bee` named Stinger

 */
var tiger = Tiger(name: "Tigger")
tiger.eat(food: "meat")

var bear = Bear(name: "Pooh")
bear.eat(food: "fish")
bear.eat(food: "meat")

var unicorn = Unicorn(name: "Rarity")
unicorn.eat(food: "marshmallows")
unicorn.sleep()

var giraffe = Giraffe(name: "Gemma")
giraffe.eat(food: "meat")
giraffe.eat(food: "leaves")

var bee = Bee(name: "Stinger")
bee.eat(food: "ice cream")
bee.eat(food: "pollen")
bee.sleep()



//: [Previous](@previous) | [Next](@next)
