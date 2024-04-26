import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:handyman_provider_flutter/components/app_widgets.dart';
import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/components/custom_image_picker.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/attachment_model.dart';
import 'package:handyman_provider_flutter/models/booking_detail_response.dart';
import 'package:handyman_provider_flutter/networks/network_utils.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/configs.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceProofScreen extends StatefulWidget {
  final BookingDetailResponse? bookingDetail;

  const ServiceProofScreen({super.key, this.bookingDetail});

  @override
  ServiceProofScreenState createState() => ServiceProofScreenState();
}

class ServiceProofScreenState extends State<ServiceProofScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<File> imageFiles = [];
  List<Attachments> tempAttachments = [];
  UniqueKey uniqueKey = UniqueKey();
  bool isUpdate = false;
  Future<void> removeAttachment({required int id}) async {
    appStore.setLoading(true);

    Map req = {
      CommonKeys.type: 'booking_attachment',
      CommonKeys.id: id,
    };

    await deleteImage(req).then((value) {
      tempAttachments.validate().removeWhere((element) => element.id == id);
      setState(() {});

      uniqueKey = UniqueKey();

      appStore.setLoading(false);
      toast(value.message.validate(), print: true);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }
  // Future<void> removeAttachment({required int id}) async {
  //   appStore.setLoading(true);

  TextEditingController serviceNameCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();
  TextEditingController compliantCont = TextEditingController();

  FocusNode compliantFocus = FocusNode();
  // FilePickerResult? filePickerResult;

  // List<File> imageFiles = [];

  // getMultipleFile() async {
  //   filePickerResult = await FilePicker.platform.pickFiles(
  //       allowMultiple: true,
  //       type: FileType.custom,
  //       allowedExtensions: ['jpg', 'png', 'jpeg']);

  //   if (filePickerResult != null) {
  //     setState(() {
  //       imageFiles =
  //           filePickerResult!.paths.map((path) => File(path!)).toList();
  //     });
  //   } else {}
  // }

  Future<void> submit() async {
    hideKeyboard(context);

    MultipartRequest multiPartRequest =
        await getMultiPartRequest('save-service-proof');
    multiPartRequest.fields[CommonKeys.serviceId] =
        widget.bookingDetail!.service!.id.toString().validate();
    multiPartRequest.fields[CommonKeys.bookingId] =
        widget.bookingDetail!.bookingDetail!.id.toString().validate();
    multiPartRequest.fields[CommonKeys.userId] =
        getIntAsync(USER_ID).toString();
    multiPartRequest.fields[SaveBookingAttachment.title] =
        titleCont.text.validate();
    multiPartRequest.fields[SaveBookingAttachment.description] =
        compliantCont.text.validate();

    if (imageFiles.isNotEmpty) {
      await Future.forEach<File>(imageFiles, (element) async {
        int i = imageFiles.indexOf(element);
        log('${SaveBookingAttachment.bookingAttachment + i.toString()}');
        multiPartRequest.files.add(await MultipartFile.fromPath(
            '${SaveBookingAttachment.bookingAttachment + i.toString()}',
            element.path));
      });
    }
    if (imageFiles.isEmpty) {
      return toast(languages.lblChooseOneImage);
    }

    if (imageFiles.isNotEmpty)
      multiPartRequest.fields[AddServiceKey.attachmentCount] =
          imageFiles.length.toString();

    log('multiPartRequest.fields : ${multiPartRequest.fields}');

    multiPartRequest.headers.addAll(buildHeaderTokens());

    appStore.setLoading(true);

    sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        appStore.setLoading(false);

        finish(context, true);
      },
      onError: (error) {
        toast(error.toString(), print: true);
        appStore.setLoading(false);
      },
    ).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        languages.lblServiceProof,
        color: context.primaryColor,
        textColor: white,
        backWidget: BackWidget(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppTextField(
                  //   textFieldType: TextFieldType.NAME,
                  //   controller: serviceNameCont,
                  //   decoration: inputDecoration(context),
                  //   enabled: false,
                  // ),
                  // 16.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: titleCont,
                    nextFocus: compliantFocus,
                    decoration:
                        inputDecoration(context, hint: languages.lblTitle),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.MULTILINE,
                    controller: compliantCont,
                    minLines: 5,
                    decoration: inputDecoration(context,
                        hint: languages.hintDescription),
                  ),
                  16.height,

                  Padding(
                      padding: EdgeInsets.all(16),
                      child: CustomImagePicker(
                        //  key: uniqueKey,
                        onRemoveClick: (value) {
                          if (tempAttachments.validate().isNotEmpty &&
                              imageFiles.isNotEmpty) {
                            showConfirmDialogCustom(
                              context,
                              dialogType: DialogType.DELETE,
                              positiveText: languages.lblDelete,
                              negativeText: languages.lblCancel,
                              onAccept: (p0) {
                                imageFiles.removeWhere(
                                    (element) => element.path == value);
                                removeAttachment(
                                    id: tempAttachments
                                        .validate()
                                        .firstWhere(
                                            (element) => element.url == value)
                                        .id
                                        .validate());
                              },
                            );
                          } else {
                            showConfirmDialogCustom(
                              context,
                              dialogType: DialogType.DELETE,
                              positiveText: languages.lblDelete,
                              negativeText: languages.lblCancel,
                              onAccept: (p0) {
                                imageFiles.removeWhere(
                                    (element) => element.path == value);
                                if (isUpdate) {
                                  uniqueKey = UniqueKey();
                                }
                                setState(() {});
                              },
                            );
                          }
                        },
                        selectedImages: imageFiles
                            .validate()
                            .map((e) => e.path.validate())
                            .toList(),
                        onFileSelected: (List<File> files) async {
                          setState(() {
                            imageFiles = files;
                            widget.bookingDetail?.imageList = files;
                          });
                        },
                      )),
                  // SizedBox(
                  //   width: context.width(),
                  //   height: 120,
                  //   child: DottedBorderWidget(
                  //     color: primaryColor.withOpacity(0.6),
                  //     strokeWidth: 1,
                  //     padding: EdgeInsets.all(16),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(LineIcons.image, size: 30, color: context.iconColor),
                  //         8.height,
                  //         Text(languages.lblAddImage, style: boldTextStyle()),
                  //       ],
                  //     ).center().onTap(() async {
                  //       getMultipleFile();
                  //     }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
                  //   ),
                  // ),
                  16.height,
                  // HorizontalList(
                  //     padding: EdgeInsets.zero,
                  //     itemCount: imageFiles.length,
                  //     itemBuilder: (context, i) {
                  //       return Stack(
                  //         alignment: Alignment.topRight,
                  //         children: [
                  //           Image.file(imageFiles[i],
                  //                   width: 90, height: 90, fit: BoxFit.cover)
                  //               .cornerRadiusWithClipRRect(defaultRadius),
                  //           Container(
                  //             decoration: boxDecorationWithRoundedCorners(
                  //                 boxShape: BoxShape.circle,
                  //                 backgroundColor: primaryColor),
                  //             margin: EdgeInsets.only(right: 8, top: 8),
                  //             padding: EdgeInsets.all(4),
                  //             child: Icon(Icons.close, size: 16, color: white),
                  //           ).onTap(() {
                  //             imageFiles.removeAt(i);
                  //             setState(() {});
                  //           }),
                  //         ],
                  //       );
                  //     }).paddingBottom(16).visible(imageFiles.isNotEmpty),
                ],
              ),
            ),
          ),
          Observer(
            builder: (context) => LoaderWidget().visible(appStore.isLoading),
          )
        ],
      ),
      bottomNavigationBar: AppButton(
        text: languages.lblSubmit,
        textColor: Colors.white,
        color: primaryColor,
        onTap: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            submit();
          }
        },
      ).paddingAll(16),
    );
  }
}
