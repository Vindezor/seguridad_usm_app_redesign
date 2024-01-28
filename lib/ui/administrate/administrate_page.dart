import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/routes/routes.dart';
import 'package:test_design/ui/home/home_controller.dart';
import 'package:test_design/ui/home/widgets/button_home.dart';

class AdministratePage extends ConsumerWidget {
  const AdministratePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeControllerRef = ref.watch(homeController);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonHome(
                icon: Icons.map,
                text: "Rutas",
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.administrateRoutes);
                },
              ),
              ButtonHome(
                icon: Icons.person,
                text: "Conductores",
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.administrateDrivers);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonHome(
                icon: Icons.pin_drop,
                text: "Paradas",
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.administrateStops);
                },
              ),
              ButtonHome(
                icon: Icons.directions_subway,
                text: "Unidades",
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.administrateUnits);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonHome(
                icon: Icons.pin_drop,
                text: "Marcas",
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.administrateBrands);
                },
              ),
              ButtonHome(
                icon: Icons.directions_subway,
                text: "Modelos",
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.administrateModels);
                },
              ),
            ],
          ),
          (homeControllerRef.idTypeUser != null) ? (homeControllerRef.idTypeUser! == 4) ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonHome(
                icon: Icons.badge,
                text: "Administradores",
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.administrateAdmins);
                },
              ),
            ],
          ) : const SizedBox.shrink() : const SizedBox.shrink(),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const DecoratedIcon(
            icon: Icon(Icons.arrow_back, color: Color(0xFF3874c0), size: 30,),
            decoration: IconDecoration(
              border: IconBorder(
                color: Colors.white,
                width: 3
              )
            )
          ),
        ),
        title: const StrokeText(
          text: "Administrar",
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Color(0xFF3874c0),
          ),
          strokeColor: Colors.white,
          strokeWidth: 3,
        ),
        flexibleSpace: Image.asset(
          "assets/parte-top.png",
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}