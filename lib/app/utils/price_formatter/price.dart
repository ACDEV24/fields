import 'package:fields/app/utils/price_formatter/price_formatter.dart';
import 'package:fields/app/utils/price_formatter/utils/compact_format_type.dart';
import 'package:fields/app/utils/price_formatter/utils/price_formatter_settings.dart';

class Price {
  static String format(
    number, {
    bool decimal = true,
    num decimalAmount = 0,
    bool negative = false,
    bool currency = true,
  }) {
    number = double.parse((number ?? 0).toString());
    number = negative && number > 0 ? number * -1 : number;

    final formatter = TulPriceFormatter(
      amount: number ?? 0.0,
      settings: PriceFormatterSettings(
        symbol: '\$',
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: '',
        fractionDigits: 0,
        compactFormatType: CompactFormatType.short,
      ),
    );

    final text = formatter.output?.symbolOnLeft ?? '';

    if (negative && text.contains('-')) {
      return _negativeToRight(text);
    }

    return formatter.output?.symbolOnLeft ?? '';
  }

  static String _negativeToRight(String text) {
    return '-\$${text.split('-')[1]}';
  }
}
