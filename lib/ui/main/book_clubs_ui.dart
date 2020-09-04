import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/blocs/book_clubs.dart';
import 'package:sham_mobile/helpers/string_helper.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/ui/misc/drawer_ui.dart';
import 'package:sham_mobile/widgets/black_linear_gradient_background.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/exception_widget.dart';

class BookClubsUI extends StatelessWidget{
  BookClubsUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookClubsBloc>(
      create: (context) => BookClubsBloc(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        drawer: DrawerUI(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(ShamLocalizations.of(context).getValue('book_clubs')));
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<BookClubsBloc, BookClubsState>(
        buildWhen: (previous, current) =>
        current is LoadingBookClubsState ||
            current is BookClubsLoadedState,

        builder: (context, state) {
          if (state is LoadingBookClubsState) {
            return Center(child: CircularProgressIndicator());

          } else if(state is BookClubsLoadedState){
            return CustomScrollView(
              slivers: _buildBookClubs(context, state.bookClubs).toList(),
            );
          }

          else return ExceptionWidget(text: ShamLocalizations.of(context).getValue('error_while_building_ui'));
        }
    );
  }

  Iterable<Widget> _buildBookClubs(BuildContext context, List<Activity> bookClubs) sync* {
    for (Activity club in bookClubs) {
      yield* _buildBookClubItem(context, club);
    }
  }

  Iterable<Widget> _buildBookClubItem(BuildContext context, Activity bookClub) sync*{
    ShamLocalizations localizations = ShamLocalizations.of(context);
    yield SliverPadding(
      padding: EdgeInsets.all(0.0),
      sliver: SliverAppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        primary: false,
        expandedHeight: 150.0,
        stretch: true,
        flexibleSpace: GestureDetector(
          onTap: () => print("Pressed ${bookClub.title}"),
          child: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
                right: 10,
                left: 10),
            title: Consumer<DefaultValues>(
              builder: (context, defaultValues, child) => Text(bookClub.title,
                  style: defaultValues.sliverAppBarTextStyleWithShadow
              ),
            ),
            background: LinearGradientBackground(
                color: Colors.black54,
                child: Image.asset(bookClub.image, fit: BoxFit.cover,)),
          ),
        ),
      ),
    );

    yield SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(height: 10,),
            _buildLabelValuePair(context, localizations.getValue('age_group'), bookClub.ageGroup.toString()),
            _buildLabelValuePair(context, localizations.getValue('frequency'), bookClub.frequency),
            _buildLabelValuePair(context, localizations.getValue('next_session'), StringHelper.dateToString(bookClub.nextSession)),
            _buildLabelValuePair(context, localizations.getValue('participants'), '${bookClub.participants} \\ ${bookClub.slots}'),
            _buildMoreInfoButton(context, bookClub),
            Container(height: 15.0),
            Divider(
              color: Colors.black,
              height: 3.0,
              thickness: 3,)
          ],
        )
    );
  }

  Widget _buildLabelValuePair(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 15.0, left: 15.0, top:5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: ShamLocalizations.of(context).getDirection(),
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Text(label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
          ),

          Expanded(
            flex: 5,
            child: Text(value,
              style: TextStyle(
                  fontSize: 16,
                  color: Provider.of<DefaultValues>(context).maroon
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreInfoButton(BuildContext context, Activity bookClub) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: Text(ShamLocalizations.of(context).getValue('more_info'),
                  style: TextStyle(
                      color: Colors.blue
                  )
              ),

              onTap: () => print("Go to book club ${bookClub.title}"),
            )
          ]
      ),
    );
  }
}