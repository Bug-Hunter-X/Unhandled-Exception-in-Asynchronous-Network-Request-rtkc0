```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data']; // Return the data
    } else {
      // Log the error with more detail
      print('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to load data: ${response.statusCode} - ${response.reasonPhrase}');
    } 
  } on SocketException catch (e) {
    print('Network error: $e'); 
    throw Exception('No internet connection');
  } on FormatException catch (e) {
    print('JSON format error: $e');
    throw Exception('Invalid JSON response');
  } catch (e) {
    print('Unexpected error: $e');
    rethrow; // Re-throw for higher-level handling
  }
}
```