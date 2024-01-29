import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/components/cached_image_widget.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/screens/zoom_image_screen.dart';
import 'package:handyman_provider_flutter/utils/configs.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingGalleryScreen extends StatefulWidget {
  final List<String>? imageList;

  BookingGalleryScreen({this.imageList});

  @override
  _BookingGalleryScreenState createState() => _BookingGalleryScreenState();
}

class _BookingGalleryScreenState extends State<BookingGalleryScreen> {
  Future<void> init() async {}

  @override
  Widget build(BuildContext context) {
    if (widget.imageList!.isEmpty) return Text("No image");
    return Scaffold(
        appBar: appBarWidget(
          "Gallery",
          textColor: Colors.white,
          textSize: APP_BAR_TEXT_SIZE,
          color: primaryColor,
          systemUiOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness:
                  appStore.isDarkMode ? Brightness.light : Brightness.light,
              statusBarColor: context.primaryColor),
          showBack: Navigator.canPop(context),
          backWidget: BackWidget(),
        ),
        body: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: widget.imageList!.length,
            itemBuilder: (_, i) => GestureDetector(
                  onTap: () {
                    if (widget.imageList![i].isNotEmpty)
                      ZoomImageScreen(galleryImages: widget.imageList, index: i)
                          .launch(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(blurRadius: 16, color: Colors.black12)
                    ]),
                    child: CachedImageWidget(
                      url: widget.imageList![i].validate(),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      placeHolderImage: '',
                    ),
                  ),
                )));
  }
}
