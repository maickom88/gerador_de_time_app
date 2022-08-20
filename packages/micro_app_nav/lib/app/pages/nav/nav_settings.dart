import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_commons/app/components/delete_account.dart';
import 'package:micro_commons/app/components/settings_details.dart';
import 'package:micro_commons/customs/file_picker_custum.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconsax/iconsax.dart';

import 'package:uuid/uuid.dart';
import 'package:micro_commons/app/components/avatar_photo.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';
import '../../domain/entities/user_entity.dart';
import '../controllers/logout_controller.dart';
import '../states/logout_state.dart';

class NavSettings extends StatefulWidget {
  final LogoutController logoutController;
  const NavSettings(
    this.logoutController, {
    Key? key,
  }) : super(key: key);

  @override
  _NavSettingsState createState() => _NavSettingsState();
}

class _NavSettingsState extends State<NavSettings> {
  late FocusNode textFocusNode;
  late TextEditingController textEditingController;
  late bool readOnly;
  @override
  void initState() {
    readOnly = true;
    textFocusNode = FocusNode();
    textEditingController =
        TextEditingController(text: widget.logoutController.userEntity?.name);
    textFocusNode.addListener(() {
      if (!textFocusNode.hasPrimaryFocus) {
        if (textEditingController.text.isNotEmpty) {
          if (textEditingController.text !=
              widget.logoutController.userEntity?.name) {
            widget.logoutController.userEntity = widget
                .logoutController.userEntity
                ?.copyWith(name: textEditingController.text);
            widget.logoutController.updateUser(context);
          }
        }
      }
    });

    CustumFilePicker.instance.onProgress.listen((event) {
      widget.logoutController.progressUpload.value = event;
    });
    super.initState();
  }

