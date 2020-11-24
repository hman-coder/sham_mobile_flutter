import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'view_books_ui.dart';
import 'package:sham_mobile/drawer/drawer_ui.dart';
import 'package:sham_mobile/books/main/bloc/books_bloc_barrel.dart';
import 'package:sham_mobile/books/advanced_search/bloc/book_search_bloc_barrel.dart';
import 'package:sham_mobile/widgets/exception_widget.dart';
import 'books_advanced_search_ui.dart';
import 'package:get/get_utils/get_utils.dart';

class BooksUI extends StatefulWidget {
  BooksUI({Key key}) : super(key: key);

  @override
  _BooksUIState createState() => _BooksUIState();
}

class _BooksUIState extends State<BooksUI> with TickerProviderStateMixin {
  TabController _tabController;
  BooksBloc _bloc;

  BooksEvent _tabIndexToBooksEvent(int index) {
    if(_tabController.index == 0) {
      return AllBooksEvent();

    } else if (_tabController.index == 1) {
      return BookmarksEvent();

    } else { // (_tabController.index == 2)
      return BlindDatesEvent();
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _bloc = BooksBloc();

    _tabController.addListener(() =>
        _bloc.add(_tabIndexToBooksEvent(_tabController.index)));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BooksBloc>.value(
      value: _bloc,
      child: ChangeNotifierProvider<TabController>.value(
        value: _tabController,
        child: Scaffold(
          drawer: DrawerUI(),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
                _buildSliverHeader(context, innerBoxIsScrolled),
            body: _buildSliverBody(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSliverHeader(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      BlocProvider<BookSearchBloc>(
        create: (context) => BookSearchBloc(
            tabController: _tabController,
            booksBloc: _bloc
        ),
        child: SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: _buildAppBarTitle(context),
            actions: _buildAppBarActions(context),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(text: "books".tr),
                Tab(text: "bookmarks".tr),
                Tab(text: "blind_dates".tr),
              ],
            )),
      )
    ];
  }

  Widget _buildAppBarTitle(BuildContext context) {
    return BlocBuilder<BookSearchBloc, BookSearchState>(
      builder: (context, state) => AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            ScaleTransition(child: child, scale: animation),
        child:  state is SearchModeOffState
            ? Text('books'.tr)
            : TextField(
          onChanged: (str) => context.bloc<BookSearchBloc>().add(SearchEvent(Book(title: str))),
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 12, left: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: 'search_book_hint'.tr,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return <Widget>[
      BlocBuilder<BookSearchBloc, BookSearchState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: IconButton(
              icon: Icon(state is SearchModeOnState ? Icons.close : Icons.search),
              onPressed: () => context.bloc<BookSearchBloc>().add(SwitchSearchModeEvent())),
        ),
      ),

      BlocBuilder<BookSearchBloc, BookSearchState>(
        builder: (context, state) => AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: IconButton(
              icon: Icon(state is SearchModeOnState ? Icons.settings : Icons.filter_list ),
              onPressed: () async {
                if (state is SearchModeOnState){
                  Book searchBook = context.bloc<BookSearchBloc>().lastSearchBook;
                  searchBook = await Navigator.push<Book>(context, MaterialPageRoute(
                      builder: (context) => BooksAdvancedSearchUI(searchBook: searchBook,))
                  );
                  print(searchBook);

                  if(searchBook != null) context.bloc<BookSearchBloc>().add(SearchEvent(searchBook));

                } else {
                  print('Filter not implemented yet');
                }
              },
            )
        ),
      ),
    ];
  }

  Widget _buildSliverBody(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        if(state is BooksLoadedState)
          return _buildProperBookSliverList(state);

        else return _buildProperWidgetForState(state, context);
      },
    );
  }

  Widget _buildProperBookSliverList(BooksLoadedState state) {
    PageStorageKey<String> key;
    if (state is AllBooksState) {
      key = PageStorageKey<String>('all_books_list');

    } else if (state is BookmarksState) {
      key = PageStorageKey<String>('bookmarks_list');

    } else {
      key = PageStorageKey<String>('blind_dates_list');
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          key: key,
          delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (state is AllBooksState) {
                  return _MainBookItem(book: state.books[index]);

                } else if (state is BookmarksState) {
                  return _MainBookItem(book: state.books[index]);

                } else if (state is BlindDatesState) {
                  return _BlindDateItem(blindDate: state.books[index]);
                }

                return ExceptionWidget(text: "error_while_building_ui".tr);
              },

              childCount: state.books.length

          ),
        ),
      ],
    );
  }

  Widget _buildProperWidgetForState(BooksState state, BuildContext context) {
    if(state is LoadingState) return ConstrainedBox(constraints: BoxConstraints(maxWidth: 25, maxHeight: 25), child: CircularProgressIndicator());
    if(state is EmptyBookListState) return Center(child: Text("no_books_found".tr));
    return ExceptionWidget(text: "error_while_building_ui".tr);
  }
}

class _MainBookItem extends StatelessWidget {
  final Book book;

  const _MainBookItem({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Book>.value(
      value: book,
      child: Consumer<Book>(
        builder: (context, book, child) => ListTile(
          title: Text(book.title),
          subtitle: Text(book.authorsAsString),
          leading: Image.asset(book.image),
          trailing: IconButton(
              onPressed: () => BlocProvider.of<BooksBloc>(context).add(AddToBookmarksEvent(book)),
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: Icon(
                  book.bookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: book.bookmarked ? Colors.amber : Colors.grey,
                  key: UniqueKey(),
                ),
              )
          ),

          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewBookUI(book: book))),
        ),
      ),
    );
  }
}

class _BlindDateItem extends StatefulWidget {
  final Book blindDate;

  const _BlindDateItem({Key key, this.blindDate}) : super(key: key);

  @override
  _BlindDateItemState createState() => _BlindDateItemState();
}

class _BlindDateItemState extends State<_BlindDateItem> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 75),
      child: Card(
          margin: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 40,
                child: SizedBox(
                  height: 200,
                  child: Container(
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),),
                        image: DecorationImage(
                            image: AssetImage(widget.blindDate.image),
                            fit: BoxFit.fill
                        ),
                      )
                  ),),
              ),

              Expanded(
                flex: 60,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(child: Text(widget.blindDate.title)),
                ),
              )
            ],
          )
//    child: Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        SizedBox(
//        height: 150,
//          child: Container(
//              foregroundDecoration: BoxDecoration(
//                borderRadius: BorderRadius.only(
//                  topLeft: Radius.circular(15.0),
//                  topRight: Radius.circular(15.0),),
//                image: DecorationImage(
//                    image: AssetImage(widget.blindDate.image),
//                  fit: BoxFit.fill
//                ),
//                )
//              ),),
//
//        Padding(
//          padding: const EdgeInsets.all(12.0),
//          child: Text(widget.blindDate.title),
//        )
//      ],
//    )
      ),
    );
  }
}