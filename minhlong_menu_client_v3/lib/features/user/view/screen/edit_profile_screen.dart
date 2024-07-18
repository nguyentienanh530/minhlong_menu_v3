import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_string.dart';
import '../../../../core/app_style.dart';
import 'profile_screen.dart';

part '../widget/_edit_profile_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final List<User> _userList = [
    User(
      name: 'Minh Long',
      email: 'kU9tY@example.com',
      phone: '0123456789',
      image:
          'https://lh3.googleusercontent.com/fife/ALs6j_HNnp_YYUcTx07-s7OqV1uoHQzmyQxvZMz37BsotCidxUxGeSxAIvGuaS-wiiTHrh_jSi7vHuiemUbf4PaDRXwo33zoH8PTyuUJD0ea5bUS7R-FuPqUB-iTPHlLJY1bM0oUB3g0AAVQAXH5NzfuSyo5z2y-F_iXMqev_ILGpkqGH1fRB1eeE1QkGZLUgf90A_EmZ5uw7gHkODSt28BfBLMqL4QBQjH8FUbrI7AwmCcfo4JAvbjISBthMhrLcRw59RRGylayVGd_BxFAZZnvG-aAJx8-haK2fFBJpuJLdNKYNq1uMIvPNvLpPG2Hs_7Q0dNfYn4aqEzAH8dIIe7G03f-Kg-SBeMK2T-mpdi9gisHn0Axw-TkWr7eSryBT9xI9cFqQ8YBOoIdkXlHcwEyy85at_r2wQUbeFEk23QDLGugvsJS2XMouDckqkbZIvczf7K45LInE2Gywa620QgdUBktp5vFs8ourw85HvOk4sDsXrbSthznZ0dh1zdjIbjR4R6Idy3AqJqEhxBInDWNfypoiYNekF0Qvij99cJ-gHXfa5P7gOc2y-JoZSgGDp6gR6xppE3PThstsnwIdUEB1PC7fBlS5ruRVoTuF95lDhbksE3R8OHoiGNwR5D4xvC_PZQDoSmyQFHtDiBX7Snih2uelycbv7cBpGFkdaWx6UAPZtPT2h8xuQ1AzKY8gUInwchtRq2bke1eKo4RpKwXWc-yfFItyn_H-oXTtQx59FdGLCFly_3XxIWtG7bGhQ3NVbOE5_i2wsOqk_rvVcZexOGCecY2gQO5xD81nkB3SM3Gznk3ixtY4P6IWj1jTXf4voYC4HWSLinZSYNs9H0m8Dse9nhTfwhQP2uBDU8sIfJsAvwkYfaLXJf2VswPTkkligVidVLjcX16SIWeB7BLYo7Je_TZOrpBIEb7nly_SM6EMLz3tH6bzwTL1F-a8B9IAFX3kLUPtshqp9RjVgNSzO_PIhyC7uIQizx0UxOytX5uFPQTkXvjja5LnwA0cWs3RHyNUx_Dct2DPtI7iA4JWYEGZePuufXeHZ33MGsLWAWD2_kHtC6B48pcMHggaJpBCjDUBHUL0RhYqknQOmsnMcEMhEqsBxNz7hWaKW-xhG30SM2zkeZw9m__R0zXD_u87-KX5VeI5VREU_u6qQsJvffcztaO2fFKBp60O66js5TnipxzfmCnLQSj0yS10uKQ1PlcdR7eeXKOnWIokEpddQZye53TEaUmUFDrt3EUSJd0IC90ilQNyq3QF-kmwtzEJq96HORW1dChUJcPlZIuThxrIoTxz_H5L7xZ5dfWptn2bN1enGXi-ZfAYNrAIguGEFlD1Uykua3hc6LPNvM-RpimL0ux10ZkgBT5vHJC6RE11g-1lpliquErbzdMg3AWtWi-RfURogbqt6bGHkYjz95BKFmeOpex5qKByB_A0EbCuVt1VvCegNriw1nEQJ1s1F8MV9WjqwwqCeQ6ttcO_aIJwDUUZCkh07VhBGKtEeouxdvtJSozMxLug5qd4iM5abJ7hyK2tJhjJPeEO1xVNmQSTeIUsFuH1FLfiw1kuvJHZRQAY1v236Kjuw_YwXsA2HYwHWVeHe7jaiCj_73GO_lINxXytR-tX1eCwWVGZ4Chdnc94VFVY2M=w884-h705',
    ),
  ];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _imageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = _userList[0].name ?? '';
    _emailController.text = _userList[0].email ?? '';
    _phoneController.text = _userList[0].phone ?? '';
    _imageController.text = _userList[0].image ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: CommonBackButton(
              onTap: () => context.pop(),
            ),
            title: FittedBox(child: Text(AppString.editProfile)),
            expandedHeight: context.isPortrait
                ? 0.4 * context.sizeDevice.height
                : 0.4 * context.sizeDevice.width,
            flexibleSpace:
                FlexibleSpaceBar(background: _imageEditProfileWidget()),
          ),
          SliverToBoxAdapter(child: _bodyEditInfoUser())
        ],
      ),
    );
  }
}
