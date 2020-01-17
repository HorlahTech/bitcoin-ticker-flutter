import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = 'AA8EC744-FD2C-4B62-88FF-BCE5183CDCD5';
dynamic getNetwork(String value) async {
  http.Response response = await http.get(
    Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/ETH/$value?apikey=$apiKey'),
  );
  if (response.statusCode == 200) {
    var data = response.body;
    return jsonDecode(data);
  } else {
    print('hsggdsjhdjhgsdjgdsjgdjsg   ${response.statusCode}');
  }
}
