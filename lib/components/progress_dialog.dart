import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class ProgressDialog extends StatefulWidget {
  final Future<bool> future;
  final Duration delay;
  final String loading;
  final String success;
  final String falied;
  const ProgressDialog({
    Key key,
    @required this.future,
    this.delay = const Duration(seconds: 1),
    @required this.loading,
    @required this.success,
    @required this.falied,
  }) : super(key: key);

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _changeState();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: _stateManager(),
    );
  }

  void _changeState() async {
    bool check = await widget.future;
    setState(() {
      _isLoading = false;
      _isSuccess = check;
      _timeToOff();
    });
  }

  void _timeToOff() async {
    await Future.delayed(widget.delay);
    Navigator.of(context).pop(_isSuccess);
  }

  Widget _stateManager() {
    if (_isLoading) return _loading();
    return _isSuccess ? _success() : _failed();
  }

  Widget _loading() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: Layouts.SPACING / 2),
        Flexible(
          child: Text(
            widget.loading,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }

  Widget _success() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check,
          color: Colors.green,
        ),
        SizedBox(width: Layouts.SPACING / 2),
        Flexible(
          child: Text(
            widget.success,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }

  Widget _failed() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: Colors.red,
        ),
        SizedBox(width: Layouts.SPACING / 2),
        Flexible(
          child: Text(
            widget.falied,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
