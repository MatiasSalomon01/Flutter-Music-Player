import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';

Future showPlaylistModal(
  BuildContext context, {
  Widget header = const SizedBox(height: 10),
  double height = 500,
  Widget child = const SizedBox(),
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: transparent,
    builder: (context) => Container(
      height: height,
      decoration: const BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 40,
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(25),
                right: Radius.circular(25),
              ),
            ),
          ),
          header,
          const Divider(color: white, thickness: .1),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: child,
          ),
        ],
      ),
    ),
  );
}
