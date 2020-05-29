# wash-hands

Wash hands is a small project to show my code, make some tests and, basically, just mess around with iOS development.
The main idea is to not use any dependencies at all, or as less as possible.

---

## Architecture

Because, right now, is just a really small project, I'm using plain and old MVC.

The folder structure is currently organized like this:

* AppDelegate
* SceneDelegate
* ViewControllers
 - MainViewController
 - MainViewController
* Views
 - CircularProgressView
* Services
 - GifService
 - BaseService
 - APIErrors
* Models
 - GiphyAPIResponse
 - GiphyAPIEntity
 - GiphyAPIImagesEntity
* Resources
 - Assets/Assets.xcassets
 - Storyboards
   - LaunchScreen
   - Main
* Utils
 - Extensions
   - UIColor
   - URLSession
 - VideoPlayer
   - VideoPlayer
* SupportingFiles
  - Info.plist

### Some feedback:

1. For now, I'm using the ViewCode approach. I created a View, called `MainView`, to handle all UI interactions. This way, I can reduce the amount of code written in `MainViewController` class and segregate responsibilities. There are storyboards in the project but they have nothing in it.

2. The `MainViewController` is responsible for fetching the data in the [custom backed](https://github.com/luizfelipeairesoares/washands-api) I created.

---

## Next Steps:

- Adopt Git Flow in the project
- Unit Testing
- UI improvements
