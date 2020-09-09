import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:provider/provider.dart';
import 'package:temas/src/theme/theme.dart';
import 'package:temas/src/widgets/pinterest_menu.dart';


class PinterestPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

  

    return ChangeNotifierProvider(
          create: (_)=> new _MenuModel(),
          child: Scaffold(
          body: Stack(
            children: [
              PinterestGrid(),
              _PinterestmenuLocation(),
            ]
        ),
   ),
    );
  }
}

class _PinterestmenuLocation extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final widthPantalla = MediaQuery.of(context).size.width;

    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Positioned(
      bottom: 30,
      child: Container(
        width: widthPantalla,
        child: Align(
          child: PinterestMenu(
            mostrar: mostrar,
            activeColor: (appTheme == ThemeData.dark()) ? appTheme.accentColor : Color(0xffc8232c),
            inactiveColor: Colors.blueGrey,
            backgroundColor: appTheme.scaffoldBackgroundColor,
            items: [
              PinterestButtom(icon: Icons.pie_chart, onPressed: (){print('piechart');}),
              PinterestButtom(icon: Icons.search, onPressed: (){print('search');}),
              PinterestButtom(icon: Icons.notifications, onPressed: (){print('notifications');}),
              PinterestButtom(icon: Icons.supervised_user_circle, onPressed: (){print('supervised');}),
            ],
          )
        ),
      )
      );
  }
}

class PinterestGrid extends StatefulWidget {

  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {


  final List<int> items = List.generate(200, (index) => index); 


  ScrollController controller = new ScrollController();
  double scrollAnterior=0;

  @override
  void initState() {
    
    controller.addListener(() {
      
      if (controller.offset > scrollAnterior && controller.offset > 150){
        
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;

      }

      scrollAnterior = controller.offset;

    });


    super.initState();
  }

  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StaggeredGridView.countBuilder(
      controller: controller,
        crossAxisCount: 4,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 3),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      );
  }
}

class _PinterestItem extends StatelessWidget {
  
  
  final int index;

  _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return new Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: (appTheme == ThemeData.dark()) ? Colors.white : Colors.blue[50],
          borderRadius: BorderRadius.all(Radius.circular(30.0))

        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: FadeInImage(
            image: NetworkImage('https://picsum.photos/200/300?random=$index'),
            placeholder: AssetImage('assets/svgs/preloader.gif'),
            fit: BoxFit.cover,
          ),
        ));
  }
}


class _MenuModel with ChangeNotifier {

  bool _mostrar = true;

  bool get mostrar => this._mostrar;

  set mostrar (bool valor){
    this._mostrar = valor;
    notifyListeners();
  }

}