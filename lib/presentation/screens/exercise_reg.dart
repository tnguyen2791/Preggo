import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:preggo/shared/constants.dart';
import 'package:webviewx/webviewx.dart';

class ExerciseRegimen extends StatelessWidget {
  static const String id = 'exercise_screen';

  const ExerciseRegimen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise"),
      ),
      body: Center(
        child: Column(
          children: [
            FittedBox(
              child: Text(
                'How much should I exercise?',
                textAlign: TextAlign.center,
                style: kGoogleTitle,
              ),
            ),
            ExerciseWebFrame(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
            )
          ],
        ),
      ),
    );
  }
}

class ExerciseWebFrame extends StatefulWidget {
  final double height;
  final double width;

  const ExerciseWebFrame({Key? key, this.height = 300, this.width = 150})
      : super(key: key);

  @override
  State<ExerciseWebFrame> createState() => _ExerciseWebFrameState();
}

class _ExerciseWebFrameState extends State<ExerciseWebFrame> {
  late WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    double width = widget.width;

    return WebViewX(
      width: width,
      height: height,
      initialContent:
          '<iframe frameborder="0" width="$width" height="$height" id="mywwidget" marginheight="0" marginwidth="0" name="mywwidget" scrolling="no" src="https://health.gov/MoveYourWay/widget/" title="health.gov MoveYourWay"></iframe>',
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) => webviewController = controller,
    );
  }
}
