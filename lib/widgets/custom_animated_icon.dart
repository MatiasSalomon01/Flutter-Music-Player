import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/services/song_service.dart';
import 'package:provider/provider.dart';

class CustomAnimatedIcon extends StatefulWidget {
  bool isFavorite;
  final String id;
  CustomAnimatedIcon({
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

  @override
  void initState() {
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
        setState(() => widget.isFavorite = !widget.isFavorite);
        songService.updateById(widget.id, widget.isFavorite);
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: (_animationController.value + 1).clamp(1, 1.3),
            child: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: widget.isFavorite ? Colors.red : white,
            ),
          );
        },
      ),
    );
  }
}
