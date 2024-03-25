import 'package:money_formatter/money_formatter.dart';

class TFormarter {
  static String moneyToString(
      {required double? money, bool returnEmpty = false}) {
    if (money == null) {
      return returnEmpty ? '' : '0.00';
    }
    MoneyFormatter fmf = new MoneyFormatter(
        amount: money,
        settings: MoneyFormatterSettings(
          decimalSeparator: '.',
          thousandSeparator: ',',
          fractionDigits: 2,
        ));

    return fmf.output.nonSymbol;
  }
}
