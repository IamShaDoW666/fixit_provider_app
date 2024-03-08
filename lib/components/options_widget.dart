import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/booking_list_response.dart';
import 'package:handyman_provider_flutter/models/booking_option.dart';
import 'package:nb_utils/nb_utils.dart';
import '../models/service_model.dart';

class OptionsWidget extends StatelessWidget {
  final ServiceData? serviceData;
  final BookingData? bookingData;
  const OptionsWidget({super.key, this.serviceData, this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Options",
          style: boldTextStyle(),
        ),
        16.height,
        Container(
            padding: EdgeInsets.all(16),
            width: context.width(),
            decoration: boxDecorationDefault(color: context.cardColor),
            child: Column(
              children: List.generate(
                  bookingData!.bookingOptions!.length.validate(), (index) {
                final data = bookingData!.bookingOptions![index];
                if (data.variant == null && data.quantity! > 0) {
                  if (data.option!.typeInt == 3) {
                    BookingOption bookingOption = bookingData!.bookingOptions!
                        .firstWhere((element) =>
                            element.optionId == data.option!.multiplyOptionId);
                    return Row(
                      children: [
                        Container(
                          child: Text(data.option!.name.validate()),
                          width: context.width() * 0.4,
                        ),
                        Text((bookingOption.option!.unitPrice! *
                                    bookingOption.quantity!)
                                .toString() +
                            appStore.currencySymbol +
                            ' * ' +
                            data.quantity.toString() +
                            ' = ' +
                            ((bookingOption.option!.unitPrice! *
                                        bookingOption.quantity!) *
                                    data.quantity.validate())
                                .toString() +
                            appStore.currencySymbol)
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ).paddingSymmetric(vertical: 8);
                  }
                  return Row(
                    children: [
                      Container(
                        child: Text(data.option!.name.validate()),
                        width: context.width() * 0.4,
                      ),
                      if (data.option!.unitPrice! > 0)
                        Text((data.option!.unitPrice!).toString() +
                            appStore.currencySymbol +
                            ' * ' +
                            data.quantity.toString() +
                            ' = ' +
                            ((data.option!.unitPrice)! *
                                    data.quantity.validate())
                                .toString() +
                            appStore.currencySymbol)
                      else
                        Text((data.option!.area! *
                                    serviceData!.pricePerSqft.validate())
                                .toString() +
                            appStore.currencySymbol +
                            ' * ' +
                            data.quantity.toString() +
                            ' = ' +
                            ((data.option!.area! *
                                        serviceData!.pricePerSqft.validate()) *
                                    data.quantity.validate())
                                .toString() +
                            appStore.currencySymbol)
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ).paddingSymmetric(vertical: 8);
                }
                if (data.variant != null) {
                  if (data.option!.typeInt == 2) {
                    return Row(
                      children: [
                        Container(
                          child: Text(data.option!.name.validate()),
                          width: context.width() * 0.4,
                        ),
                        SizedBox(
                            width: context.width() * 0.4,
                            child: Marquee(
                              child: Text(
                                data.variant!.name.validate(),
                              ),
                            ))
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ).paddingSymmetric(vertical: 8);
                  }
                  return Row(
                    children: [
                      Text(data.option!.name.validate()),
                      SizedBox(
                        width: context.width() * 0.4,
                        child: Marquee(
                          child: data.variant!.price != null
                              ? Text(data.variant!.name.validate() +
                                  ' ' +
                                  data.variant!.price.toString() +
                                  appStore.currencySymbol)
                              : Text(data.variant!.name.validate() +
                                  ' ' +
                                  (data.variant!.packageArea! *
                                          serviceData!.pricePerSqft.validate())
                                      .toString() +
                                  appStore.currencySymbol),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ).paddingSymmetric(vertical: 8);
                }
                return Offstage();
              }),
            )),
      ],
    );
  }
}
