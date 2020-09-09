
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temas/src/theme/theme.dart';
import 'package:temas/src/widgets/radial_progress.dart';

class GraficasCircularesPage extends StatefulWidget {

  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  
  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appTheme.accentColor,
        child: Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            porcentaje += 10;
            if(porcentaje > 100){
              porcentaje = 0;
            }
          });
        }
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.indigo,),
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.lightBlue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.pink),
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.green),
            ],
          )
        ],
      )
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  const CustomRadialProgress({
    @required this.porcentaje, 
    @required this.color,
  });
  final double porcentaje;
  final Color color;

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    
    return Container(
      width: 180,
      height: 180,
      child: Stack(
              children: <Widget>[
                RadialProgress(
                porcentaje: porcentaje,
                colorPrimario: color,
                colorSecundario: appTheme.textTheme.bodyText1.color,
                grosorPrimario: 10.0,
                grosorSecundario: 4.0,
                ),
                Center(
                  child: Text(
                    '${porcentaje.toInt().toString()}%',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: color
                    ),
                    )
                )

              ],
      ),
    );
  }
}