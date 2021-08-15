import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  static const String route = 'ImageViewer';
  final String imageUrl;

  const ImageViewer({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              _buildImageViewer(),
              _buildCloseButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageViewer() {
    return InteractiveViewer(
      scaleEnabled: true,
      panEnabled: true,
      boundaryMargin: EdgeInsets.all(100),
      minScale: 0.5,
      maxScale: 2,
      child: Container(
        height: double.infinity,
        child: Center(
          child: Hero(
            tag: 'imageViewer',
            child: Image.network(
              imageUrl,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      right: 10,
      child: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.grey,
          size: 30,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
