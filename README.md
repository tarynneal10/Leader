# Leader
Leader was created for FBLA's 2020 Mobile Application Development Event. It's purpose is chapter management, and it contains a variety of features to ease the burden of managing and organizing your local FBLA chapter.
You can join your local FBLA chapter, sign up if you're already a member, or add your chapter to keep your chapter connected. You can see your chapter's info, take your meeting minutes in the app, and your chapter members can all access the archives to see what was discussed if they missed a meeting! 
Leader keeps everyone updated with a current events page and calendar with descriptions of events. You can sign up for events to know what you plan on attending. You can view a variety of FBLA's competitive events and basic info about them, with links to them on the website for more info! You can add these events to Your Events, and delete them and submit them to your advisor as need be.

## Installation
Leader is fairly simple to install. It was made on Xcode 11, using swift 5, so make sure everything is up to date when you install. The master branch should have our most stable version that will be used for demonstration at FBLA state. Leader2 is for other changes made in the meantime, and is not the production version. 
If you want to see our code base just clone the respository and run pod install. To test, just sign up and add your chapter in the app once you get it running
(If you are new to github, here's a helpful link on cloning resposities: https://help.github.com/en/articles/cloning-a-repository)

## Functionality
### Authentication
Leader allows people to Join FBLA, Sign Up, or simply Login when they first enter the application. This is the Login page.

![Login](https://github.com/tarynneal10/Leader/blob/master/Leader/Assets.xcassets/Login.imageset/Login.png)
### Home Screen
Here you can navigate to some of Leader's main functionality.

![Home Screen](https://github.com/tarynneal10/Leader/blob/master/Leader/Assets.xcassets/HomeScreen.imageset/Leader1.jpg)
### Chapter
Here you can view your chapter officers, see its members (And change their dues paid status if you are an officer), start meetings & take attendance, and view previous meetings in an archive.

![Chapter](https://github.com/tarynneal10/Leader/blob/master/Leader/Assets.xcassets/Chapter.imageset/Chapter.png)
### Current Events
Current events covers anything your chapter is organizing or attending, and allows its members to better keep track of their schedule. You can add events to the list, or sign up for them by clicking the blue plus sign.

![Current Events](https://github.com/tarynneal10/Leader/blob/master/Leader/Assets.xcassets/CurrentEvents.imageset/Leader5.jpg)
### Competitive Events
Here, you can view the variety of events FBLA has to offer, and with a click you can see their basic details, access more on the website, and even sign up for the event with your events.

![Competitive Events](https://github.com/tarynneal10/Leader/blob/master/Leader/Assets.xcassets/CompetitiveEvents.imageset/Leader3.jpg)
### Calendar
Here, you can see your chapter's current events laid out on a date scale, along with basic details by clicking. 

![Calendar](https://github.com/tarynneal10/Leader/blob/master/Leader/Assets.xcassets/Calendar-1.imageset/Leader2.jpg)
### Settings
The settings page is simple, but includes numerous essential things. There's the About FBLA page with its links to FBLA's social media and FBLA's goals. There's Q&A, Contact US, and Security, which is where you can change your info and view our terms and conditions. There's of course also Bug Report for any issues that pop up.

![Settings](https://github.com/tarynneal10/Leader/blob/master/Leader/Assets.xcassets/Settings-1.imageset/Leader4.jpg)

## Support Info
If you are having major issues with this application, contact us at tarynneal10@gmail.com

## Copyright
#### Images
The logo for Leader was made by the developer, as well as the icons for the tab bars, and settings icons. The logos for FBLA, Twitter, Facebook, and Instagram all belong to the respective entities and not the developer. They were merely used to direct traffic towards said applications. 
#### Libraries & Backend Software
A variety of open source libraries were used in Leader, as well as Firebase's Spark Plan. Firebase was used as the backend for this application, and while the data stored on Firebase is Leader’s, Firebase and it’s software belongs to google. JTAppleCalender was used as a basis for this application's calendar functionality, however the GUI, integration with firebase, and display of event details were all done by the developer of Leader. SVProgressHUD was used to ease the users worries over Firebase’s slow load time, but belongs to its developer. 
#### Privacy
Leader takes privacy very seriously. We cannot view your passwords, nor can we access personal data about you on your phone without your consent. The only information available to us is basic info given to us by you. We will not distribute your information without your permission.
