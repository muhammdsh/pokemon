import 'package:base_structure/core/request/request.dart';


class DefaultRequest extends Request {

  @override
  Map<String, dynamic> toJson() {
    return {"default": "1"};
  }

}