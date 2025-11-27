import 'package:smartui_components/remote/api/api_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApiDataScreen extends StatelessWidget {
  const ApiDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final api = ApiCubit();
              var result = await api.getApi('https://jsonplaceholder.typicode.com/posts/1'); //Api name
              if (kDebugMode) {
                print("Response -> $result");
              }
            },
            child: Text('Get & Check Api data'),
          ),
          ElevatedButton(
            onPressed: () async {
              final api = ApiCubit();
              var payload = {"title": "foo", "body": "bar", "userId": 1};
              var result = await api.postApi("https://jsonplaceholder.typicode.com/posts", payload);
              if (kDebugMode) {
                print("POST Response -> $result");
              }
            },
            child: Text('Post Api & Check Api data'),
          ),
        ],
      ),
    );
  }
}
