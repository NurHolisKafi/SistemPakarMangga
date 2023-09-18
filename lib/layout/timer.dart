import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class TimeoutMixin<T extends StatefulWidget> extends State<T> {
  static const Duration inactiveDuration = Duration(minutes: 25);
  Timer? _timer;

  void _handleTimeout() {
    SystemNavigator.pop();
    print('ok');
  }

  @override
  void initState() {
    resetTimer();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resetTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void resetTimer() {
    _cancelTimer();
    _timer = Timer(inactiveDuration, _handleTimeout);
  }

  void _cancelTimer() {
    if (_timer != null) {
      if (_timer!.isActive) {
        print('reset');
        _timer!.cancel();
      }
    }
  }
}
