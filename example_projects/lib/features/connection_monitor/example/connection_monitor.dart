import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:antinna_ui_kit/antinna_ui_kit.dart';

// void main() {
//   runApp(const MyApp());
// }

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
