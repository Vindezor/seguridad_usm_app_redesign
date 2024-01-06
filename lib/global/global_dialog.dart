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
          title: Text(
            title,
            textAlign: TextAlign.center,
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
          ? [ (cancelOnPressed != null)
                ? TextButton(
                  onPressed: cancelOnPressed,
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : const SizedBox.shrink(),
              (acceptOnPressed != null)
                ? TextButton(
                  onPressed: acceptOnPressed,
                  child: const Text(
                    "Aceptar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : const SizedBox.shrink(),
          ]
          : [
            TextButton(
              onPressed: (closeOnPressed != null) ? closeOnPressed : () => Navigator.of(context).pop(),
              child: const Text(
                "Cerrar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                //style: TextStyle(color: Colors.black),
              ),
            ),
          ]
        ),
      );
    },
  );
}
