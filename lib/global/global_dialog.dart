import 'package:flutter/material.dart';

void showAlertOptions(
  BuildContext context, {
  required String msg,
  required String title,
  void Function()? acceptOnPressed,
  void Function()? cancelOnPressed,
  void Function()? closeOnPressed,
  bool justified = false,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF3874c0)),
          ),
          content: Text(
            msg,
            style: const TextStyle(
              fontSize: 15,
            ),
            textAlign: justified ? TextAlign.justify : TextAlign.left,
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: (acceptOnPressed != null || cancelOnPressed != null)
          ? [ ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFefdbd2))
                ),
                onPressed: (cancelOnPressed != null) ? cancelOnPressed : () => Navigator.of(context).pop(),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFFb04d1e),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                ),
                onPressed: (acceptOnPressed != null) ? acceptOnPressed : () => Navigator.of(context).pop(),
                child: const Text(
                  "Aceptar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
          ]
          : [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
              ),
              onPressed: (closeOnPressed != null) ? closeOnPressed : () => Navigator.of(context).pop(),
              child: const Text(
                "Cerrar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ]
        ),
      );
    },
  );
}
