import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/view/home_view.dart';
import 'package:tracking_system_app/modules/profile/controller/profile_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tracking_system_app/shared/app_strings.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  final String phoneNumber = "963969830277";
  final String message = "Hello, I would like to inquire about your service.";

  @override
  Widget build(BuildContext context) {
    final AppStrings() = AppStrings();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppVar.primary,
        title: Center(
          child: Text(
            AppStrings().profile,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizeSp.s18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: AppVar.seconndTextColor,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (profileController.isLoading.value) {
              return const Center(child: MainLoadingWidget());
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppSizeH.s20),
                  Padding(
                    padding: EdgeInsets.all(AppSizeW.s15),
                    child: Column(
                      children: [
                        Container(
                          width: AppSizeW.s128,
                          height: AppSizeW.s128,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/user.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizeH.s16),
                        Text(
                          "${profileController.getCustomerInfo.value.firstName} ${profileController.getCustomerInfo.value.lastName}",
                          style: TextStyle(
                            color: const Color(0xFF101914),
                            fontSize: AppSizeSp.s22,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                            letterSpacing: -0.015,
                          ),
                        ),
                        SizedBox(height: AppSizeH.s4),
                        Text(
                          profileController.getCustomerInfo.value.role,
                          style: TextStyle(
                            color: const Color(0xFF5A8C6E),
                            fontSize: AppSizeSp.s16,
                            fontWeight: FontWeight.normal,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppSizeW.s15,
                        right: AppSizeW.s15,
                        top: AppSizeH.s15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings().account,
                          style: TextStyle(
                            color: const Color(0xFF101914),
                            fontSize: AppSizeSp.s18,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                            letterSpacing: -0.015,
                          ),
                        ),
                        SizedBox(height: AppSizeH.s10),
                        BuildInfoItemWidget(
                          icon: Icons.phone,
                          title: AppStrings().phone,
                          value: profileController.getCustomerInfo.value.phone,
                          editable: true,
                          onConfirm: (newValue) async {
                            profileController.updateInfoByCustomer(
                                email: null, phone: newValue);
                          },
                        ),
                        BuildInfoItemWidget(
                          icon: Icons.email,
                          title: AppStrings().email,
                          value: profileController.getCustomerInfo.value.email,
                          editable: true,
                          onConfirm: (newValue) async {
                            profileController.updateInfoByCustomer(
                                email: newValue, phone: null);
                          },
                        ),
                        BuildInfoItemWidget(
                          icon: Icons.location_on,
                          title: AppStrings().address,
                          value:
                              profileController.getCustomerInfo.value.address,
                        ),
                        BuildInfoItemWidget(
                          icon: Icons.business,
                          title: AppStrings().area,
                          value: profileController.getCustomerInfo.value.area,
                        ),
                        BuildInfoItemWidget(
                          icon: Icons.directions_car,
                          title: AppStrings().driver,
                          value: profileController
                              .getCustomerInfo.value.driverName,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppSizeW.s16,
                        right: AppSizeW.s16,
                        top: AppSizeH.s16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings().subscription,
                          style: TextStyle(
                            fontSize: AppSizeSp.s18,
                            fontWeight: FontWeight.bold,
                            height: AppSizeH.s1,
                            letterSpacing: -0.015,
                          ),
                        ),
                        BuildInfoItemWidget(
                          icon: Icons.calendar_today,
                          title: AppStrings().startDate,
                          value: profileController
                              .getCustomerInfo.value.subscriptionStartDate,
                        ),
                        BuildInfoItemWidget(
                          icon: Icons.calendar_today,
                          title: AppStrings().expiryDate,
                          value: profileController
                              .getCustomerInfo.value.subscriptionExpiryDate,
                        ),
                        BuildInfoItemWidget(
                          icon: Icons.check_circle,
                          title: AppStrings().status,
                          value: profileController.getCustomerInfo.value
                                      .subscriptionStatus ==
                                  1
                              ? AppStrings().active
                              : AppStrings().inactive,
                        ),
                        Padding(
                          padding: EdgeInsets.all(AppSizeW.s16),
                          child: SizedBox(
                            width: double.infinity,
                            height: AppSizeH.s40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF38E07B),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSizeR.s12),
                                ),
                              ),
                              onPressed: () async {
                                final Uri whatsappUri = Uri.parse(
                                    "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");
                                if (await canLaunchUrl(whatsappUri)) {
                                  await launchUrl(whatsappUri,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  CustomToast.errorToast(AppStrings().error,
                                      AppStrings().whatsappCannotBeOpened);
                                }
                              },
                              child: Text(
                                AppStrings().contactUs,
                                style: TextStyle(
                                  color: const Color(0xFF0E1A13),
                                  fontSize: AppSizeSp.s14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.015,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: AppSizeH.s35,
              color: AppVar.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildInfoItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool editable;
  final Future<void> Function(String newValue)? onConfirm;

  BuildInfoItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.editable = false,
    this.onConfirm,
  });

  final ValueNotifier<bool> isEditing = ValueNotifier(false);
  final ValueNotifier<String> currentValue = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    currentValue.value = value;
    final controller = TextEditingController(text: value);
    final profileController = Get.find<ProfileController>();
    final AppStrings() = AppStrings();

    return Container(
      height: AppSizeH.s72,
      padding: EdgeInsets.symmetric(vertical: AppSizeH.s8),
      child: Row(
        children: [
          Container(
            width: AppSizeW.s48,
            height: AppSizeW.s48,
            decoration: BoxDecoration(
              color: const Color(0xFFE9F1EC),
              borderRadius: BorderRadius.circular(AppSizeR.s12),
            ),
            child: Icon(icon, size: AppSizeW.s24),
          ),
          SizedBox(width: AppSizeW.s16),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: isEditing,
              builder: (context, editing, _) {
                if (!editable) {
                  return _buildStatic(currentValue.value);
                }
                if (!editing) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatic(currentValue.value),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () => isEditing.value = true,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          keyboardType: title == AppStrings().phone
                              ? TextInputType.number
                              : TextInputType.text,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Obx(() {
                        final isLoading = title == AppStrings().phone
                            ? profileController.isPhoneUpdating.value
                            : title == AppStrings().email
                                ? profileController.isEmailUpdating.value
                                : false;

                        if (isLoading) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppSizeW.s8),
                            child: SizedBox(
                              width: AppSizeW.s20,
                              height: AppSizeW.s20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppVar.primary,
                              ),
                            ),
                          );
                        }

                        return Row(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.check, color: Colors.green),
                              onPressed: () async {
                                if (onConfirm != null) {
                                  try {
                                    await onConfirm!(controller.text);
                                    currentValue.value = controller.text;
                                  } catch (e) {
                                    CustomToast.errorToast(AppStrings().error,
                                        AppStrings().updateFailed);
                                  }
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                controller.text = currentValue.value;
                                isEditing.value = false;
                              },
                            ),
                          ],
                        );
                      }),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatic(String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppSizeSp.s16,
            fontWeight: FontWeight.w500,
            height: 1.0,
          ),
        ),
        SizedBox(height: AppSizeH.s4),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF5A8C6E),
            fontSize: AppSizeSp.s12,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
