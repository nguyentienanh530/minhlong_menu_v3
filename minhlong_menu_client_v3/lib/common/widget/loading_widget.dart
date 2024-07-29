import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: context.colorScheme.secondary,
                strokeWidth: 4,
                strokeCap: StrokeCap.round,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: context.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
