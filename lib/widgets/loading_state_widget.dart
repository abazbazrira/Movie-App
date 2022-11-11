import 'package:flutter/material.dart';

class LoadingStateWidget extends StatelessWidget {
  final String message;

  const LoadingStateWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(
            color: Colors.black,
          ),
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
