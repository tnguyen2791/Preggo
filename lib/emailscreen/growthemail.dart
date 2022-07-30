import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:preggo/emailscreen/makepdf.dart';
import 'package:preggo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

class EmailSender extends StatefulWidget {
  const EmailSender({Key? key}) : super(key: key);
  static String id = 'emailscreen';

  @override
  EmailSenderState createState() => EmailSenderState();
}

class EmailSenderState extends State<EmailSender> {
  String emailbody = 'error loading';

  @override
  void initState() {
    _loadEmailBody();
    super.initState();
  }

  Future<void> _loadEmailBody() async {
    final loadedEmailBody =
        await rootBundle.loadString('assets/texts/bodyforemail.txt');
    setState(() {
      emailbody = loadedEmailBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> attachments = [];
    bool isHTML = false;

    final userData = Provider.of<UserData>(context);

    final recipientController = TextEditingController(
      text: userData.email,
    );

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM-dd-yyyy').format(now);

    final subjectController =
        TextEditingController(text: 'Childing Information on $formattedDate');

    final bodyController = TextEditingController(
      text: emailbody,
    );

    Future<void> send() async {
      final Email email = Email(
        body: bodyController.text,
        subject: subjectController.text,
        recipients: [recipientController.text],
        attachmentPaths: attachments,
        isHTML: isHTML,
      );
      final docdirect = await getApplicationDocumentsDirectory();
      String docdirectory = docdirect.path;
      Uint8List pdf = await makePdf(userData);
      String newfilepath = "$docdirectory/ChildingReport.pdf";
      final file = File(newfilepath);
      file.writeAsBytesSync(pdf);
      // OpenDocument.openDocument(filePath: newfilepath);
      // _attachFileFromAppDocumentsDirectory();
      attachments.add(newfilepath);

      String platformResponse;

      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'success';
      } catch (error) {
        print(error);
        platformResponse = error.toString();
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(platformResponse),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('E-mail your your growth!'),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: recipientController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: subjectController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     children: <Widget>[
            //       for (var i = 0; i < attachments.length; i++)
            //         Row(
            //           children: <Widget>[
            //             Expanded(
            //               child: Text(
            //                 attachments[i],
            //                 softWrap: false,
            //                 overflow: TextOverflow.fade,
            //               ),
            //             ),
            //             IconButton(
            //               icon: const Icon(Icons.remove_circle),
            //               onPressed: () => {_removeAttachment(i)},
            //             )
            //           ],
            //         ),
            //       Row(
            //         children: [
            //           IconButton(
            //             icon: const Icon(Icons.attach_file),
            //             onPressed: _openImagePicker,
            //           ),
            //           IconButton(
            //             icon: const Icon(FontAwesomeIcons.filePdf),
            //             onPressed: () => Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) =>
            //                     PdfPreviewPage(userData: userData),
            //               ),
            //             ),
            //           ),
            //           IconButton(
            //               icon: const Icon(FontAwesomeIcons.print),
            //               onPressed: () async {
            //                 FilePickerResult? result = await FilePicker.platform
            //                     .pickFiles(type: FileType.any);
            //                 if (result != null) {
            //                   File file = File(result.files.single.path!);
            //                 } else {}
            //               }),
            //           IconButton(
            //               icon: const Icon(FontAwesomeIcons.galacticRepublic),
            //               onPressed: () async {}),
            //         ],
            //       ),
            //       const Text('Your most recent weight report is attached!')
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
