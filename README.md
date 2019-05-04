# RN Zoom Demo

This demo shows the basics of building a React Native native module from scratch.

### Preparation

```
npm i
```

```
cd ios
pod install
```

### Zoom Keys

Open `https://marketplace.zoom.us/user/build` and create an application of `Account level` type. 

Then open `config.js` and set your `ZOOM_SDK_KEY` and `ZOOM_SDK_SECRET`

### Run

For iOS open `/ios/RNZoomDemo.xcworkspace` in Xcode and run the project.

For Android, import the `/android` project into Android Studio and run the project.




##### Please note after making changes in Javascript code you will need to run `npm run bundle` to bundle the new changes so Android can see them.