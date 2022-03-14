# dealflow_coding_challenge

A mini-project to list creators and their details.

Consists of screens: Sign Up, Log in, Creators screen, Creator details screen.

### Mock API

Mockapi.io was used in this project.

https://mockapi.io/projects/6228f84dbe12fc45389314bf is the mock API for this app.

Since there is no real API integrated, there are limitations. 

Please note:

  - The /login endpoint returns a statusCode of 201 rather than 200 on a successful request.
  - Entering details in sign up screen and hitting 'sign up' does not create a new user with the provided information, but rather generates a new user with mock data.
  - The images used in the app are random images from unsplash.com

### State management

The state management technique used in the project is Provider (https://pub.dev/packages/provider).

A provider per view is used in this project where necessary;

### Request handling

The conveyor.dart class is written for request handling with the help of the http package.

https://pub.dev/packages/http

![](https://github.com/heshanka/dealflow/master/df.gif)
