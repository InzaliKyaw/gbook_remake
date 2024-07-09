

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbook_remake/data/vos/book_shelve_vo.dart';
import 'package:gbook_remake/persistance/daos/shelves_dao.dart';
import 'package:gbook_remake/utils/strings.dart';
import 'package:provider/provider.dart';

import '../data/model/gbook_model.dart';

class EditShelvesPage extends StatefulWidget{
  final String? shelfId;

  const EditShelvesPage({super.key,  required this.shelfId});

  @override
  State<StatefulWidget> createState() => _EditShelvesPageState();
}


class _EditShelvesPageState extends State<EditShelvesPage>{
  final shelfName = TextEditingController();
  final ShelvesDao _shelvesDao = ShelvesDao();

  @override
  void initState() {
    super.initState();
    if(widget.shelfId != null){
     BookShelveVO? bookShelveVO =  _shelvesDao.getShelfById(widget.shelfId ?? "");
     setState(() {
       shelfName.text = bookShelveVO?.shelveName ?? "";
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
            Navigator.pop(context);
        }, icon: const Icon(Icons.chevron_left,
        size: 32,)),
      ),
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: TextField(
          controller: shelfName,
          decoration: InputDecoration(
            hintText: kShelveName,
            focusColor: Colors.blue,
            fillColor: Colors.blue,
            suffixIcon: IconButton(onPressed: (){
              setState(() {
                shelfName.clear();
              });
            }, icon: const Icon(Icons.clear_rounded)),
            border: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
          ),
          maxLength: 50,
          onSubmitted: (value){
            if(widget.shelfId!= null){
              _shelvesDao.updateShelfNameById(widget.shelfId?? "", value);
            }else{
              _shelvesDao.createShelf(value);
            }
            Navigator.pop(context);
          },
        ),
      )),
    );
  }

}