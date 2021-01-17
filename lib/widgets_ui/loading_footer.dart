import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get_utils/get_utils.dart';

/// Default footer to use in pull to refresh.
class LoadingFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
        builder: (ctx, status) {
          switch(status) {
            case LoadStatus.failed:
              return Center(child: Text('error_while_retrieving_data'.tr));

            case LoadStatus.canLoading:
            case LoadStatus.loading:
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 20, maxHeight: 20),
                        child: CircularProgressIndicator(strokeWidth: 2,)),
                    SizedBox(width: 10),
                    Text('loading'.tr)
                  ],
                ),
              );

            default:
              return Container();
          }
        }
    );
  }
}
