import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/history/widgets/history_item.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/background.png"),
          //   fit: BoxFit.cover
          // )
        ),
        child: ListView(
          children: const [
            HistoryItem(),
            HistoryItem(),
            HistoryItem(),
            HistoryItem()
          ],
        )
      ),
      // floatingActionButtonLocation: fabLocation,
      // floatingActionButton: Container(
      //   decoration: const BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 30,
      //         color: Colors.black,
      //         spreadRadius: -5,
      //       )
      //     ]
      //   ),
      //   child: FloatingActionButton.large(
      //     onPressed: () => {},
      //     backgroundColor: const Color(0xFFddeaf4),
      //     child: const Icon(
      //       Icons.qr_code_scanner,
      //       color: Color(0xFF3874c0),
      //       size: 40,
      //       weight: 0.5,
      //     ),
      //   ),
      // ),
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
          text: "Historial",
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