import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:preggo/models/user.dart';
import 'package:preggo/services/sharedfunctions.dart';
import 'package:preggo/growthscreen/growthcalculator.dart';

Future<Uint8List> makePdf(UserData userData) async {
  final pdf = Document();

  final imageLogo = Image(MemoryImage(
      (await rootBundle.load('assets/icon/icon.png')).buffer.asUint8List()));

  Map mostRecentWeight =
      GrowthCalculator().findMostRecentWeight(userData.weightlist);
  String recentDate =
      toPrettyDateMMMddyyyy(mostRecentWeight['time']).toString();
  String recentWeight = "${mostRecentWeight['weight']} lbs";

  String weightListforPDF = '';

  for (Map item in userData.weightlist) {
    String prettyFormat =
        "${toPrettyDateMMMddyyyy(item['time'])} - ${item['weight'].toString()} lbs\n";

    weightListforPDF = weightListforPDF + prettyFormat;
  }

  String conceptionDate = toPrettyDateMMMddyyyy(
      GrowthCalculator().getDateofConceptionEpoch(userData.epochduedate));

  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Attention to: ${userData.email}"),
                    Text(
                        'Below is information from a\npatient in your upcoming appointment'),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: imageLogo,
                ),
              
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'PREGNANCY INFORMATION',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: PaddedText('Estimated Due Date'),
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText(
                          toPrettyDateMMMddyyyy(userData.epochduedate)),
                      flex: 1,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: PaddedText('Days until Estimated Due Date'),
                      flex: 2,
                    ),
                    Expanded(
                      child:
                          PaddedText(daysLefttoDueDate(userData.epochduedate)),
                      flex: 1,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: PaddedText('Weight Prior to Pregnancy'),
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText(
                          "$conceptionDate -- ${userData.weight} lbs"),
                      flex: 1,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: PaddedText('Most Recent Weight'),
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText("$recentDate -- $recentWeight"),
                      flex: 1,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: PaddedText('Weigh-In List'),
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText(weightListforPDF),
                      flex: 1,
                    )
                  ],
                ),
              ],
            ),
            Padding(
              child: Text(
                "INFORMATION BY CHILDING APP",
                style: Theme.of(context).header2,
              ),
              padding: EdgeInsets.all(20),
            ),
            Text("Please forward the above information to your provider!"),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Thank you for using Childing!',
                style: Theme.of(context).header3.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
