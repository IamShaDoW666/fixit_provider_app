import 'package:handyman_provider_flutter/components/cached_image_widget.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/screens/booking_gallery_screen.dart';
import 'package:handyman_provider_flutter/screens/zoom_image_screen.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingDetailImageComponent extends StatefulWidget {
  final List<String>? imageList;

  BookingDetailImageComponent({this.imageList});

  @override
  BookingDetailImageComponentState createState() =>
      BookingDetailImageComponentState();
}

class BookingDetailImageComponentState
    extends State<BookingDetailImageComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageList.validate().isEmpty) return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Row(children: [
          Text("Gallery", style: boldTextStyle(size: LABEL_TEXT_SIZE)),
          GestureDetector(
            onTap: () {
              BookingGalleryScreen(
                imageList: widget.imageList,
              ).launch(context,
                  pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
            },
            child: Text("View all", style: primaryTextStyle(size: 14)),
          )
        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
        16.height,
        HorizontalList(
          itemCount: widget.imageList.validate().length,
          padding: EdgeInsets.only(left: 16, right: 16),
          runSpacing: 8,
          spacing: 12,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {
                if (widget.imageList![i].isNotEmpty)
                  ZoomImageScreen(galleryImages: widget.imageList, index: i)
                      .launch(context);
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: appStore.isDarkMode
                        ? Colors.white24
                        : context.cardColor,
                    shape: BoxShape.circle),
                child: CachedImageWidget(
                  url: widget.imageList![i].validate(),
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  circle: true,
                  placeHolderImage: '',
                ),
              ),
            );
          },
        ),
        16.height,
      ],
    );
  }
}
