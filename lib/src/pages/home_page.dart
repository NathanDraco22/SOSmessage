import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_message/src/providers/contact_provider.dart';

import 'package:geolocator/geolocator.dart';
import 'package:sendsms/sendsms.dart';




class HomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    ContactProvider contactProvider = Provider.of<ContactProvider>(context);

    contactProvider.getContactPermission(context);

    


    return Scaffold(
      appBar: AppBar(
        title: Text("Mensaje de Emergencia"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings) , 
            onPressed: (){
              Navigator.pushNamed(context, "settings");
            }
          )
        ],
      ),
      body: Center(
        child: ClipRRect(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)
              )
            ),
            child: Container(
              child: Text("!", style: TextStyle(fontSize: 48),),
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),  
            ),
            onPressed: ()async{
              
              if (await Sendsms.hasPermission()){
                if (contactProvider.contactsInDB.isNotEmpty){

                  Position position = await getPosition();
                  String urlPos = "maps.google.com/?daddr=${position.latitude},${position.longitude}";

                  for (Map m in contactProvider.contactsInDB){
                    bool resp = await Sendsms.onSendSMS(m["number"], "SOS EMERGENCIA!!! \nUbicacion:\n$urlPos");
                    print(resp);
                 }
                  _showSnackBar(context, "Enviado", 800, Colors.green[700]);

                }else{
                  _showSnackBar(context, "Debes agregar al menos un contacto",2000, Colors.yellow[300]);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Position> getPosition ()  async {
    
    bool serviceLocation ;
    LocationPermission checkPermision;

    serviceLocation = await Geolocator.isLocationServiceEnabled();
    

    if ( !serviceLocation ){
      return Future.error("Desactivado el gps");
    }

    checkPermision = await Geolocator.checkPermission();

    if (checkPermision == LocationPermission.denied){
      checkPermision = await Geolocator.requestPermission();

    }
    if (checkPermision == LocationPermission.deniedForever){
      return Future.error("Permiso denegado");
    }

    return await Geolocator.getCurrentPosition();

    
  }


  void _showSnackBar (BuildContext context, String content, int duration, Color color){


    final Color colorFont = (color == Colors.yellow[300])?Colors.black:Colors.white;

    final SnackBar snack = SnackBar(
      content: Text(content, style: TextStyle(fontWeight: FontWeight.bold,color: colorFont)),
      backgroundColor: color,
      duration: Duration(milliseconds: duration),
    );


    ScaffoldMessenger.of(context).showSnackBar(snack);
  }


}

 