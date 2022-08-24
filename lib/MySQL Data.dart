
import 'package:database/Boxes.dart';
import 'package:hive_generator/hive_generator.dart';
import 'package:database/Model/userModel.dart';
import 'package:database/comm/getFormField.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MySQL extends StatefulWidget {
  const MySQL({Key? key}) : super(key: key);

  @override
  State<MySQL> createState() => _MySQLState();
}

class _MySQLState extends State<MySQL> {
  final _formKey = GlobalKey<FormState>();

  final conName = TextEditingController();
  final conNumber = TextEditingController();
  final conLocation = TextEditingController();

  @override
  void dispose() {
    Hive.close(); //Closeing All Boxes

    //Hive.box('users').close(); //Closeing selected Box

    super.dispose();
  }

  Future<void> addUser(String uName, String uNumber, String uLocation) async {
    if (_formKey.currentState!.validate()) {
_formKey.currentState!.save();

      final user = UserModel()
        ..user_name = uName
        ..user_number = uNumber
        ..location =uLocation;

      final box = Boxes.getUsers();
      //Key Auto Increment
      box.add(user).then((value) => clearPage());
    }
    
  }
 Future <void> deleteUser(UserModel userModel) async {
  userModel.delete();

 }

  

  clearPage() {
    conName.text = '';
    conNumber.text = '';
    conLocation.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Text(
              "Contact",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          leading: Icon(
            Icons.account_circle,
            size: 38,
            color: Colors.green,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                GetTextFormField(
                  controller: conName,
                  hintName: "Numer",
                  iconData: Icons.person,
                  validator: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                GetTextFormField(
                  controller: conNumber,
                  hintName: "User ID",
                  iconData: Icons.call_outlined,
                  validator: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                GetTextFormField(
                  controller: conLocation,
                  hintName: "Location",
                  iconData: Icons.location_on_outlined,
                  validator: (value) {},
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          onPressed: ()=> 
                          addUser(conName.text, conNumber.text, conLocation.text),
                          child: Text("Add"),
                          color: Colors.black26,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: clearPage,
                          child: Text("Clear"),
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: ValueListenableBuilder(
                    valueListenable: Boxes.getUsers().listenable(),
                    builder: (BuildContext context, Box box, Widget? child) {
                      final users = box.values.toList().cast<UserModel>();

                      return getContent(users);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getContent(List<UserModel> user) {
  if (user.isEmpty) {
    return Center(
      child: Text(
        'No Users Found',
        style: TextStyle(fontSize: 15),
      ),
    );
  } else {
    return ListView.builder(
      itemCount: user.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          child: ExpansionTile(
            title: Text(
              "${user[index].user_name} (${user[index].location})",
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          subtitle: Text(user[index].user_number),
            trailing: Text(user[index].location),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit,color: Colors.blue),
                    label: Text(
                      "Edit",
                      style: TextStyle(
                       
                        color: Colors.blue,
                      ),
                      ),
                     ),
                       TextButton.icon(
                    onPressed:   () => deleteUser(user[index]),
                    icon: Icon(Icons.delete,  color: Colors.red,),
                    label: Text(
                      "Delete",
                      style: TextStyle(
                        
                        color: Colors.red,
                      ),
                      ),
                     ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

