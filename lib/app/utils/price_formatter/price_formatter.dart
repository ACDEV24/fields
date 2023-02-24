import 'package:intl/intl.dart';
import 'package:fields/app/utils/price_formatter/utils/compact_format_type.dart';
import 'package:fields/app/utils/price_formatter/utils/price_formatter_compare.dart';
import 'package:fields/app/utils/price_formatter/utils/price_formatter_output.dart';
import 'package:fields/app/utils/price_formatter/utils/price_formatter_settings.dart';

part 'package:fields/app/utils/price_formatter/utils/utilities.dart';

class TulPriceFormatter {
  final _Utilities _utilities;
  final double? amount;
  final PriceFormatterSettings settings;
  PriceFormatterOutput? output;
  final PriceFormatterCompare comparator;

  TulPriceFormatter({
    this.amount = 0.0,
    PriceFormatterSettings? settings,
    PriceFormatterCompare? comparator,
  })  : settings = settings ??= PriceFormatterSettings(),
        comparator = comparator ??= PriceFormatterCompare(),
        _utilities = _Utilities(amount: amount, settings: settings) {
    output = _getOutput();
  }

  PriceFormatterOutput _getOutput() {
    final urs = _utilities.refineSeparator;

    return PriceFormatterOutput(
      nonSymbol: urs,
      symbolOnLeft: '${settings.symbol}${_utilities.spacer}$urs',
      symbolOnRight: '$urs${_utilities.spacer}${settings.symbol}',
    );
  }

  TulPriceFormatter copyWith({
    double? amount,
    String? symbol,
    String? thousandSeparator,
    String? decimalSeparator,
    int? fractionDigits,
    String? symbolAndNumberSeparator,
    CompactFormatType? compactFormatType,
  }) {
    final ts = settings;

    final mfs = PriceFormatterSettings(
      symbol: symbol ??= ts.symbol,
      thousandSeparator: thousandSeparator ??= ts.thousandSeparator,
      decimalSeparator: decimalSeparator ??= ts.decimalSeparator,
      symbolAndNumberSeparator: symbolAndNumberSeparator ??=
          ts.symbolAndNumberSeparator,
      fractionDigits: fractionDigits ??= ts.fractionDigits,
      compactFormatType: compactFormatType ??= ts.compactFormatType,
    );

    return TulPriceFormatter(amount: amount ?? amount, settings: mfs);
  }
}
