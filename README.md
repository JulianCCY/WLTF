# What's Left the Fridge? (WLTF)

<p align="center">
<img src="https://c.tenor.com/niCA7dUYfc4AAAAC/fridge-fat.gif"/>
</p align="center">

iOS Mobile Application Development - Metropolia University of Applied Sciences (Spring 2022). The idea is to build a mobile application using Swift and SwiftUI. In this project was splited into six sprints which includes Core Data, Speech Recognition, MapKit and UI design.

## Table of Content
- About WLTF
- Main features
- Speech Recognition with NLP
- App Screenshot
- Useful resources & References
- License
- Contributors

## About WLTF
**WLTF** is an app that shows what food do you have left in your fridge. It helps you keep track of the amount of food that you have left, and gives suggestions on what you can cook based on what you have.

## Main features
### Fridge Screen (Main Screen)
- Storing food
- Showing expiration dates
- adjusting remaining value
- sticky notes reminder on the fridge door

### Grocery list Screen
- Making grocery list
- Adding To-Buy items
- Editing items
- checking existence of item
- Searching nearest markets with Mapkit

### Dishes Screen
- Storing custom recipe
- Note down the ingredient
- Speech recognition with basic Natural language processing frame and custom word tagger ML model
- Checking for the users have enought ingredient to cook a dish, e.g "Can I cook Spaghetti Bolognese for dinner?"
- Asking for cooking recommendation based on what the users have, e.g "What would you recommend me to cook?"

## Speech Recognition with NLP
<img src="https://user-images.githubusercontent.com/70948419/166478822-92f8e994-6930-41d5-9c69-724beee0ad71.png" width="600">
<img src="https://user-images.githubusercontent.com/70948419/166478864-f126e71f-9da7-4da3-9f9a-fd6c03f2953e.png" width="600">
<img src="https://user-images.githubusercontent.com/70948419/166479383-3deedede-e0e7-4c25-b2a3-63954b1ee4e2.png" width="500">

- Using `sentence embedding` to calculate the similarity between user's speech and default question, e.g "Do you have any advice on what should I cook?" is equal to "What do you suggest me to cook?"
- Using custom `word tagger` ML model to extract the text with the type of "FOOD" from user speech, and ignore all the unrelated text
- To reduce the use of complicated if-else and huge amount of key words

## App Screenshots
<p align="center">
  <img src="https://user-images.githubusercontent.com/70948419/166473267-6cce1fb7-bd9a-4854-a813-d0628fa67d2a.PNG" width="250"> 
  <img src="https://user-images.githubusercontent.com/70948419/166473447-2a9f2c41-5ede-47a3-a349-39c8b4739d8f.PNG" width="250"> 
  <img src="https://user-images.githubusercontent.com/70948419/166473459-b67d3d1e-7602-4829-8980-674628fe74d3.PNG" width="250">
</p> 

<p align="center">
  <img src="https://user-images.githubusercontent.com/70948419/166473468-9b55ecd0-792c-44f2-bf62-30a02f2bd4e6.PNG" width="250">
  <img src="https://user-images.githubusercontent.com/70948419/166474028-dddf061c-56c1-49cd-9242-d9ca1a92807f.PNG" width="250"> 
  <img src="https://user-images.githubusercontent.com/70948419/166474032-c3273ccc-c7f4-4d44-ba5a-07e3f6ebcff8.PNG" width="250">
</p> 

<p align="center">
  <img src="https://user-images.githubusercontent.com/70948419/166474214-d33b2335-11f0-4936-aff5-82f0dc469312.PNG" width="250"> 
  <img src="https://user-images.githubusercontent.com/70948419/166474220-6d5d6ebe-e82d-4866-8c50-99a1b89641bf.PNG" width="250"> 
  <img src="https://user-images.githubusercontent.com/70948419/166474427-447bef7c-3ee6-48ab-b5a5-8855c03aac51.PNG" width="250">
</p> 


## Useful resources & References
[Apple developer](https://developer.apple.com/develop/)

[Swift documentation](https://developer.apple.com/swift/)

[Advances in Natural Language Framework](https://developer.apple.com/videos/play/wwdc2019/232)

[Natural Language](https://developer.apple.com/videos/play/wwdc2020/10657/)

[AVSpeechSynthesizer](https://developer.apple.com/videos/play/wwdc2018/236/)

## License
[AGPL-3.0 License](https://github.com/JulianCCY/WLTF/blob/main/LICENSE)

## Contributors
[Chan Chung Yin](https://github.com/JulianCCY) : Core Data, Speech recognition, functions

[Hoi Chit Yu](https://github.com/Borissss420) : Swift UI, MapKit, localisation
