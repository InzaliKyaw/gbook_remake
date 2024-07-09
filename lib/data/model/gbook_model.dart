import 'package:gbook_remake/data/vos/book_shelve_vo.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/data/vos/ny_book_list.dart';
import 'package:gbook_remake/data/vos/results_vo.dart';
import 'package:gbook_remake/network/data_agent/gbook_data_agent.dart';
import 'package:gbook_remake/network/data_agent/retrofit_data_agent_impl.dart';
import 'package:gbook_remake/network/response/get_book_response.dart';
import 'package:gbook_remake/persistance/daos/book_dao.dart';
import 'package:gbook_remake/persistance/daos/shelves_dao.dart';
import 'package:rxdart/rxdart.dart';

class GBookModel {
  static GBookModel? _singleton;

  factory GBookModel() {
    _singleton ??= GBookModel._internal();
    return _singleton!;
  }

  GBookModel._internal();

  /// Book Dao
  final BookDao _bookDao = BookDao();

  /// Book Dao
  final ShelvesDao _shelvesDao = ShelvesDao();

  /// Data Agent
  /// PolyMorphism Can use different Impl
  GBookDataAgent mDataAgent = RetrofitDataAgentImpl();

  Future<List<Books>> getGBooks(String query) {
    return mDataAgent.getGoogleBooks(query).then(
        (gBookResponse)=> gBookResponse?.items?.map((googleBooks)=> googleBooks.convertToBookVO()).toList() ?? [],
    );
  }

  /* Get from DB directly
  List<Books> getBooksList(){
    // Stream<List<Books>>  bLists= _bookDao.watchBookBox().map((_)=> _bookDao.getAllBooksFromDB());
    List<Books>  bLists2 = _bookDao.getAllBooksFromDB();
    return bLists2;
  }
   */

  /// As we want to display without update to the list
  /// We emit null event with startWith
  Stream<List<Books>> getBooksList() {
    return _bookDao
        .watchBookBox()
        .startWith(null) // Emit an initial null event
        .map((_) => _bookDao.getAllBooksFromDB());
  }

  Stream<List<BookShelveVO>> getShelvesList() {
    return _shelvesDao
        .watchShelfBox()
        .startWith(null) // Emit an initial null event
        .map((_) => _shelvesDao.getAllShelves());
  }

  Stream<BookShelveVO?> getShelveVOByID(String id) {
    return _shelvesDao
        .watchShelfBox()
        .startWith(null) // Emit an initial null event
        .map((_) => _shelvesDao.getShelfById(id));
  }

  void updateShelfVOAddBook(String id, Books book) {
    return _shelvesDao.updateShelfByAddingBook(id, book);
  }

  Future<List<NyBookList>?> getNYBestSellerResponse(String apiKey) {
    return mDataAgent.getNYBooks(apiKey);
  }

  Future<Results?> getNYBestSellerByCategory(String apiKey, String Category) {
    return mDataAgent.getNYBooksByCategory(apiKey, Category);
  }
}
