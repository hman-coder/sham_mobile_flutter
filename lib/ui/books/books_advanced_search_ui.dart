import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/models/age_group.dart';
import 'package:sham_mobile/models/author.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/category.dart';
import 'package:sham_mobile/models/flagged_object.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/repositories/filters_repository.dart';

class BooksAdvancedSearchUI extends StatefulWidget {
  final Book searchBook;

  const BooksAdvancedSearchUI({Key key, this.searchBook}) : super(key: key);

  @override
  _BooksAdvancedSearchUIState createState() => _BooksAdvancedSearchUIState();
}

class _BooksAdvancedSearchUIState extends State<BooksAdvancedSearchUI> {
  FiltersRepository repo;

  @override
  void initState() {
    super.initState();
    repo = FiltersRepository();
  }

  @override
  Widget build(BuildContext context) {
    ShamLocalizations localizations = ShamLocalizations.of(context);

    return Directionality(
      textDirection: localizations.getDirection(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(localizations.getValue('advanced_search')),
            actions: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context, widget.searchBook),
                icon: Icon(Icons.search),
              )
            ],
          ),

          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _buildFilterTile(
                context,
                text: localizations.getValue('categories'),
                filterIsApplied: widget.searchBook.categories.length > 0,
                onTap: () async {
                  List<Category> categories = await _showCategoriesDialog(context);
                  widget.searchBook.categories = categories == null
                      ? widget.searchBook.categories
                      : categories;
                  print(categories);
                  setState(() => null);
                },
              ),

              _buildFilterTile(
                context,
                text: localizations.getValue('age_groups'),
                filterIsApplied: widget.searchBook.ageGroups.length > 0,
                onTap: () async {
                  List<AgeGroup> ageGroups = await _showAgeGroupsDialog(context);
                  widget.searchBook.ageGroups = ageGroups == null
                      ? widget.searchBook.ageGroups
                      : ageGroups;
                  print(ageGroups);
                  setState(() => null);
                },
              ),

              _buildFilterTile(
                context,
                text: localizations.getValue('authors'),
                filterIsApplied: widget.searchBook.authors.length > 0,
                onTap: () async {
                  List<Author> authors = await _showAuthorsDialog(context);
                  setState(() => widget.searchBook.authors = authors == null
                      ? widget.searchBook.authors
                      : authors);

                  print(authors);

                },
              ),

              _buildFilterTile(
                  context,
                  text: localizations.getValue('special_categories'),
                  filterIsApplied: widget.searchBook.specialCategories.length > 0,
                  onTap: () async {
                    List<Category> specialCategories = await _showSpecialCategoriesDialog(context);
                    setState(() => widget.searchBook.specialCategories = specialCategories == null
                        ? widget.searchBook.specialCategories
                        : specialCategories
                    );

                    print(specialCategories);
                  }
              ),

              _buildFilterTile(
                  context,
                  text: localizations.getValue('rating'),
                  filterIsApplied: ! (widget.searchBook.rating[0] == -1),
                  onTap: () async {
                    List<double> ratings = await _showRatingsDialog(context);
                    setState(() => widget.searchBook.rating = ratings == null
                        ? widget.searchBook.rating
                        : ratings);
                  }
              ),
            ],
          )
      ),
    );
  }

  Widget _buildFilterTile(BuildContext context, {String text, Function() onTap, bool filterIsApplied}) {
    return ListTile(
      onTap: onTap,

      title: Text(text),

      trailing: Icon(filterIsApplied
          ? Icons.playlist_add_check
          : Icons.list,

          color: filterIsApplied
              ? Colors.blue
              : Colors.grey
      ),
    );
  }

  Future<List<Category>> _showCategoriesDialog(BuildContext context) async {
    return showDialog<List<Category>>(
        context: context,
        barrierDismissible: false,
        builder: (buildContext) {
          return _FilterAlertDialog<Category>(
            allObjects: repo.categories,
            selectedObjects: widget.searchBook.categories.sublist(0),
            title: ShamLocalizations.of(context).getValue("categories"),
          );
        }
    );
  }

  Future<List<AgeGroup>> _showAgeGroupsDialog(BuildContext context) async {
    return showDialog<List<AgeGroup>>(
        context: context,
        barrierDismissible: false,
        builder: (buildContext) {
          return _FilterAlertDialog<AgeGroup>(
            allObjects: repo.ageGroups,
            selectedObjects: widget.searchBook.ageGroups.sublist(0),
            title: ShamLocalizations.of(context).getValue("age_groups"),
          );
        }
    );
  }

  Future<List<Author>> _showAuthorsDialog(BuildContext context) async {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    return showDialog<List<Author>>(
        context: context,
        barrierDismissible: false,
        builder: (buildContext) {

          return Directionality(
              textDirection: localizations.getDirection(),
              child: _AuthorsAlertDialog(
                allAuthors: repo.authors,
                selectedAuthors: widget.searchBook.authors,
              )
          );
        }
    );
  }

  Future<List<Category>> _showSpecialCategoriesDialog(BuildContext context) async {
    return showDialog<List<Category>>(
        context: context,
        barrierDismissible: false,
        builder: (buildContext) {
          return _FilterAlertDialog<Category>(
            allObjects: repo.specialCategories,
            selectedObjects: widget.searchBook.specialCategories.sublist(0),
            title: ShamLocalizations.of(context).getValue("special_categories"),
          );
        }
    );
  }

  Future<List<double>> _showRatingsDialog(BuildContext context) async {
    return showDialog<List<double>>(
        context: context,
        barrierDismissible: false,
        builder: (buildContext) {
          return _RatingsDialog(
            ratings: widget.searchBook.rating,
          );
        }
    );
  }
}

