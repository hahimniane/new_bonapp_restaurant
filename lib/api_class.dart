import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

class API {
  var headers = {
    'Authorization': 'Bearer 96b1c9959b46903a2b33b80587fee9ab4b1d7535'
  };

  getApi(File image) async {
    var path = File(image.path);
    print('the image file is $image');
    var headers = {
      'Authorization': 'Bearer 96b1c9959b46903a2b33b80587fee9ab4b1d7535'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://api.logmeal.es/v2/image/recognition/type/v1.0?skip_types=%5B1%2C3%5D&language=eng'));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      print(data);
      var jsonData = json.decode(data);

      print(jsonData[0]['food_types'][0]['name']);
      print('=================================================');
      // for (var entry in jsonData.entries) {
      //   // print('the key is ${entry.key}');
      //   if (entry.key == 'food_types') {
      //     for (int i = 0; i < entry.key.length; i++) {}
      //     print('the entries of the food types are ${entry.value[0][2]}\n');
      //
      //     // for (var element in entry.value) {
      //     //   if (element.key == 'probs') {
      //     //     print('the prob is ${element.value} \n');
      //     //   }
      //     // }
    } else {
      print(response.reasonPhrase);
      // } else {
      //   print(response.reasonPhrase);
      // }
    }
  }
}
