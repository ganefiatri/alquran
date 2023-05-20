import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  //Uri url = Uri.parse("https://quran-api-id.vercel.app/surahs");
  //var res = await http.get(url);

  var res = await http.get(Uri.parse("https://api.quran.gading.dev/juz/1"));
  Map<String, dynamic> data = json.decode(res.body);
  print(data);
}
