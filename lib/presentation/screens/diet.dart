import 'package:flutter/material.dart';
import 'package:preggo/shared/constants.dart';
import 'package:webviewx/webviewx.dart';

class Diet extends StatelessWidget {
  static const String id = 'diet_screen';

  const Diet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: FittedBox(
                  child: Text(
                    'How much should I eat?',
                    style: kGoogleTitle,
                  ),
                ),
              ),
            ),
            DietWebFrame(
              height: MediaQuery.of(context).size.height * 0.7,
            )
          ],
        ),
      ),
    );
  }
}

class DietWebFrame extends StatefulWidget {
  final double height;

  const DietWebFrame({Key? key, this.height = 300}) : super(key: key);

  @override
  State<DietWebFrame> createState() => _DietWebFrameState();
}

class _DietWebFrameState extends State<DietWebFrame> {
  late WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    double height = widget.height;

    return WebViewX(
      width: 330,
      height: height,
      initialContent:
          '<iframe src="https://www.myplate.gov/widgets/myplate-plan-start" scrolling="no" style="min-height: ${height}px;"></iframe>',
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) => webviewController = controller,
    );
  }
}
