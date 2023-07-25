import 'package:flutter/material.dart';

class AlbumImage extends StatelessWidget {
  const AlbumImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      margin: const EdgeInsets.only(top: 70),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(-7, 7),
            color: Colors.black87,
            blurRadius: 15,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: const Image(
          image: AssetImage('assets/acdc.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
