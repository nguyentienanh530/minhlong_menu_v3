import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

class DashboardLoadingScreen extends StatelessWidget {
  const DashboardLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.white60,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(30).r,
            child: Column(
              children: [
                _buildTotalLoading(),
                20.verticalSpace,
                context.isDesktop
                    ? Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Card(
                              child: Container(
                                height: 0.5 * context.sizeDevice.height,
                              ),
                            ),
                          ),
                          20.horizontalSpace,
                          Expanded(
                            child: Card(
                              child: Container(
                                height: 0.5 * context.sizeDevice.height,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Card(
                            child: Container(
                              height: 0.5 * context.sizeDevice.height,
                            ),
                          ),
                          20.verticalSpace,
                          Card(
                            child: Container(
                              height: 0.5 * context.sizeDevice.height,
                            ),
                          ),
                        ],
                      ),
                20.verticalSpace,
                Card(
                  child: Container(
                    height: 1 * context.sizeDevice.height,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalLoading() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildItemInfoLoading(),
          20.horizontalSpace,
          _buildItemInfoLoading(),
          20.horizontalSpace,
          _buildItemInfoLoading(),
          20.horizontalSpace,
          _buildItemInfoLoading(),
          20.horizontalSpace,
          _buildItemInfoLoading(),
          20.horizontalSpace,
          _buildItemInfoLoading(),
          20.horizontalSpace,
          _buildItemInfoLoading(),
          20.horizontalSpace,
        ],
      ),
    );
  }

  Widget _buildItemInfoLoading() {
    return Card(
      elevation: 1,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Card(
                  elevation: 10,
                  child: Container(
                    color: context.colorScheme.primary,
                    height: 50,
                    width: 50,
                    child: const Text('data'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
