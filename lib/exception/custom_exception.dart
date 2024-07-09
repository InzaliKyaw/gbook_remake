
import 'package:gbook_remake/data/vos/error_vo.dart';

class CustomException implements Exception{
  final ErrorVO errorVO;

  CustomException(this.errorVO);

}