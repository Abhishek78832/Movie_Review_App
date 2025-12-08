import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../ui_helper/api_helper.dart';
import '../../ui_helper/db_helper.dart';
import '../../ui_helper/movies_api.dart';


class DetailScreen extends StatefulWidget {
  final Movie info;
  const DetailScreen({super.key, required this.info});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  YoutubePlayerController? ytController;
  bool isPlaying = true;
  bool isAdded = false;
  var db = DbHelper();

  @override
  void initState() {
    super.initState();
    loadVideo();
  }

  Future<void> loadVideo() async {
    try {
      final videos = await fetchMovieVideos(movieId: widget.info.id!);
      String? videoKey = videos.isNotEmpty ? videos[0].key : null;

      if (videoKey != null) {
        ytController = YoutubePlayerController(
          initialVideoId: videoKey,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            hideControls: true,
            controlsVisibleAtStart: false,
            disableDragSeek: true,
            enableCaption: false,
            showLiveFullscreenButton: false,
          ),
        );
        setState(() {});
      }
    } catch (e) {
      debugPrint("Error loading video: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(height: double.infinity, width: double.infinity),

          // --- YouTube Trailer Section ---
          SizedBox(
            height: 280,
            width: double.infinity,
            child: ytController != null
                ? Stack(
              children: [
                YoutubePlayer(
                  controller: ytController!,
                  showVideoProgressIndicator: true,
                  bottomActions: const [],
                  onReady: () => ytController!.play(),
                ),
                Positioned.fill(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (isPlaying) {
                          ytController!.pause();
                        } else {
                          ytController!.play();
                        }
                        setState(() => isPlaying = !isPlaying);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
                : Image.network(
              "https://image.tmdb.org/t/p/w500${widget.info.posterPath!}",
              fit: BoxFit.cover,
            ),
          ),

          // --- Movie Details Section ---
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // --- Title Row ---
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              widget.info.title ?? "Unknown Title",
                              style: const TextStyle(
                                fontFamily: "Dongle",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            isAdded ? Icons.bookmark : Icons.bookmark_outline,
                            size: 30,
                            color: Colors.black,
                          ),
                          onTap: () async {
                            if (widget.info.posterPath == null || widget.info.title == null) return;

                            setState(() => isAdded = !isAdded);

                            await db.addBookmark(
                              thumbnailUrl: "https://image.tmdb.org/t/p/w500/${widget.info.posterPath}",
                              name: widget.info.title!,
                              id : widget.info.id,
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),

                    // --- Ratings Row ---
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Icon(Icons.star, color: Colors.amber, size: 30),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${widget.info.voteAverage?.toStringAsFixed(1) ?? 'N/A'}/10 IMDB",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: "Dongle",
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.percent, color: Colors.green),
                        const SizedBox(width: 10),
                        Text(
                          "${(widget.info.voteAverage ?? 0) * 10}",
                          style: const TextStyle(
                            fontFamily: "Dongle",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 25),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // --- Release Date ---
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            "Release Date : ${widget.info.releaseDate ?? 'N/A'}",
                            style: const TextStyle(
                              fontFamily: "Dongle",
                              fontSize: 25,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // --- Description ---
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        widget.info.overview ?? "No description available.",
                        style: const TextStyle(
                          fontFamily: "Dongle",
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
