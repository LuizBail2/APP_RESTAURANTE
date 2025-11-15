import 'package:flutter/material.dart';
import '../../models/restaurant.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String name;
  final String address;
  final double rating;
  final List<MenuItem> menu;
  final String openingHours;
  final String closingHours;
  final String weekendOpening;
  final String weekendClosing;

  const RestaurantDetailScreen({
    super.key,
    required this.name,
    required this.address,
    required this.rating,
    required this.menu,
    required this.openingHours,
    required this.closingHours,
    required this.weekendOpening,
    required this.weekendClosing,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.orange.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome e endereço
            Text(
              name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.redAccent),
                const SizedBox(width: 8),
                Expanded(child: Text(address)),
              ],
            ),
            const SizedBox(height: 20),

            // Nota
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 28),
                const SizedBox(width: 6),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(),

            //horário de funcionamento
            Row(
              children: const [
                Icon(Icons.access_time, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Horário de Funcionamento',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Segunda a Sexta: $openingHours às $closingHours'),
            Text('Sábado e Domingo: $weekendOpening às $weekendClosing'),

            const SizedBox(height: 30),
            const Divider(),

            //cardápio
            Row(
              children: const [
                Icon(Icons.restaurant_menu, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Cardápio',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            //lista dos pratos
            ...menu.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
