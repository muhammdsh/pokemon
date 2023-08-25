import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/error/http/forbidden_error.dart';
import 'package:base_structure/core/result/result.dart';

// abstract class Expirable {
//   void expire(Result result) {
//     if (result.hasErrorOnly && result.error is ForbiddenError) {
//       locator<AuthBloc>().logout();
//     }
//     return;
//   }
// }
