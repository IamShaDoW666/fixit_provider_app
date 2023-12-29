import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/models/option_model.dart';
import 'package:handyman_provider_flutter/models/service_model.dart';
import 'package:handyman_provider_flutter/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/option_search.dart';

class OptionListScreen extends StatefulWidget {
  final ServiceData? service;
  OptionListScreen({Key? key, required this.service}) : super(key: key);

  @override
  _OptionListScreenState createState() => _OptionListScreenState();
}

class _OptionListScreenState extends State<OptionListScreen> {
  TextEditingController searchList = TextEditingController();

  List<Option>? searchItems(String? query) {
    setState(() {});
    if (query == null) {
      return widget.service!.options;
    }
    query = query.toLowerCase();
    return widget.service!.options!
        .where((element) => element.name!.toLowerCase().contains(query!))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Options",
          textColor: white,
          color: context.primaryColor,
          backWidget: BackWidget(),
          actions: [
            IconButton(
              onPressed: () async {},
              icon: Icon(Icons.add, size: 28, color: white),
              tooltip: 'Add Option',
            ),
          ]),
      body: AnimatedScrollView(children: [
        if (widget.service!.options!.isNotEmpty)
          OptionSearch(searchList: searchList)
              .paddingOnly(left: 16, right: 16, top: 24, bottom: 8),
        if (widget.service!.options!.isEmpty)
          Center(
            child: Text("No Options Available"),
          ).paddingAll(32),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: AnimatedWrap(
            spacing: 16.0,
            runSpacing: 16.0,
            scaleConfiguration: ScaleConfiguration(
                duration: 400.milliseconds, delay: 50.milliseconds),
            listAnimationType: ListAnimationType.FadeIn,
            fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
            alignment: WrapAlignment.start,
            itemCount: widget.service!.options!.length,
            itemBuilder: (context, index) {
              return AppButton(
                text: widget.service!.options![index].name.validate(),
                textStyle: boldTextStyle(color: primaryColor),
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: primaryColor)),
                onTap: () {},
              );
            },
          ),
        )
      ]),
    );
  }
}
