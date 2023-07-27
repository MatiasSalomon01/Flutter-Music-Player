import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/services/song_service.dart';
import 'package:provider/provider.dart';

class CustomAnimatedIcon extends StatefulWidget {
  final bool isFavorite;
  final String id;
  const CustomAnimatedIcon({
    super.key,
    required this.isFavorite,
    required this.id,
  });

  @override
  State<CustomAnimatedIcon> createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = widget.isFavorite;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songService = Provider.of<SongService>(context);

    return GestureDetector(
      onTap: () {
        _animationController
            .forward()
            .whenComplete(() => _animationController.reverse());
        setState(() => isFavorite = !isFavorite);
        songService.updateById(widget.id, isFavorite);
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: (_animationController.value + 1).clamp(1, 1.3),
            child: Icon(
              _animationController.isAnimating || isFavorite
                  ? Icons.favorite
                  : Icons.favorite_outline,
              color: _animationController.isAnimating || isFavorite
                  ? Colors.red
                  : white,
            ),
          );
        },
      ),
    );
  }
}
