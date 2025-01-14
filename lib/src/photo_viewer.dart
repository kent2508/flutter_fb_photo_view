import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_photo_view/src/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FBPhotoViewer extends StatefulWidget {
  const FBPhotoViewer({
    super.key,
    this.intialIndex = 0,
    this.assets = const [],
    this.imageFile,
    this.onPageChanged,
    this.customSubChild,
  });
  final List<String> assets;
  final File? imageFile;
  final int intialIndex;
  final Function(int)? onPageChanged;
  final List<Widget>? customSubChild;

  @override
  State<FBPhotoViewer> createState() => _FBPhotoViewerState();
}

class _FBPhotoViewerState extends State<FBPhotoViewer> {
  Completer<ImageInfo> completer = Completer();
  late ImageProvider imageProvider;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.intialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.multi,
      isFullScreen: false,
      child: Stack(
        children: [
          if (widget.assets.isNotEmpty)
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                final assetSource = widget.assets[index];
                final isNetworkAsset = assetSource.isNetworkSource;
                return PhotoViewGalleryPageOptions.customChild(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: PhotoView(
                      imageProvider: isNetworkAsset ? CachedNetworkImageProvider(assetSource) : AssetImage(assetSource),
                      minScale: PhotoViewComputedScale.contained,
                      initialScale: PhotoViewComputedScale.contained,
                      heroAttributes: PhotoViewHeroAttributes(tag: assetSource),
                    ),
                  ),
                );
              },
              itemCount: widget.assets.length,
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  // child: CircularProgressIndicator(
                  //   value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                  // ),
                  child: CupertinoActivityIndicator(color: Colors.white, radius: 10),
                ),
              ),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageController: pageController,
              onPageChanged: widget.onPageChanged,
            ),
          if (widget.assets.isEmpty && widget.imageFile != null)
            PhotoView(
              imageProvider: FileImage(widget.imageFile!),
              minScale: PhotoViewComputedScale.contained,
              initialScale: PhotoViewComputedScale.contained,
              heroAttributes: PhotoViewHeroAttributes(tag: widget.imageFile!.path),
            ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ),
          ...widget.customSubChild ?? [], // add custom sub-child for photo viewer
        ],
      ),
    );
  }
}
