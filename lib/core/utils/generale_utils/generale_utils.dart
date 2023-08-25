
class GeneralUtils {
  static RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  static String Function(Match match) mathFunc = (Match match) => '${match[1]},';

  static String formatNumber(double number) {
    return number.round().toString().replaceAllMapped(reg, mathFunc);
  }


}
