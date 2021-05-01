import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_message/src/providers/contact_provider.dart';
import 'package:sos_message/src/providers/database_provider.dart';
import 'package:sos_message/src/search/search_delegate.dart';






class SetPage extends StatefulWidget{

  @override
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {



  @override
  Widget build(BuildContext context) {
    final ContactProvider contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Configuraciones"),),
      floatingActionButton: 
      FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.contact_page),
        onPressed: (){
          showSearch(context: context, delegate: SearchContact()).then((value) {setState(() {}
          );});
        },
      ),
      body: FutureBuilder(
        future: contactProvider.getContactsInDB(),
        builder: ( _ , snap){
          return Column(children: [
        Text("Mis Contactos S.O.S.", style: TextStyle(fontSize: 24.0),),
        Expanded(
          child: MyContactSOS()
        )
        ],
      );
      }
      )
    );
  }

  void tema({m,ss}){
    print("");
  }
}



class MyContactSOS extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    final ContactProvider contactProvider = Provider.of<ContactProvider>(context);
    final contactsInDB = contactProvider.contactsInDB;

    return ListView.builder(
      itemCount: contactsInDB.length,
      itemBuilder: ( _ , i ){

        return Column(children: [
          ListTile(
            title: Text(contactsInDB[i]["name"]),
            subtitle: Text(contactsInDB[i]["number"]),
            leading: CircleAvatar(backgroundColor: Colors.green,radius: 10.0,),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                SingletonDB.db.deleteinDB(contactsInDB[i]["name"]);
                contactProvider.setNotifierList();

              },
              ),
          ),
          Divider()
        ],);
      
      }
    );
  }
}