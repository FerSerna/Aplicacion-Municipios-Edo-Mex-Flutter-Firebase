import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoedomex/AdminActions/riesgosList/desplayDerrumbes.dart';
import 'package:infoedomex/AdminActions/riesgosList/desplayDeslaves.dart';
import 'package:infoedomex/AdminActions/riesgosList/desplayIncendios.dart';
import 'package:infoedomex/AdminActions/riesgosList/desplayInundaciones.dart';
import 'package:infoedomex/AdminActions/riesgosList/desplayZonaSismica.dart';
import 'package:infoedomex/AdminActions/riesgosList/desplayZonaVolcanica.dart';


class SearchRiesgos extends StatefulWidget {
  @override
  _SearchRiesgos createState() => _SearchRiesgos();
}

class _SearchRiesgos extends State<SearchRiesgos> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title: Text('Búsqueda'),
                centerTitle: true,
              ),
              SizedBox(height: 50),
              Text("Selecciona una opción",
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 50),
              Column(
                children: [
                  Container(
                    alignment: Alignment(0.0, 0.0),
                    child: MaterialButton(
                      child: Text("Inundaciones",
                          style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por inundaciones");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DesplayInundaciones("Inundaciones"),
                        ));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment(0.0, 0.0),
                    child: MaterialButton(
                      child: Text("Incendio Forestal",
                          style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Incendios");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayIncendios("Incendios"),
                        ));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment(0.0, 0.0),
                    child: MaterialButton(
                      child: Text("Deslaves",
                          style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Deslaves");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayDeslaves("Deslaves"),
                        ));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment(0.0, 0.0),
                    child: MaterialButton(
                      child: Text("Zonas Sismicas",
                          style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Zonas Sismica");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DesplayZonaSismica("Zona Sismica"),
                        ));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment(0.0, 0.0),
                    child: MaterialButton(
                      child: Text("Zonas Volcanicas",
                          style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Zonas Volcanicas");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DesplayZonaVolcanica("Zona Volcanica"),
                        ));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment(0.0, 0.0),
                    child: MaterialButton(
                      child: Text("Derrumbes",
                          style: Theme.of(context).textTheme.headline6),
                      color: Colors.amber,
                      minWidth: 350,
                      onPressed: () {
                        print("Buscar por Derrumbes");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DesplayDerrumbes("Derrumbes"),
                        ));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
