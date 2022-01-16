This is an unofficial third party library for the awesome [Tawk.to](https://www.tawk.to/) plartform. Since there is no official SDK for mobile, I had to leverage their direct chat link and the cool powers of webview.  

## 🚀 Screenshots

<p>
    <img src="https://raw.githubusercontent.com/Hamza-Imran75/tawkto_flutter/master/resources/Screenshot_20220101-220939.jpg" width="200" />
    <img src="https://raw.githubusercontent.com/Hamza-Imran75/tawkto_flutter/master/resources/Screenshot_20220101-221055.jpg" width="200" />
    <img src="https://raw.githubusercontent.com/Hamza-Imran75/tawkto_flutter/master/resources/Screenshot_20220101-220955.jpg" width="200" />
    <img src="https://raw.githubusercontent.com/Hamza-Imran75/tawkto_flutter/master/resources/Screenshot_20220101-221115.jpg" width="200" />
</p>


## 😎 Features
This pluggin has the following features:
* Direct chat link integration, through webview
* Able to programmatically listen to agents message (onChatMessageAgent).
    This can be used to show notification.

## ⚙️ Install it

To use this package, add `tawkto_flutter` as dependency in your pubspec.yaml file. Then add `minSdkVersion 19` to `android/app/build.gradle` in the `defaultConfig` portion.

## 🚢 Import it

```dart
import 'package:tawkto_flutter/tawkto_flutter.dart';
```

## 🤔 How To Use

```dart
TawkToWidget(
    directChatLink: 'YOUR_DIRECT_CHAT_LINK',
    visitor: TawkToVisitor(
        name: 'Hamza Imran',
        email: 'hamzaimran43@gmail.com',
    ),
    onChatMessageAgent: (msg) {
        print("MESSAGE_FROM_AGENT: $msg");
    },
);
```

See the `example` directory for the complete sample app.

## 🤓 API
### TawkToWidget
| Parameter      | Type          | Default                                      | Description                                    | Required |
| -------------- | ------------- | -------------------------------------------- | ---------------------------------------------- | -------- |
| directChatLink | `String`      | `null`                                       | Tawk direct chat link.                         | Yes      |
| visitor        | `TawkVisitor` | `null`                                       | Object used to set the visitor name and email. | No       |
| onLoad         | `Function`    | `null`                                       | Called right after the widget is rendered.     | No       |
| onChatMessageAgent         | `Function`    | `null`                                       | Invoked when a message is received from the agent. The message is passed to the callback.     | No       |
| onLinkTap      | `Function`    | `null`                                       | Called when a link pressed.                    | No       |
| loadingWidget    | `Widget`      | `Center(child: CircularProgressIndicator())` | Render your own loading widget.                | No       |

### TawkVisitor

| Parameter | Type     | Default | Description                                                 | Required |
| --------- | -------- | ------- | ----------------------------------------------------------- | -------- |
| name      | `String` | `null`  | Visitor's name.                                             | No       |
| email     | `String` | `null`  | Visitor's email.                                            | No       |
| hash      | `String` | `null`  | [Secure mode](https://developer.tawk.to/jsapi/#SecureMode). | No       |

## 😊 Side note
The reason I made this package, even though a package, [flutter_tawk](https://github.com/ayoubamine/flutter_tawk) by [ayoubamine](https://github.com/ayoubamine/), already exists was because it hadn't been maintained in quite awhile. Plus I've been wanting to build my own package from quite some time to learn the inner workings. Hence, this package is heavily inspired by [flutter_tawk](https://github.com/ayoubamine/flutter_tawk) as can be seen in this readme and the code as well. I'm planning on keeping this package maintained till at least we get an official package. I also plan on adding further Tawk.to api's as well, so stay tuned.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/Hamza-Imran75/tawkto_flutter/issues).  
If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/Hamza-Imran75/tawkto_flutter/pulls.


## Changelog

[CHANGELOG](./CHANGELOG.md)

## License

[MIT License](./LICENSE)

