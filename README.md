<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Package for viewing photos with zoom and swipe, just like Facebook.

## Usage

Add package to `pubspec.yaml` file.

```dart
dependencies:
  flutter_fb_photo_view: ^latest
```

Import package to code file.

```dart
import 'package:flutter_fb_photo_view/flutter_fb_photo_view.dart';
```

## Example
Use as a normal widget:

```dart
final combineItems = [
  "assets/gallery1.jpg",
  "assets/gallery2.jpg",
  "assets/gallery3.jpg",
  "assets/large-image.jpg",
  "assets/small-image.jpg",
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 217, 236, 1),
      body: Center(
        child: FBPhotoView(
          dataSource: combineItems,
          displayType: FBPhotoViewType.list,
        ),
      ),
    );
  }
```
displayType: FBPhotoViewType.list
![FBPhotoViewType.list](https://github.com/kent2508/flutter_fb_photo_view/blob/main/resources/carousel_list.png?raw=true =250x)
displayType: FBPhotoViewType.grid3
![FBPhotoViewType.grid3](https://github.com/kent2508/flutter_fb_photo_view/blob/main/resources/grid3.png?raw=true)
displayType: FBPhotoViewType.grid4
![FBPhotoViewType.grid4](https://github.com/kent2508/flutter_fb_photo_view/blob/main/resources/grid4.png?raw=true)
displayType: FBPhotoViewType.grid5
![FBPhotoViewType.grid5](https://github.com/kent2508/flutter_fb_photo_view/blob/main/resources/grid5.png?raw=true)
Show fullscreen
![Show fullscreen](https://github.com/kent2508/flutter_fb_photo_view/blob/main/resources/fullscreen.png?raw=true)
Drag to dismiss
![Drag to dismiss](https://github.com/kent2508/flutter_fb_photo_view/blob/main/resources/dismiss.png?raw=true)

## Additional information
This package's inspired by Facebook photo viewer. That's one of the best photo viewer between thousands apps out there. The author just want to bring it to Flutter community.
