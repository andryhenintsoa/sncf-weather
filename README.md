# sncf_weather

Mobile application for Weather forcast

## Getting Started

This project is a mobile application for weather forcast.

After signing, the user get the weather for the next 5 days during daytime. The default city is Paris but the application allows to change city

<img src="https://user-images.githubusercontent.com/22822536/193047639-d2f66394-a35a-45e2-ad49-16713c43ea3a.png" height="400" />

## Installation

After cloning the repository, there are few steps to follow to launch the app

- Update the .env file to follow your configurations. In our app, we have used the API of OpenWeatherMap but you are free to use another one and adapt the code to it
```sh
ENDPOINT=http://api.openweathermap.org
APPKEY=ec421a389b9aee93fb68ca13484e17ea
```
- Use code generation to generate constructors for the model used
```sh
 flutter pub run build_runner build
```
- (Optional) If you want to change the logo, change the image `assets/images/logo.png` and launch the command 
```
flutter pub run flutter_launcher_icons:main
```
- Now, the app can be launched. For login, which is hard coded, you can use `0000` as password and any email. Your username will be the email given
