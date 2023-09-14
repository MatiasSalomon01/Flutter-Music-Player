import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';
import '../services/services.dart';

class AddToPlaylistScreen extends StatelessWidget {
  const AddToPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songService = Provider.of<SongService>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Agregar a playlist',
          style: TextStyle(
            color: AppColors.background,
            fontWeight: FontWeight.w700,
          ),
        ),
        icon: Icons.arrow_back_outlined,
        showAction: false,
      ),
      backgroundColor: const Color(0xff121212),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              StadiumButton(
                text: 'Nueva playlist',
                textColor: black,
                buttonColor: white,
                borderColor: white,
                fontSize: 16,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 13,
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 25),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        scrollPadding: EdgeInsets.zero,
                        cursorColor: lightGreen,
                        style: const TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Buscar playlist',
                          hintStyle: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w600,
                          ),
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(Icons.search, color: white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          fillColor: Color(0xff232323),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(darkGrey.withOpacity(.5)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff232323)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                        splashFactory: NoSplash.splashFactory,
                        elevation: MaterialStateProperty.all(0),
                        shadowColor: MaterialStateProperty.all(transparent),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Ordenar',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: songService.playlists.length - 1,
                itemBuilder: (context, index) {
                  var newIndex = ++index;
                  return PlaylistListTile(
                    playlist: songService.playlists[newIndex],
                    index: newIndex,
                    isAddToPlaylist: true,
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(color: transparent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
