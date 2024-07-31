import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Center(child: SpinKitCircle(color: Colors.red, size: 30));
    return Center(
        child: SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        color: context.colorScheme.primary,
        strokeWidth: 4,
        strokeCap: StrokeCap.round,
      ),
    ));
  }
}
