import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final String customText;

  const LoadingView({
    Key? key,
    this.customText = 'Loading ...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const CircularProgressIndicator(
              strokeWidth: 6,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: RichText(
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: customText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
