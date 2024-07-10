import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiController {
  static Future<String?> addRemoveWishList(int productId) async {
    try {
      String apiUrl = "https://bmdublog.com/TollOut/api/add-wishlist";
      String authToken = "503|cONOY8NVJV7rkVjL5mGe8COOTjpaOwE99LL027H71cce4116";
      var response = await http.post(Uri.parse(apiUrl),
          headers: {
            "Authorization": "Bearer $authToken",
            "Content-Type": "application/json",
          },
          body: jsonEncode({"product_id": productId}));
      if (response.statusCode == 200) {
        log(response.body);
        var decodedResponse = jsonDecode(response.body);
        return decodedResponse["message"];
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
