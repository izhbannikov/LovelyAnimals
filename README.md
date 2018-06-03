# LovelyAnimals

This is an iPhone app which allows you to add animals you love. By default I added foxes, wolves and dogs. 

You can add your own animal family and then add your lovely species under that animal family.

The app contains 8 view controllers, custom touch handling (long press gesture recognizer on table row) and 
network functionality (provides link to Wikipedia). 

The app also stores your data between app sessions with NSData model.

# Usage

* To add new animal family OR new species use '+' button, then a modal view will appear.
* To edit an animal family OR species use either long press on table row OR swipe the row and choose "More" (green button). The modal view will appear.
* To delete an animal family OR new species, swipe the table row and choose "Delete" (red button)

# TODO

* Develop adding pictures functionality for each animal/species
* Add thubmnails for each animal/species

# Requiremets

* Xcode version: 7.3.1 (7D1014) - I used this version for development, did not tested on later versions.
* Swift version:  2.2 (swiftlang-703.0.18.8 clang-703.0.31)


