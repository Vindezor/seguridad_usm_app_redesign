import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/administrate/routes/administrate_routes_controller.dart';
import 'package:test_design/ui/administrate/routes/widgets/route_card.dart';

class AdministrateRoutesPage extends ConsumerWidget {
  const AdministrateRoutesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(administrateRoutesController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(controller.routes == null){
        controller.getAllRoutes(context);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/background.png"),
          //   fit: BoxFit.cover
          // )
        ),
        child:  controller.routes != null ? controller.routes!.isNotEmpty ? ListView(
          children: controller.routes!.map(
            (route) => RouteCard(
              id: route.id,
              departure: route.departure,
              arrival: route.arrival,
              route: route.route,
            )
          ).toList(),
        ) : const Center(
          child: Text(
            "No hay rutas registradas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ) : const SizedBox.shrink(),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black,
              spreadRadius: -5,
            )
          ]
        ),
        child: FloatingActionButton(
          onPressed: () => controller.goToAddRoute(context),
          backgroundColor: const Color(0xFFddeaf4),
          child: const Icon(Icons.add, color: Color(0xFF3874c0),),
        ),
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
          text: "Rutas",
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
      // bottomNavigationBar: const BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   color: Color(0xFF3874c0),
      //   // child: Row(
      //   //   children: [
      //   //     IconButton(
      //   //       tooltip: 'Open navigation menu',
      //   //       icon: const Icon(Icons.menu, color: Colors.white,),
      //   //       onPressed: () {},
      //   //     ),
      //   //     IconButton(
      //   //       tooltip: 'Open navigation menu',
      //   //       icon: const Icon(Icons.menu, color: Colors.white,),
      //   //       onPressed: () {},
      //   //     ),
      //   //     const Spacer(),
      //   //     IconButton(
      //   //       tooltip: 'Open navigation menu',
      //   //       icon: const Icon(Icons.menu, color: Colors.white,),
      //   //       onPressed: () {},
      //   //     ),
      //   //     IconButton(
      //   //       tooltip: 'Open navigation menu',
      //   //       icon: const Icon(Icons.menu, color: Colors.white,),
      //   //       onPressed: () {},
      //   //     ),
      //   //   ],
      //   // ),
      // ),
    );
  }
}