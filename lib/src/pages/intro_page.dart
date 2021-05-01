import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:sos_message/src/providers/preferences.dart';


class Intro extends StatefulWidget{


  @override
  IntroState createState() => new IntroState();

}

class IntroState extends State<Intro>{

  List<Slide> slides = [];

  @override
  void initState() { 
    super.initState();
    
    slides.add(
       Slide(
         title: "Bienvenido/a",
         backgroundColor: Colors.grey[900],
         description: "Flare Msg es una herramienta para enviar una alerta a tus contactos de confianza",
         centerWidget: Icon(Icons.sms_failed, size: 96.0, color: Colors.redAccent)
       )
    );
    slides.add(
      Slide(
        title: "Intro",
        backgroundColor: Colors.grey[800],
        description: "Flare Msg enviara un SMS con tu ubicacion actual, hacia los contactos que tengas seleccionados en la configuracion de la app.",
        centerWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mark_chat_unread,size: 96.0,color: Colors.amberAccent,),
            Icon(Icons.location_on, size: 96.0,color:  Colors.red[400],)

        ],)
      )
    );

    slides.add(
      Slide(
        backgroundColor: Colors.grey[900],
        title: "Instrucciones",
        centerWidget: Column(
          children: [
            Icon(Icons.settings,size: 96.0, color: Colors.greenAccent)
          ],
        ),
        description: "1) Acepta los permisos (SMS, Contactos, Ubicación). \n\n2) Ve a configuraciones y agrega tus contactos de confianza. \n\n3) Para enviar tu alerta presiona el boton rojo de la pantalla inicial."

      )
    );

    slides.add(
      Slide(
        backgroundColor: Colors.grey[800],
        title: "Info!",
        centerWidget: Icon(Icons.live_help,size: 96.0, color: Colors.amberAccent),
        description: "Flare Msg no requiere de acceso a internet pero si del servicio de SMS y de Ubicación, asegúrate siempre tener algunos SMS de reserva y tu Ubicación activa.\n\nFlare Msg no recolecta ni comparte información con terceros, requiere de los permisos únicamente para su funcionamiento.\n\nGracias por tu Descarga :)"
      )
      
    );
  }

  void onPressed(){

    //Static INstances from Shared PReferences
    final Preferences pref = new Preferences();
    pref.firstInApp = false;
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onPressed,
    );
  }


}