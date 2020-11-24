import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/loading/loading_controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/image_switcher.dart';

class LoadingUI extends GetView<LoadingController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ShamLocalizations.of(context).getDirection(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        body: Stack(
          children: [
            _buildBackground(context),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(context),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

                  CircularProgressIndicator(
                    backgroundColor: Colors.white,

                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

                  Text("${'loading'.tr}...",
                    style: TextStyle(
                      fontSize: Provider.of<DefaultValues>(context).extraLargeTextSize,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset('assets/images/sham_logo.png',
            fit: BoxFit.fill,),
        ),
      ),
    );
  }

    Widget _buildBackground(BuildContext context) {
      return Opacity(
        opacity: 0.6,
        child: ImageSwitcher(
          images: const [
            'assets/images/sham_books_1.jpg',
            'assets/images/sham_facade.jpg',
            'assets/images/sham_books_2.jpg',
            'assets/images/sham_kids.jpg',
            'assets/images/sham_single_book.jpg',
          ],
          duration: Duration(seconds: 4),
        ),
      );
    }
}
