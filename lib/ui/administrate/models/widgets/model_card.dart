import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/ui/administrate/models/administrate_models_controller.dart';

class ModelCard extends ConsumerWidget {
  const ModelCard({
    super.key,
    required this.model,
  });
  final Model model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(administrateModelsController);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFddeaf4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: -1
            )
          ]
        ),
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width *0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Marca: ${model.brand.brand}",
                    style: const TextStyle(
                      color: Color(0xFF3874c0)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Modelo: ${model.model}",
                    style: const TextStyle(
                      color: Color(0xFF3874c0)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('/add_edit_model', arguments: {
                    "model": model,
                  }).then((result) {
                    controller.getAllModels(context);
                  }),
                  icon: const Icon(Icons.edit),
                  iconSize: 30,
                  color: const Color(0xFF3874c0),
                ),
                IconButton(
                  onPressed: () => controller.deleteModel(context, model.id),
                  icon: const Icon(Icons.delete),
                  iconSize: 30,
                  color: const Color(0xFFb04d1e),
                )
              ],
              
            )
          ],
        ),
      ),
    );
  }
}