class _FilterAlertDialog<T> extends StatefulWidget {
  final List<T> allObjects;

  final List<T> selectedObjects;

  final String title;

  const _FilterAlertDialog({Key key, this.allObjects, this.selectedObjects, this.title}) : super(key: key);

  @override
  _FilterAlertDialogState<T> createState() => _FilterAlertDialogState<T>();
}

class _FilterAlertDialogState<T> extends State<_FilterAlertDialog<T>> {
  List<FlaggedObject<T>> flaggedObjectsList;

  @override
  void initState() {
    super.initState();
    flaggedObjectsList = widget.allObjects.map<FlaggedObject<T>>(
            (e) => FlaggedObject(value: e, flagged: widget.selectedObjects.contains(e))
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    return Directionality(
      textDirection: localizations.getDirection(),
      child: AlertDialog(
        title: Text(widget.title),

        content: ListView.builder(
            itemCount: flaggedObjectsList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider<FlaggedObject<T>>.value(
                value: flaggedObjectsList[index],

                child: Consumer<FlaggedObject<T>>(
                  builder: (context, value, child) => CheckboxListTile(
                    value: value.isFlagged,
                    title: Text(value.value.toString()),
                    onChanged: (checked) => value.isFlagged = checked,
                  ),
                ),
              );
            }

        ),

        actions: <Widget>[
          FlatButton(
            child: Text(localizations.getValue("cancel")),
            onPressed: () => Navigator.pop(context, null),
          ),

          FlatButton(
            child: Text(localizations.getValue("accept")),
            onPressed: () {
              print(_getResults().toList());
              Navigator.pop(context, _getResults().toList());
            },
          ),

          FlatButton(
            child: Text(localizations.getValue("remove_all")),
            onPressed: () => setState(() => flaggedObjectsList.forEach((element) => element.isFlagged = false)),
          )
        ],
      ),
    );
  }

  Iterable<T> _getResults() sync* {
    for(FlaggedObject<T> flaggedObject in flaggedObjectsList) {
      if (flaggedObject.isFlagged) yield flaggedObject.value;
    }
  }
}

class _AuthorsAlertDialog extends StatefulWidget {
  final List<Author> allAuthors;
  final List<Author> selectedAuthors;

  const _AuthorsAlertDialog({Key key, this.allAuthors, this.selectedAuthors}) : super(key: key);

  @override
  _AuthorsAlertDialogState createState() => _AuthorsAlertDialogState();
}

class _AuthorsAlertDialogState extends State<_AuthorsAlertDialog> {
  List<FlaggedObject<Author>> allAuthorsAsFlaggedObjects;

  List<FlaggedObject<Author>> displayedList;

  @override
  void initState() {
    super.initState();
    allAuthorsAsFlaggedObjects = widget.allAuthors.map<FlaggedObject<Author>>(
            (author) => FlaggedObject<Author>(
            value: author,
            flagged: widget.selectedAuthors.contains(author))
    ).toList();

    displayedList = allAuthorsAsFlaggedObjects;
  }

