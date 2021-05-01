
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_message/src/providers/contact_provider.dart';
import 'package:sos_message/src/providers/database_provider.dart';

class SearchContact extends SearchDelegate{
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [Container()];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
    icon: Icon(Icons.arrow_left), 
    onPressed: (){
      close(context, null);
    }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final ContactProvider contactProvider = Provider.of<ContactProvider>(context);
    final List<String> names = contactProvider.names;

    final List<String>filterContact = (query.isEmpty)
                                      ?names
                                      :names.where((element) => element.toLowerCase().startsWith(query.toLowerCase())
                                      ).toList();
    
    return ListView.builder(
      itemCount: filterContact.length,
      itemBuilder: (context, i){
        final tempName    = filterContact[i];
        final tempNumber  = contactProvider.contacts[tempName];
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(radius: 10,backgroundColor: Colors.amberAccent,),
              title: Text(tempName),
              subtitle: Text(tempNumber),
              trailing: Icon(Icons.arrow_right),
              onTap: (){
                SingletonDB.db.insertContact(name: tempName, number: tempNumber);
                close(context, null);
              },
            ),
            Divider()
          ],
        ); 
      },
    );
  }

}