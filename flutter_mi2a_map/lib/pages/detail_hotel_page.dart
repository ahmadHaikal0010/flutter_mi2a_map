import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailHotelPage extends StatelessWidget {
  final Map<String, dynamic> hotelData;
  const DetailHotelPage({super.key, required this.hotelData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hotelData['namaTempat'])),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  hotelData['gambar'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                hotelData['namaTempat'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Rating: ${hotelData['rating']}'),
                  SizedBox(width: 5),
                  RatingBarIndicator(
                    rating: hotelData['rating'],
                    itemBuilder:
                        (context, index) =>
                            Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 15,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Harga: ${hotelData['harga']}',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              SizedBox(height: 16),
              Text(
                'Detail: ${hotelData['keterangan']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
