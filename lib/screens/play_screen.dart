import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/widgets/widgets.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 220,
              width: 220,
              margin: const EdgeInsets.symmetric(vertical: 100),
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
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let There Be Rock',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'AC/DC',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.shuffle_outlined, size: 25),
                  Icon(Icons.folder_open_outlined, size: 25),
                  Icon(Icons.download, size: 25),
                  Icon(Icons.repeat, size: 25),
                  Icon(Icons.favorite_outline, size: 25),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  const Text('01:30', style: TextStyle(color: Colors.grey)),
                  Expanded(
                    child: Slider(
                      activeColor: AppColors.barColor,
                      inactiveColor: Colors.black26,
                      value: 0.6,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  const Text('04:05', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous, size: 35),
                    splashRadius: 24,
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 35,
                      ),
                      splashRadius: .1,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next, size: 35),
                    splashRadius: 24,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
