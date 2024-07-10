import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../Routes/app_route.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../../core/app_style.dart';
import '../../data/dto/login_dto.dart';
part '../widgets/_forgot_password_body.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _isShowPassword = ValueNotifier(false);
  final _isShowConfirmPassword = ValueNotifier(false);
  // final _forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 0.2.sh,
            child: Image.asset(
              AppAsset.backgroundLogin,
              fit: BoxFit.cover,
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 20, top: 50),
            child: InkWell(
              hoverColor: AppColors.transparent,
              onTap: () {
                context.go(AppRoute.login);
              },
              child: const SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35).r,
            child: Center(
              child: SizedBox(
                width: 360,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      24.verticalSpace,
                      _buildForgotPasswordWidget(),
                      Text('Nhập số điện thoại của bạn để đổi mật khẩu',
                          style: kBodyStyle.copyWith(
                              fontSize: 14,
                              color: AppColors.black.withOpacity(0.7))),
                      20.verticalSpace,
                      _buildPhoneField(),
                      20.verticalSpace,
                      _buildPasswordField(),
                      20.verticalSpace,
                      _buildComfirmPasswordField(),
                      10.verticalSpace,
                      SizedBox(
                        width: 360,
                        child: Text(
                          '*Mật khẩu ít nhất 8 ký tự, bao gồm(ký tự hoa, ký tự thường, ký tự số, ký tự đặc biệt)',
                          style: kCaptionWhiteStyle.copyWith(
                            fontStyle: FontStyle.italic,
                            color: AppColors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                      40.verticalSpace,
                      SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        textFieldBorderRadius * 10)),
                                side: const BorderSide(
                                    color: AppColors.themeColor),
                                foregroundColor: AppColors.white,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: AppColors.themeColor),
                            onPressed: () => _handleForgotPassword(),
                            child: const Text('Đặt lại mật khẩu',
                                style: kButtonWhiteStyle),
                          )),
                      16.verticalSpace,
                      _buildHaveAccount(),
                      66.verticalSpace,
                    ]
                        .animate(interval: 50.ms)
                        .slideX(
                            begin: -0.1,
                            end: 0,
                            curve: Curves.easeInOutCubic,
                            duration: 400.ms)
                        .fadeIn(
                          curve: Curves.easeInOutCubic,
                          duration: 400.ms,
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPhoneField() => CommonTextField(
        controller: _phoneController,
        onChanged: (p0) {},
        keyboardType: TextInputType.phone,
        maxLines: 1,
        validator: (value) {
          return AppRes.validatePhoneNumber(value)
              ? null
              : 'Số điện thoại không hợp lệ';
        },
        labelText: 'Số điện thoại',
        prefixIcon: Icon(
          Icons.phone_android_outlined,
          color: AppColors.black.withOpacity(0.9),
        ),
      );

  Widget _buildPasswordField() => ValueListenableBuilder(
      valueListenable: _isShowPassword,
      builder: (context, value, child) => CommonTextField(
            controller: _passwordController,
            onChanged: (p0) {},
            keyboardType: TextInputType.visiblePassword,
            maxLines: 1,
            validator: (value) {
              return AppRes.validatePassword(value)
                  ? null
                  : 'mật khẩu không hợp lệ';
            },
            labelText: 'Mật khẩu mới',
            prefixIcon: Icon(
              Icons.lock_outline,
              color: AppColors.black.withOpacity(0.9),
            ),
            obscureText: value,
            suffixIcon: GestureDetector(
              onTap: () {
                _isShowPassword.value = !_isShowPassword.value;
              },
              child: Icon(
                value
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.black.withOpacity(0.9),
              ),
            ),
          ));

  Widget _buildComfirmPasswordField() => ValueListenableBuilder(
        valueListenable: _isShowConfirmPassword,
        builder: (context, value, child) => CommonTextField(
          controller: _confirmPasswordController,
          onChanged: (p0) {},
          keyboardType: TextInputType.visiblePassword,
          maxLines: 1,
          validator: (value) {
            if (_passwordController.text != _confirmPasswordController.text) {
              return 'Xác nhận mật khẩu không khớp';
            }
            return AppRes.validatePassword(value)
                ? null
                : 'mật khẩu không hợp lệ';
          },
          labelText: 'Xác nhận mật khẩu',
          obscureText: !value,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: AppColors.black.withOpacity(0.9),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _isShowConfirmPassword.value = !_isShowConfirmPassword.value;
            },
            child: Icon(
              value
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color: AppColors.black.withOpacity(0.9),
            ),
          ),
        ),
      );

  _handleForgotPassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var loginModel = LoginDto(
          phoneNumber: _phoneController.text.trim(),
          password: _passwordController.text.trim());

      _forgotPassword(loginModel);
    }
  }

  void _forgotPassword(LoginDto loginModel) {
    // _forgotPasswordController.resetPassword(loginModel);
    // showDialog(
    //     context: Get.context!,
    //     builder: (_) {
    //       return Obx(() => AsyncWidget(
    //           apiState: _forgotPasswordController.apiStatus.value,
    //           progressStatusTitle: 'Đang xử lý...',
    //           failureStatusTitle: _forgotPasswordController.errorMessage.value,
    //           successStatusTitle: 'Đặt lại mật khẩu thành công!',
    //           onRetryPressed: () =>
    //               _forgotPasswordController.resetPassword(loginModel),
    //           onSuccessPressed: () {
    //             _phoneController.clear();
    //             _passwordController.clear();
    //             _confirmPasswordController.clear();
    //             Get.offAll(() => LoginScreen());
    //           }));
    //     });
  }

  Widget _buildForgotPasswordWidget() {
    return FittedBox(
      child: Text(AppString.forgotPassword.removeLast().toUpperCase(),
          style: kHeadingStyle.copyWith(
              fontSize: 48.sp, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildHaveAccount() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Đã có tài khoản,', style: kButtonStyle),
      const SizedBox(width: defaultPadding / 2),
      GestureDetector(
          onTap: () => context.go(AppRoute.login),
          child: Text('Quay lại đăng nhập',
              style: kBodyWhiteStyle.copyWith(
                  color: AppColors.themeColor.withOpacity(0.6),
                  fontWeight: FontWeight.bold)))
    ]);
  }
}

