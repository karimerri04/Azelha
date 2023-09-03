import 'package:azelha/contsants/colors.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

double cartAmount = 30.01;
ScanResult scanResult = new ScanResult();
var _autoEnableFlash = false;

class DialogAfterScan {
  void dialogViewReceipt(context, onPressed, scanResult) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusCard),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (scanResult != null)
                  Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Result Type"),
                          subtitle: Text(scanResult.type?.toString() ?? ""),
                        ),
                        ListTile(
                          title: Text("Raw Content"),
                          subtitle: Text(scanResult.rawContent ?? ""),
                        ),
                        ListTile(
                          title: Text("Format"),
                          subtitle: Text(scanResult.format?.toString() ?? ""),
                        ),
                        ListTile(
                          title: Text("Format note"),
                          subtitle: Text(scanResult.formatNote ?? ""),
                        ),
                        ListTile(
                          title: Text("Other options"),
                          dense: true,
                          enabled: false,
                        ),
                        CheckboxListTile(
                          title: Text("Emballage vide"),
                          value: _autoEnableFlash,
                          onChanged: (checked) {
                            _autoEnableFlash = checked;
                          },
                        ),
                        SizedBox(height: 10.0),
                        FlatButton(
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kRadiusButton),
                          ),
                          child: Text(
                            'CLOSE',
                            style: TextStyle(color: Colors.orange),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
