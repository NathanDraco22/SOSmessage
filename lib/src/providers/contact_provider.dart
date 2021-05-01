
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';

import 'package:sos_message/src/providers/database_provider.dart';


class ContactProvider extends ChangeNotifier{

  Map<String,String> contacts = {};
  List<String> names = [];
  List<Map<String,dynamic>> contactsInDB =[];

  Future getAllContacts() async {

      Iterable<Contact>allContacts = await ContactsService.getContacts(withThumbnails: false);

      for (Contact c in allContacts){
        if ( c.phones.length > 0 ){
          contacts[c.displayName] = c.phones.first.value;
          names.add(c.displayName);
        }
      }

      names = names.toSet().toList();

      await getContactsInDB();

    
  }

   Future getContactsInDB()async{
    contactsInDB = await SingletonDB.db.getAllContacts();
     if (contactsInDB.isNotEmpty){

        for ( Map m in contactsInDB ){

          names.remove(m["name"]);
      
      }

    }
  }

  Future<bool> getContactPermission (BuildContext context)async {
    final permission = EasyPermissionValidator(
    context: context,
    appName: 'SOS message');

    final contactPermission = await permission.contacts();

    if (contactPermission){
      getAllContacts();
    }

    await permission.sms();

    await permission.location();

    

    return contactPermission;

  }

  void setNotifierList(){
    notifyListeners();
  }



}