// class ForgotPasswordScreen extends GetResponsiveView {
//   ForgotPasswordScreen({super.key});



//   @override
//   Widget? phone() =>
//       Scaffold(resizeToAvoidBottomInset: true, body: _buildBodyPhone());

//   @override
//   Widget? tablet() => Scaffold(body: _buildBodyPhone());

//   @override
//   Widget? desktop() => Scaffold(body: _buildBodyDesktop());

//   _buildAppBar() {
//     return AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//             color: AppColors.white,
//             iconSize: 24,
//             splashRadius: 20,
//             padding: EdgeInsets.zero,
//             onPressed: () => Get.back(),
//             icon: const Icon(Icons.arrow_back_ios_new_rounded)));
//   }



//   _buildBodyPhone() {
//     return Stack(
//       children: [
//         SizedBox.expand(
//             child: Image.asset(AppAsset.backgroundLogin, fit: BoxFit.cover)),
//         _buildAppBar(),
//         Center(
//           child: Card(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(defaultBorderRadius)),
//             margin: const EdgeInsets.all(20).r,
//             color: AppColors.white.withOpacity(0.2),
//             elevation: 30,
//             child: FittedBox(
//               child: Container(
//                 width: Get.context!.isSmallTablet ? 500.w : 390.w,
//                 padding: const EdgeInsets.symmetric(horizontal: 14).r,
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       40.verticalSpace,
//                       SizedBox(
//                           width: Get.context!.isSmallTablet ? 500.w : 360.w,
//                           height: 96.h,
//                           child: Column(
//                             children: [
//                               _buildForgotPasswordWidget(),
//                               Text('Nhập số điện thoại của bạn để đổi mật khẩu',
//                                   style: kBodyStyle.copyWith(
//                                       fontSize: 10,
//                                       color: AppColors.white.withOpacity(0.5)))
//                             ],
//                           )),
//                       36.verticalSpace,
//                       _buildPhoneField(),
//                       36.verticalSpace,
//                       _buildPasswordField(),
//                       36.verticalSpace,
//                       _buildComfirmPasswordField(),
//                       15.verticalSpace,
//                       SizedBox(
//                         width: 360.w,
//                         child: Text(
//                           '*Mật khẩu ít nhất 8 ký tự, bao gồm(ký tự hoa, ký tự thường, ký tự số, ký tự đặc biệt)',
//                           style: kCaptionWhiteStyle.copyWith(
//                             fontStyle: FontStyle.italic,
//                             color: AppColors.white.withOpacity(0.5),
//                           ),
//                         ),
//                       ),
//                       15.verticalSpace,
//                       SizedBox(
//                           width: 360.w,
//                           height: 40.h,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         textFieldBorderRadius)),
//                                 side: const BorderSide(
//                                     color: AppColors.themeColor),
//                                 foregroundColor: AppColors.white,
//                                 elevation: 0,
//                                 shadowColor: Colors.transparent,
//                                 backgroundColor: AppColors.themeColor),
//                             onPressed: () => _handleForgotPassword(),
//                             child: Text('Đặt lại mật khẩu',
//                                 style: kButtonWhiteStyle),
//                           )),
//                       const SizedBox(height: defaultPadding * 2),
//                       _buildHaveAccount(),
//                       const SizedBox(height: defaultPadding * 2),
//                     ]
//                         .animate(interval: 50.ms)
//                         .slideX(
//                             begin: -0.1,
//                             end: 0,
//                             curve: Curves.easeInOutCubic,
//                             duration: 400.ms)
//                         .fadeIn(
//                           curve: Curves.easeInOutCubic,
//                           duration: 400.ms,
//                         ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   _buildBodyDesktop() {
//     return Stack(
//       children: [
//         SizedBox(
//             height: Get.height,
//             width: Get.width,
//             child: Image.asset(AppAsset.backgroundLogin, fit: BoxFit.cover)),
//         _buildAppBar(),
//         Center(
//           child: Card(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(defaultBorderRadius)),
//             color: AppColors.white.withOpacity(0.2),
//             elevation: 30,
//             child: FittedBox(
//               child: SizedBox(
//                 width: 600.w,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 127, vertical: 66)
//                           .r,
//                   child: Form(
//                       key: _formKey,
//                       child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                         Center(child: _buildForgotPasswordWidget()),
//                         Center(
//                             child: Text(
//                                 'Nhập số điện thoại của bạn để đổi mật khẩu',
//                                 style: kBodyStyle.copyWith(
//                                     color: AppColors.white.withOpacity(0.5)))),
//                         36.verticalSpace,
//                         _buildPhoneField(),
//                         36.verticalSpace,
//                         _buildPasswordField(),
//                         36.verticalSpace,
//                         _buildComfirmPasswordField(),
//                         10.verticalSpace,
//                         Text(
//                             '*Mật khẩu ít nhất 8 ký tự, bao gồm(ký tự hoa, ký tự thường, ký tự số, ký tự đặc biệt)',
//                             style: kCaptionWhiteStyle.copyWith(
//                                 fontStyle: FontStyle.italic,
//                                 color: AppColors.white.withOpacity(0.5))),
//                         16.verticalSpace,
//                         SizedBox(
//                           width: double.infinity,
//                           height: defaultButtonHeight,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         textFieldBorderRadius)),
//                                 side: const BorderSide(
//                                     color: AppColors.themeColor),
//                                 foregroundColor: AppColors.white,
//                                 padding: const EdgeInsets.all(defaultPadding),
//                                 elevation: 0,
//                                 shadowColor: Colors.transparent,
//                                 backgroundColor: AppColors.themeColor),
//                             onPressed: () => _handleForgotPassword(),
//                             child: Text('Đặt lại mật khẩu',
//                                 style: kButtonWhiteStyle),
//                           ),
//                         ),
//                         16.verticalSpace,
//                         _buildHaveAccount(),
//                       ]
//                               .animate(interval: 50.ms)
//                               .slideX(
//                                   begin: -0.1,
//                                   end: 0,
//                                   curve: Curves.easeInOutCubic,
//                                   duration: 400.ms)
//                               .fadeIn(
//                                   curve: Curves.easeInOutCubic,
//                                   duration: 400.ms))),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
