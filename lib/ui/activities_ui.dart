import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/activities_controller.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/ui/drawer_ui.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/widgets_ui/loading_footer.dart';
import 'package:sham_mobile/widgets_ui/elevating_title.dart';

class ActivitiesUI extends GetView<ActivitiesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerUI(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('activities'.tr),
      ),
      body: Obx(() => controller.activities.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SmartRefresher(
          controller: controller.refreshController,
          onRefresh: controller.refreshActivities,
          onLoading: controller.loadMoreActivities,
          enablePullUp: true,
          footer: LoadingFooter(),
          child: ListView.builder(
            key: PageStorageKey<String>('activities_list'),
            itemCount: controller.activities.length,
            itemBuilder: (context, index) => ActivityWidget(controller.activities[index])
          ),
        ),
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  final Activity activity;

  const ActivityWidget(this.activity, {Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    return SizedBox(
      height: 300,
      width: data.size.width,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Card(
            margin: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            elevation: 5.0,
            child: Column(
              children: [
                _buildUpperBar(context),

                Expanded(
                  child: _buildContent()
                )
              ],
            )
        ),
      ),
    );
  }

  Widget _buildUpperBar(BuildContext context) {
    return ElevatingTitle(
      child: Row(
        children: [
          PopupMenuButton<String>(
            onSelected: _onMenuItemSelected,
            padding: EdgeInsets.all(6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            icon: Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                child: Text('inquire'.tr),
                value: 'inquire'
              ),
              PopupMenuItem<String>(
                child: Text('reserve'.tr),
                value: 'reserve'
              ),
            ],
          ),

          Expanded(
            child: Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 12),
                  child: Text(activity.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white)
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  void _onMenuItemSelected(String value) {
    print(value);
  }

  Widget _buildContent() {
    return Row(
      children: [
        Expanded(
          flex: 50,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: _buildDescriptionArea()
          ),
        ),

        Expanded(
          flex: 50,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: _buildImage(),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionArea() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('age_group'.tr, style: TextStyle(fontSize: DefaultValues.largeTextSize),),
          subtitle: Text(activity.ageGroup.summary),
        ),
        ListTile(
          title: Text('date'.tr, style: TextStyle(fontSize: DefaultValues.largeTextSize)),
          subtitle: Text(activity.duration),
        )
      ],
    );
  }

  Widget _buildImage() {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
          colors: _shaderColors,
          stops: _shaderStops,
          end: Alignment.centerLeft,
          begin: Alignment.centerRight
      ).createShader(rect),

      child: ShaderMask(
        shaderCallback: (rect) => LinearGradient(
          colors: _shaderColors,
          stops: _shaderStops,
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter
        ).createShader(rect),

        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(activity.image)
              ),

              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        ),
      ),
    );
  }

  List<Color> get _shaderColors => [
    Colors.white.withOpacity(0.0),
    Colors.white,
    Colors.white,
    Colors.white.withOpacity(0.0)
  ];

  List<double> get _shaderStops => [
    0.01,
    0.25,
    0.75,
    0.99
  ];
}