  @override
  void dispose() {
    // textEditingController.dispose();
    // textFocusNode.dispose();
    // widget.logoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LogoutState>(
        valueListenable: widget.logoutController,
        builder: (context, value, child) {
          if (value is LogoutErrorState) {
            return ErrorComponent(
              onLoad: () => widget.logoutController.initialize(),
            );
          }
          if (value is LogoutSuccessState) {
            return SafeArea(
              child: NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (_, inner) {
                  return <Widget>[
                    const SliverToBoxAdapter(
                        child: SizedBox(
                      height: 20,
                    )),
                    CupertinoSliverNavigationBar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      largeTitle: Text(
                        'Ajustes',
                        style: AppTypography.t28WithW800(),
                      ),
                      border: Border.all(color: Colors.transparent),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder<double>(
                          valueListenable:
                              widget.logoutController.progressUpload,
                          builder: (context, value, child) {
                            const locaImage = ProfileImage.hand1;
                            return Center(
                              child: Stack(
                                children: [
                                  Visibility(
                                    visible: value > 0,
                                    child: Container(
                                      width: 85,
                                      height: 85,
                                      decoration: const BoxDecoration(
                                        color: AppColor.lightColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircularProgressIndicator(
                                        value: value,
                                        strokeWidth: 8,
                                        color: AppColor.secondaryColor,
                                      ),
                                    ),
                                  ),
                                  AvatarPhoto(
                                    isLoadImageLocal: widget.logoutController
                                            .userEntity!.photo.isEmpty
                                        ? true
                                        : false,
                                    photo: widget.logoutController.userEntity!
                                            .photo.isNotEmpty
                                        ? widget
                                            .logoutController.userEntity!.photo
                                        : locaImage,
                                    heroTag: const Uuid().v1(),
                                    onTap: () async {
                                      HapticFeedback.lightImpact();
                                      FilePickerResult? result =
                                          await FilePicker.platform
                                              .pickFiles(type: FileType.image);
                                      if (result != null) {
                                        File file =
                                            File(result.files.single.path!);
                                        widget.logoutController
                                            .uploadFile(context, file);
                                      }
                                    },
                                  ),
                                ],
                              ).withBottomPadding(bottomPadding: 5),
                            );
                          }),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          controller: textEditingController,
                          onFieldSubmitted: (value) {
                            setState(() {
                              readOnly = true;
                            });
                            if (value.isNotEmpty) {
                              if (value !=
                                  widget.logoutController.userEntity?.name) {
                                widget.logoutController.userEntity = widget
                                    .logoutController.userEntity
                                    ?.copyWith(
                                        name: textEditingController.text);
                                widget.logoutController.updateUser(context);
                              }
                            }
                          },
                          focusNode: textFocusNode,
                          readOnly: readOnly,
                          textAlign: TextAlign.center,
                          style: AppTypography.t22WithW800(),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            setState(() {
                              readOnly = false;
                            });
                            FocusScope.of(context).requestFocus(textFocusNode);
                          },
                          child: Text(
                            'Editar nome',
                            style: AppTypography.t16().copyWith(
                              height: 2.0,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                      ).withBottomPadding(),
                      FadeAnimation(
                        delay: 0.2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xffF4F4F4),
                            borderRadius:
                                AppDefault.defaultBorderRadius(radius: 20),
                          ),
                          child: Column(
                            children: [
                              SettingsDetails(
                                icon: Iconsax.sms_star,
                                label: 'Notificação por email',
                                widget: CupertinoSwitch(
                                  onChanged: (value) {},
                                  value: true,
                                ),
                              ),
                              SettingsDetails(
                                icon: Iconsax.bag_2,
                                label: 'Notificações de ofertas',
                                widget: CupertinoSwitch(
                                  onChanged: (value) {},
                                  value: true,
                                ),
                              ),
                              Visibility(
                                visible:
                                    widget.logoutController.userEntity?.role ==
                                        RoleEnum.free,
                                child: SettingsDetails(
                                  icon: Iconsax.medal,
                                  label: 'Ser premium',
                                  widget: GestureDetector(
                                    onTap: () {
                                      SystemSound.play(SystemSoundType.click);
                                      AppDefault.navigateTo(context,
                                          routeName: '/subscription');
                                    },
                                    child: const Icon(
                                      Iconsax.arrow_circle_right,
                                      size: 25,
                                      color: Color(0xffACACAC),
                                    ).withRightPadding(rightPadding: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).withBottomPadding(),
                      ),
                      FadeAnimation(
                        delay: 0.4,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xffF4F4F4),
                            borderRadius:
                                AppDefault.defaultBorderRadius(radius: 20),
                          ),
                          child: Column(
                            children: [
                              // SettingsDetails(
                              //   icon: Iconsax.moon,
                              //   label: 'Modo escuro',
                              //   widget: CupertinoSwitch(
                              //     onChanged: (value) {},
                              //     value: false,
                              //   ),
                              // ),
                              // SettingsDetails(
                              //   icon: Iconsax.key,
                              //   label: 'Alterar senha',
                              //   widget: GestureDetector(
                              //     onTap: () async {
                              //       SystemSound.play(SystemSoundType.click);
                              //     },
                              //     child: const Icon(
                              //       Iconsax.arrow_circle_right,
                              //       size: 25,
                              //       color: Color(0xffACACAC),
                              //     ).withRightPadding(rightPadding: 20),
                              //   ),
                              // ),
                              SettingsDetails(
                                icon: Iconsax.magic_star,
                                label: 'Avaliar o app',
                                widget: GestureDetector(
                                  onTap: () async {
                                    SystemSound.play(SystemSoundType.click);
                                    final inAppReview = InAppReview.instance;

                                    if (await inAppReview.isAvailable()) {
                                      inAppReview.requestReview();
                                    }
                                  },
                                  child: const Icon(
                                    Iconsax.arrow_circle_right,
                                    size: 25,
                                    color: Color(0xffACACAC),
                                  ).withRightPadding(rightPadding: 20),
                                ),
                              ),
                              SettingsDetails(
                                icon: Iconsax.message_notif,
                                label: 'Ajuda',
                                widget: GestureDetector(
                                  onTap: () {
                                    SystemSound.play(SystemSoundType.click);

                                    AppDefault.navigateTo(context,
                                        routeName: '/help');
                                  },
                                  child: const Icon(
                                    Iconsax.arrow_circle_right,
                                    size: 25,
                                    color: Color(0xffACACAC),
                                  ).withRightPadding(rightPadding: 20),
                                ),
                              ),
                              SettingsDetails(
                                icon: Iconsax.trash,
                                label: 'Excluir conta',
                                widget: GestureDetector(
                                  onTap: () {
                                    SystemSound.play(SystemSoundType.click);
                                    showCupertinoModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          color: Colors.white,
                                          padding:
                                              const EdgeInsets.only(top: 30),
                                          height: AppDefault.height(context)
                                              .percent(70),
                                          child: Material(
                                            color: Colors.white,
                                            child: DeleteAccount(
                                              onLoad: () async {
                                                AppDefault.close(context);
                                                await widget.logoutController
                                                    .deleteAccout(context);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Iconsax.arrow_circle_right,
                                    size: 25,
                                    color: Color(0xffACACAC),
                                  ).withRightPadding(rightPadding: 20),
                                ),
                              ),
                              SettingsDetails(
                                icon: Iconsax.logout,
                                label: 'Sair',
                                widget: GestureDetector(
                                  onTap: () {
                                    SystemSound.play(SystemSoundType.click);
                                    widget.logoutController.logout(context);
                                  },
                                  child: const Icon(
                                    Iconsax.arrow_circle_right,
                                    size: 25,
                                    color: Color(0xffACACAC),
                                  ).withRightPadding(rightPadding: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppDefault.defaultSpaceHeight(height: 40),
                      const Center(
                        child: Text(
                          '#v1.0.0',
                          style: TextStyle(color: AppColor.textLight),
                        ),
                      )
                    ],
                  ).withSymPadding(),
                ),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                height: 50,
                child: Center(
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulseSync,
                    colors: [AppColor.primaryColor],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
