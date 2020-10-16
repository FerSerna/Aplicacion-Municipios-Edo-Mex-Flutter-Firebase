import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/ConsultorPages/riesgosdesplay/desplayInundaciones.dart';

class SearchRiesgos extends StatefulWidget {
  @override
  _SearchRiesgos createState() => _SearchRiesgos();
}

class _SearchRiesgos extends State<SearchRiesgos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Riesgos del EdoMex"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/edomex.png')),
              SizedBox(height:50),
              Text("Selecciona una opción", style: Theme.of(context).textTheme.headline5),
              SizedBox(height:50),
              Column(
                children: [

                  Container(
                    alignment: Alignment(0.0,0.0),
                    child: 
                    MaterialButton(
                      child: Text("Inundaciones", style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por inundaciones"); 
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayInundaciones("Inundaciones"),));
                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment(0.0,0.0),
                    child: 
                    MaterialButton(
                      child: Text("Incendio Forestal", style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Incendios");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayInundaciones("Incendios"),));

                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment(0.0,0.0),
                    child: 
                    MaterialButton(
                      child: Text("Deslaves", style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Deslaves");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayInundaciones("Deslaves"),));

                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment(0.0,0.0),
                    child: 
                    MaterialButton(
                      child: Text("Zonas Sismicas", style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Zonas Sismica");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayInundaciones("Zona Sismica"),));

                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment(0.0,0.0),
                    child: 
                    MaterialButton(
                      child: Text("Zonas Volcanicas", style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Zonas Volcanicas");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayInundaciones("Zona Volcanica"),));

                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment(0.0,0.0),
                    child: 
                    MaterialButton(
                      child: Text("Derrumbes", style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Derrumbes");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayInundaciones("Derrumbes"),));
                        
                      },
                    ),
                  ),

                ],
              )
            ],
          ),
        ));
  }
}
