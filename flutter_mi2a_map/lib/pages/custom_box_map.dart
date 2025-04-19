import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomBoxMap extends StatelessWidget {
  final String gambar, namaTempat, harga;
  final double rating;
  final VoidCallback onPressed;

  const CustomBoxMap({
    super.key,
    required this.gambar,
    required this.namaTempat,
    required this.rating,
    required this.harga,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 8)],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                gambar,
                width: 280,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                // nama tempat
                Text(
                  namaTempat,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
                // rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('$rating', style: TextStyle(fontSize: 10)),
                    SizedBox(width: 5),
                    RatingBarIndicator(
                      rating: rating,
                      itemBuilder:
                          (context, index) =>
                              Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 15,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
                // harga
                Text(
                  harga,
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[100],
                    foregroundColor: Colors.pink[100],
                  ),
                  onPressed: () {
                    onPressed.call();
                  },
                  child: Text('View', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
