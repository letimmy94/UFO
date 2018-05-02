# UFO

UFO is our attempt at a [Flappy Bird](https://en.wikipedia.org/wiki/Flappy_Bird) clone.
This game features a floating Obama head traversing through a world of squares.

How did he get there? What is his story? Well apparently after leaving office, he was lost in this abyss and disembodied. Now his head has special powers and he needs to get by these squares to come back, change the constitution, and get his third term. Easy peasy.

## Requirements

* Xcode 9 or higher
* iOS 11
* A Free Apple ID

## Installing && Deployment

1.  Clone and Download
2.  In Terminal `$ Open UFO.xocodeproj`
    (steps 3 - 8 are optional if you only want to view on your laptop)
3.  Open Xcode > Preferences
4.  Click 'Accounts' Tab
5.  Login with your Apple ID
6.  Plug in your iOS device and press the play button in the top left
7.  You will likely get a signing error. Go to the Project Editor (Click on your folder to the left of your screen) and select the 'General' section Click "fix issue." Select your 'Personal Team' profile that was autocreated for you in step 5.
8.  On your iOS device select "Trust." Then proceed to settings > General > Device Management. Tap your email and press trust.
9.  Click the play button with the desired device you'd like to play the game on.

## Built With

* [Swift 4.1](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)
* [SpriteKit](https://developer.apple.com/documentation/spritekit)
* Love

## Our approach

We knew we wanted to use a mobile app but didn't have the tools in our wheelhouse with our background in of JS and Ruby. And thus we needed to learn Swift.

Swift was a new language for us, but we figured if Rome was built in a day we could learn it in a day. And so we did.

But in actuality there was a ton of googling, a lot of example finding, and then debugging aplenty. So basically a standard week for a developer.

## Next Steps

* Implement high score locally and globally. (In Progress)
* Character selection.
* On collision we want our UFO to have a reaction. (In Progress)
* On press we want our UFO to make some kind of face. (In Progress)
* Boxes should scroll onto the screen, not just appear on the edge.
* Buy a developer account && deploy to the AppStore (In Progress)
* Settings button (In Progress)

## Authors

* **Daniel Freudberg** - _Co-Developer_ - [dbf8](https://github.com/dbf8)
* **Timmy Le** - _Co-Developer_ - [letimmy94](https://github.com/letimmy94)

## Acknowledgments

* Zakk for forcing us to work together.
* New Perry for being named Jimmy.
* Meg for making amazing jokes that often times only Daniel understood and went over everyone elses' head.
* Old blue.
* Our board of directors.
* [The Dewy Show](https://www.youtube.com/user/dewy8show) creators for their generous donation of a cartoon style President Barack Obama face.
* [Aspect Ratio Calculator](https://andrew.hedges.name/experiments/aspect_ratio/) - When we couldn't do math.
* [Namko Art's](https://namkoart.deviantart.com/) [_Myth of Life_](https://namkoart.deviantart.com/art/Myth-of-Life-102607782)

### References

* [Spritekit](https://developer.apple.com/documentation/spritekit)
* [Spritekit SK Physics Body](https://developer.apple.com/documentation/spritekit/skphysicsbody)
* [Hacking With Swift](https://www.hackingwithswift.com/read/11/5/collision-detection-skphysicscontactdelegate)
* [Sweet Tutos' Tutorial](http://sweettutos.com/2017/03/09/build-your-own-flappy-bird-game-with-swift-3-and-spritekit/) (for _some_ guidance)
