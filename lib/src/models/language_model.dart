/// Language model from HadeethEnc API getLanguages endpoint
class LanguageModel {
  const LanguageModel({
    required this.code,
    required this.native,
    required this.direction,
  });

  final String code;
  final String native;
  final String direction; // 'rtl' or 'ltr'

  bool get isRtl => direction == 'rtl';

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      code: json['code'] as String? ?? '',
      native: json['native'] as String? ?? '',
      direction: json['direction'] as String? ?? 'ltr',
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'native': native,
        'direction': direction,
      };

  @override
  String toString() => 'LanguageModel(code: $code, native: $native)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModel &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}
