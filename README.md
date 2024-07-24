# antinna_ui_kit

`antinna_ui_kit` is a Flutter package that provides a set of UI components, including a connectivity banner to notify users of network status changes.

## Features

- **ConnectivityBannerHost**: A widget that displays a banner when the network connection is lost.


## Getting Started

To use the `ConnectivityBannerHost`  widget, add the following import to your Dart code:

```dart
import 'package:antinna_ui_kit/antinna_ui_kit.dart';
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:antinna_ui_kit/antinna_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

// Both Use Case In One Code Example , Choose One as Per Requirement
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ConnectionMonitor(
          child: ConnectivityBannerHost(
            isConnected: isConnected,
            banner: const Material(
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Text(
                  'No Internet Connection',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isConnected = !isConnected;
                  });
                },
                child: Text(isConnected ? 'Disconnect' : 'Connect'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class ConnectionMonitor extends StatefulWidget {
  const ConnectionMonitor({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ConnectionMonitor> createState() => _ConnectionMonitorState();
}

class _ConnectionMonitorState extends State<ConnectionMonitor> {
  late final _connectivity = _connectivityStream();

  

  Stream<ConnectivityResult> _connectivityStream() async* {
    final connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();
    yield result.first;
    yield* connectivity.onConnectivityChanged
        .expand((results) => results); // Flatten the stream
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _connectivity,
      builder:
          (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return widget.child;
        }
        final result = snapshot.requireData;
        return ConnectivityBannerHost(
          isConnected: result != ConnectivityResult.none,
          banner: const Material(
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
              child: Text(
                'Please check your internet connection',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

```

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  antinna_ui_kit: ^1.0.0
```

Then run `flutter pub get` to install the package.

## Acknowledgements

Special thanks to [Simon Lightfoot](https://github.com/slightfoot) for his inspiration and contributions to the Flutter community.


## Contributing
Contributions are welcome! Please submit pull requests or create issues for any improvements or bugs you find.

[Github Repo](https://github.com/antinna/antinna_ui_kit)

## Sponsor
If you find this project helpful, consider sponsoring it on GitHub:

[Github Sponsor](https://github.com/sponsors/Manishmg3994)


Follow on YouTube
For more tutorials and project walkthroughs, subscribe to our YouTube channel:

[@Antinna YouTube Channel](https://m.youtube.com/antinna)

---
Maintained by [Manish Gautam](https://github.com/Manishmg3994)

---

---
Powered By [Antinna](https://github.com/antinna)




