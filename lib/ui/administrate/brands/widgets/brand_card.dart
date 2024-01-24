import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/ui/administrate/brands/administrate_brands_controller.dart';

class BrandCard extends ConsumerWidget {
  const BrandCard({
    super.key,
    required this.id,
    required this.brand,
  });
  final String brand;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(administrateBrandsController);
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
                    "Marca: $brand",
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
                  onPressed: () => Navigator.of(context).pushNamed('/add_edit_brand', arguments: {
                    "id": id,
                    "brand": brand,
                  }).then((result) {
                    controller.getAllBrands(context);
                  }),
                  icon: const Icon(Icons.edit),
                  iconSize: 30,
                  color: const Color(0xFF3874c0),
                ),
                IconButton(
                  onPressed: () => controller.deleteBrand(context, id),
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