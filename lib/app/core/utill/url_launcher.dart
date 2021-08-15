import 'package:url_launcher/url_launcher.dart';

class Launch {
  static Future<void> openUrl({required String url}) => _launchUrl(url);
  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
