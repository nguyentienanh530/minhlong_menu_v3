import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/model/user_model.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/repositories/user_repository.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../widgets/edit_profile_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userRepository: context.read<UserRepo>()),
      child: EditProfileWidget(user: user),
    );
  }
}
