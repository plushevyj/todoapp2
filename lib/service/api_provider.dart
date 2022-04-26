import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<Map<String, dynamic>> get({required String endPoint}) async {
    final url = Uri.parse('https://todoapp2-101d6-default-rtdb.firebaseio.com/$endPoint.json');
    final response = await http.get(url);
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data;
  }

  Future<void> post({required String endPoint, required jsonForPost}) async {
    final url = Uri.parse('https://todoapp2-101d6-default-rtdb.firebaseio.com/$endPoint.json');
    await http.post(url, body: jsonForPost, encoding: Encoding.getByName('utf-8'));
  }

  Future<void> delete({required String endPoint}) async {
    final url = Uri.parse('https://todoapp2-101d6-default-rtdb.firebaseio.com/$endPoint.json');
    await http.delete(url);
  }

  Future<Map<String, dynamic>> getTasks() async {
    var tasks = await get(endPoint: 'users/tasks');
    return tasks;
  }

  Future<void> postTask({required String date, required String task}) async {
    final jsonTask = json.encode(
        {
          'date': date,
          'task': task
        }
    );
    await post(endPoint: 'users/tasks', jsonForPost: jsonTask);
  }

  Future<void> deleteTask({required String index}) async {
    await delete(endPoint: 'users/tasks/$index');
  }
}
