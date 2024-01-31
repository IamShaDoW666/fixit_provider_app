import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class OptionSearch extends StatelessWidget {
  const OptionSearch({
    super.key,
    required this.searchList,
  });

  final TextEditingController searchList;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      textFieldType: TextFieldType.OTHER,
      controller: searchList,
      onFieldSubmitted: (s) {},
      decoration: InputDecoration(
        hintText: languages.lblSearchHere,
        prefixIcon: Icon(Icons.search, color: context.iconColor, size: 20),
        hintStyle: secondaryTextStyle(),
        border: OutlineInputBorder(
            borderRadius: radius(8),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        contentPadding: EdgeInsets.all(16),
        fillColor: appStore.isDarkMode ? cardDarkColor : cardColor,
      ),
    );
  }
}
