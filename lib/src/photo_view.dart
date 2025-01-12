import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_photo_view/src/photo_viewer.dart';
import 'package:flutter_fb_photo_view/src/utils.dart';
import 'package:gap/gap.dart';

import 'constants.dart';

class FBPhotoView extends StatefulWidget {
  const FBPhotoView({
    super.key,
    required this.dataSource,
    this.thumbnailSource,
    this.height,
    this.customSubChild,
    this.displayType = FBPhotoViewType.list,
    this.onPageChanged,
    this.onStartDisplay,
    this.fit = BoxFit.cover,
  });

  final List<String> dataSource;
  final List<String>? thumbnailSource;
  final double? height;
  final List<Widget>? customSubChild;
  final FBPhotoViewType displayType;
  final Function(int)? onPageChanged;
  final Function(int)? onStartDisplay;
  final BoxFit fit;

  @override
  State<FBPhotoView> createState() => _FBPhotoViewState();

  static displayImage(BuildContext context, List<String> dataSource, {int displayIndex = 0, List<Widget>? customSubChild, Function(int)? onPageChanged}) {
    context.pushTransparentRoute(FBPhotoViewer(
      intialIndex: displayIndex,
      assets: dataSource,
      customSubChild: customSubChild,
      onPageChanged: onPageChanged,
    ));
  }
}

class _FBPhotoViewState extends State<FBPhotoView> {
  int _currentIndex = 0;
  List<String> dataSource = [];
  late FBPhotoViewType displayType;
  late CarouselSliderController carouselController;

