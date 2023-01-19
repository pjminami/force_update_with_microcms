import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

Future<bool> versionCheck() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = Version.parse(packageInfo.version);
  
  final result = await http.get(
    Uri.parse('https://xflutter.microcms.io/api/v1/force_update'),
    headers: {
      "X-MICROCMS-API-KEY": dotenv.env['MICRO_CMS_API_KEY']!
    }
  );
  final body = json.decode(result.body);
  final requiredVersion = Version.parse(body['minAppVersion']);
  return currentVersion.compareTo(requiredVersion).isNegative;
}