  @override
  Widget build(BuildContext context) {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    return AlertDialog(
      title: Text(localizations.getValue("authors")),

      content: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            primary: false,
            backgroundColor: Colors.white,
            pinned: true,
            title: TextField(
              onChanged: (text) => setState(() {
                displayedList = _filterList(text).toList();
                print(text);
              }),
              decoration: InputDecoration(
                  hintText: localizations.getValue("search_authors_hint"),
                  icon: Icon(Icons.search)
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ChangeNotifierProvider<FlaggedObject<Author>>.value(
                value: displayedList[index],
                child: Consumer<FlaggedObject<Author>>(
                  builder: (context, flaggedObject, child) => CheckboxListTile(
                    value: flaggedObject.isFlagged,
                    title: Text(flaggedObject.value.name),
                    onChanged: (checked) => flaggedObject.isFlagged = checked,
                  ),
                ),
              );
            },

                childCount: displayedList.length
            ),
          ),
        ],
      ),

      actions: <Widget>[
        FlatButton(
          child: Text(localizations.getValue("cancel")),
          onPressed: () => Navigator.pop(context, null),
        ),

        FlatButton(
          child: Text(localizations.getValue("accept")),
          onPressed: () => Navigator.pop(context, _getResult().toList()),
        ),

        FlatButton(
          child: Text(localizations.getValue("remove_all")),
          onPressed: () => setState(() {
            allAuthorsAsFlaggedObjects.forEach((element) => element.isFlagged = false);
            displayedList.forEach((element) => element.isFlagged = false);
          }),
        )
      ],
    );
  }

  Iterable<FlaggedObject<Author>> _filterList(String searchText) sync*{
    for(FlaggedObject<Author> flaggedObject in allAuthorsAsFlaggedObjects) {
      if(flaggedObject.value.name.contains(searchText)) {
        yield flaggedObject;
      }
    }
  }

  Iterable<Author> _getResult() sync* {
    for(FlaggedObject<Author> flaggedAuthor in allAuthorsAsFlaggedObjects) {
      if(flaggedAuthor.isFlagged) yield flaggedAuthor.value;
    }
  }
}

class _RatingsDialog extends StatefulWidget {
  final List<double> ratings;

  _RatingsDialog({Key key, @required this.ratings}) : super(key: key);

  @override
  _RatingsDialogState createState() => _RatingsDialogState(
      fromValue: ratings[0], toValue: ratings[1]);
}

class _RatingsDialogState extends State<_RatingsDialog> {
  double fromValue;

  double toValue;

  _RatingsDialogState({@required this.fromValue, @required this.toValue});

  @override
  Widget build(BuildContext context) {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    return Directionality(
        textDirection: localizations.getDirection(),
        child: AlertDialog(
          title: Text(localizations.getValue("rating")),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(localizations.getValue("from")),
                RatingBar(
                  initialRating: fromValue < 0 ? 0 : fromValue,
                  onRatingUpdate: (value) => setState(() => fromValue = value),
                  itemCount: 5,
                  allowHalfRating: false,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color:  Colors.amber,
                  ),
                ),

                Text(localizations.getValue("to")),
                RatingBar(
                  initialRating: toValue < 0 ? 0 : toValue,
                  onRatingUpdate: (value) => setState(() => toValue = value),
                  itemCount: 5,
                  allowHalfRating: false,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color:  Colors.amber,
                  ),
                ),

              ],
            ),
          ),

          actions: <Widget>[
            FlatButton(
              child: Text(localizations.getValue("cancel")),
              onPressed: () => Navigator.pop(context, null),
            ),

            FlatButton(
              child: Text(localizations.getValue("accept")),
              onPressed: () => Navigator.pop(context, _getResult()),
            ),

            FlatButton(
              child: Text(localizations.getValue("remove_all")),
              onPressed: () => setState(() => fromValue = toValue = -1),
            )
          ],
        )
    );
  }

  List<double> _getResult() {
    if(fromValue == 0 && toValue == 0) {
      fromValue = toValue = -1;
    }

    return fromValue > toValue
        ? [toValue, fromValue]
        : [fromValue, toValue];
  }
}