  @override
  void initState() {
    displayType = widget.displayType;
    dataSource = widget.dataSource;
    if (displayType == FBPhotoViewType.list) {
      carouselController = CarouselSliderController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (displayType) {
      case FBPhotoViewType.grid3:
        return grid3();
      case FBPhotoViewType.grid4:
        return grid4();
      case FBPhotoViewType.grid5:
        return grid5();
      default:
        // default display type: FBPhotoViewType.list
        return carousel();
    }
  }

  Widget emptyContainer({double defaultHeight = 300.0}) => Container(
        color: Colors.white,
        height: widget.height ?? defaultHeight,
        child: Center(
          child: Text(
            'No image found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
          ),
        ),
      );

  List<Widget> moreAssetCover(int numberOfAsset) {
    return [
      IgnorePointer(
        ignoring: true,
        child: Container(
          color: Colors.black.withAlpha((0.5 * 255.0).toInt()),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: IgnorePointer(
          ignoring: true,
          child: Text(
            '+$numberOfAsset',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
        ),
      ),
    ];
  }

  Widget grid3() {
    final assetCount = dataSource.length;
    if (assetCount == 0) {
      return emptyContainer();
    }
    return Container(
      color: Colors.white,
      height: widget.height ?? 300.0,
      child: Row(
        children: [
          Expanded(flex: assetCount == 2 ? 1 : 3, child: imageTileAtIndex(0)),
          if (assetCount > 1) ...[
            const Gap(4.0),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(child: imageTileAtIndex(1)),
                  if (assetCount > 2) const Gap(4.0),
                  if (assetCount > 2)
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(top: 0, left: 0, right: 0, bottom: 0, child: imageTileAtIndex(2)),
                          if (assetCount > 3) ...moreAssetCover(assetCount - 3),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget grid4() {
    final assetCount = dataSource.length;
    if (assetCount == 0) {
      return emptyContainer();
    }
    return Container(
      color: Colors.white,
      height: widget.height ?? 300.0,
      child: Column(
        children: [
          Expanded(flex: assetCount == 2 ? 1 : 3, child: imageTileAtIndex(0, imageWidth: double.infinity)),
          if (assetCount > 1) ...[
            const Gap(4.0),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(child: imageTileAtIndex(1)),
                  if (assetCount > 2) const Gap(4.0),
                  if (assetCount > 2) Expanded(child: imageTileAtIndex(2)),
                  if (assetCount > 3) const Gap(4.0),
                  if (assetCount > 3)
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(top: 0, left: 0, right: 0, bottom: 0, child: imageTileAtIndex(3)),
                          if (assetCount > 4) ...moreAssetCover(assetCount - 4),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget grid5() {
    final assetCount = dataSource.length;
    if (assetCount == 0) {
      return emptyContainer();
    }
    return Container(
      color: Colors.white,
      height: widget.height ?? 300.0,
      child: Row(
        children: [
          Expanded(
              flex: assetCount == 2 ? 1 : 3,
              child: Column(
                children: [
                  Expanded(child: imageTileAtIndex(0, imageWidth: double.infinity)),
                  if (assetCount > 1) const Gap(4.0),
                  if (assetCount > 1) Expanded(child: imageTileAtIndex(1, imageWidth: double.infinity)),
                ],
              )),
          if (assetCount > 2) ...[
            const Gap(4.0),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(child: imageTileAtIndex(2)),
                  if (assetCount > 3) const Gap(4.0),
                  if (assetCount > 3) Expanded(child: imageTileAtIndex(3)),
                  if (assetCount > 4) const Gap(4.0),
                  if (assetCount > 4)
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(top: 0, left: 0, right: 0, bottom: 0, child: imageTileAtIndex(4)),
                          if (assetCount > 5) ...moreAssetCover(assetCount - 5),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget carousel() {
    final assetCount = dataSource.length;
    if (assetCount == 0) {
      return emptyContainer(defaultHeight: 200.0);
    }
    return Container(
      color: Colors.transparent,
      child: CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          height: widget.height ?? 200.0, // default 200.0
          onPageChanged: (index, reason) {
            _currentIndex = index;
          },
        ),
        items: dataSource.map((assetSource) => imageTile(assetSource, usingCarousel: true)).toList(),
      ),
    );
  }

  Widget imageTileAtIndex(int index, {double? imageWidth}) {
    return imageTile(
      dataSource[index],
      thumbnailSource: ((widget.thumbnailSource?.length ?? 0) > index) ? widget.thumbnailSource![index] : null,
      index: index,
      imageWidth: imageWidth,
    );
  }

  Widget imageTile(
    String assetSource, {
    String? thumbnailSource,
    int? index,
    bool usingCarousel = false,
    double? imageWidth,
    double? imageHeight,
  }) {
    return GestureDetector(
      onTap: () {
        widget.onStartDisplay?.call(index ?? 0);
        // Use extension method to use [TransparentRoute]
        // This will push page without route background
        _currentIndex = dataSource.indexOf(assetSource);
        if (usingCarousel) {
          carouselController.animateToPage(_currentIndex);
        }
        context.pushTransparentRoute(FBPhotoViewer(
          intialIndex: _currentIndex,
          assets: dataSource,
          customSubChild: widget.customSubChild,
          onPageChanged: (index) {
            if (usingCarousel) {
              _currentIndex = index;
              carouselController.animateToPage(_currentIndex);
            }
            widget.onPageChanged?.call(index);
          },
        ));
      },
      child: usingCarousel
          ? Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: renderImage(assetSource, thumbnailSource: thumbnailSource, fit: widget.fit, imageWidth: imageWidth, imageHeight: imageHeight),
            )
          : renderImage(assetSource, thumbnailSource: thumbnailSource, fit: widget.fit, imageWidth: imageWidth, imageHeight: imageHeight),
    );
  }

  Widget renderImage(
    String assetSource, {
    String? thumbnailSource,
    BoxFit fit = BoxFit.cover,
    double? imageWidth,
    double? imageHeight,
  }) {
    final isNetworkAsset = assetSource.isNetworkSource;
    return Hero(
      tag: assetSource,
      child: isNetworkAsset
          ? CachedNetworkImage(
              imageUrl: thumbnailSource ?? assetSource,
              fit: fit,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
              width: imageWidth,
              height: imageHeight,
            )
          : Image.asset(thumbnailSource ?? assetSource, fit: fit, width: imageWidth, height: imageHeight),
    );
  }
}
