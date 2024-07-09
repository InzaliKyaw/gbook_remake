import 'package:gbook_remake/persistance/hive_constant.dart';
import 'package:hive_flutter/adapters.dart';
import 'book_vo.dart';
part 'book_shelve_vo.g.dart';

@HiveType(typeId: kHiveTypeIdShelve,adapterName: kAdapterShelvesVO)
class BookShelveVO{

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? shelveName;

  @HiveField(2)
  List<Books>? bookCollectionList;

  BookShelveVO({this.id,
    this.shelveName,
    this.bookCollectionList});
}