/// this file is used to send email notification message
/// It is a generalized file in which we can pass custom templates of different messages for different events.
/// can be run on android and ios only not for web
/// Pending: where to call this functionality

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// 1//09VeBivsBb5W1CgYIARAAGAkSNwF-L9IrxGBgZ61scBRtDruZgxGgewS-hoNGEzF2Yq7A6bBVALYpnNULBlE-Vl1bg93LsqcnKE4
class EmailSender extends StatelessWidget {
  const EmailSender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: const Text("Send email"),
        onPressed: () async {
          await sendEmail(context);
        },
      )),
    );
  }

  Future<void> sendEmail(context) async {
    /// sender email
    String sender = "honeybansal2968@gmail.com";

    /// access token of the official helpy moto google account
    /// If want to get the access token without google sign up process, use GmailOAUTH2Utilities_bundled_jre_Windows_x64_v1.1.0 software .
    /// It only requires the client id of desktop type credential and secret id
    String accesstoken =
        "ya29.a0AfB_byBYywdWfIuZiwbsQppUFdw2JbDKk-HOKgHn__sACASq3HFCUm1gIt_vUixdV2d7vL1wlaf7OSBLqvIIj4BISJt11iOfAd5zqphxGNREU2OJhKHLsKe6ETPxk5dp1HZvIsHUbSD4ktEY85tJkyMTj6YnaCgYKAdQSARESFQHsvYlsmcF66VPkvuEKDbGSlzuE-g0163";
    final smtpServer = gmailSaslXoauth2(sender, accesstoken);
    var message = Message()
      ..from = Address(sender, 'Honey Bansal')
      ..recipients.add('honeybansalcloud9@gmail.com')
      ..subject = 'Helpy moto ${DateTime.now()}'
      ..text = 'Tno one ne 2 of the text part.';
    try {
      final sendReport = await send(message, smtpServer);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Success")));
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Message not sent. $e")));
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
