import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
// import 'package:image_downloader/image_downloader.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imagePath;

  const ImageViewerScreen(this.imagePath, {super.key});

  Future<void> downloadImage(String url) async {
    try {
      // await ImageDownloader.downloadImage(url);
    } catch (error) {
      print('Error downloading image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              final imageUrl = 'https://image.tmdb.org/t/p/w500/$imagePath';
              downloadImage(imageUrl);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading image...')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: InstaImageViewer(
          child: Image.network(
            'https://image.tmdb.org/t/p/w500/$imagePath',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
