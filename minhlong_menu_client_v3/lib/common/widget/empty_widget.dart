import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            margin: const EdgeInsets.all(16),
            // color: context.colorScheme.error.withOpacity(0.2),
            child: Container(
                height: context.size!.height / 2,
                padding: const EdgeInsets.all(16),
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outlined,
                          // color: context.colorScheme.tertiary,
                          size: 50.0),
                      SizedBox(height: 10.0),
                      Text(
                        'Không có sản phẩm!',
                        textAlign: TextAlign.center,
                        // style: context.titleStyleLarge!
                        //     .copyWith(fontWeight: FontWeight.bold)
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Xin lỗi, chúng tôi không thể tìm thấy bất kỳ kết quả nào cho mặt hàng của bạn.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        // style: context.textStyleSmall
                      )
                    ]))));
  }
}
