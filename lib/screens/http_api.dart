import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobil_projem/model/http_model.dart';


const titleStyle = TextStyle(fontSize: 20);
const subTitleStyle = TextStyle(fontSize: 18);

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final url = Uri.parse('https://reqres.in/api/users');
  int counter = 0;
  var personalResult;

  Future callPerson() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = personalFromJson(response.body);
        if (mounted)
          setState(() {
            counter = result.data.length;
            personalResult = result;
          });
        return result;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    callPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personel Listesi'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: counter != null
                ? ListView.builder(
                itemCount: counter,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      personalResult.data[index].firstName +
                          ' ' +
                          personalResult.data[index].lastName,
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      personalResult.data[index].email,
                      style: subTitleStyle,
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                      NetworkImage(personalResult.data[index].avatar),
                    ),
                  );
                })
                : Center(child: CircularProgressIndicator())),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.teal,
        onPressed: () {
          callPerson();
        },
      ),
    );
  }
}
