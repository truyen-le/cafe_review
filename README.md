# cafe_review

A Cafe Review App.

## Getting Started

Before compiling the project, in the project root folder:
- add `.env` file follow `.env_example`
- add `map.api.key=YOUR_API_KEY` in `./android/local.properties` for **Android**
- add `MAP_API_KEY : YOU_API_KEY` as one of Environment Variables in xCode for **iOS**
- run `flutter pub get` to install all the packages.
- run `flutter pub run build_runner build --delete-conflicting-outputs` to generate **freezed** files.
