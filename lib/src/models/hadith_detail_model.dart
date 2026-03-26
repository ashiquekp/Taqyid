/// Detailed model for a single Hadith
class HadithDetailModel {
  const HadithDetailModel({
    required this.id,
    required this.title,
    required this.hadeeth,
    required this.attribution,
    required this.grade,
    required this.explanation,
    required this.hints,
    required this.wordsMeanings,
  });

  final String id;
  final String title;
  final String hadeeth;
  final String attribution;
  final String grade;
  final String explanation;
  final List<String> hints;
  final List<WordMeaning> wordsMeanings;

  factory HadithDetailModel.fromJson(Map<String, dynamic> json) {
    return HadithDetailModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      hadeeth: json['hadeeth']?.toString() ?? '',
      attribution: json['attribution']?.toString() ?? '',
      grade: json['grade']?.toString() ?? '',
      explanation: json['explanation']?.toString() ?? '',
      hints: (json['hints'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      wordsMeanings: (json['words_meanings'] as List<dynamic>?)
              ?.map((e) => WordMeaning.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'hadeeth': hadeeth,
        'attribution': attribution,
        'grade': grade,
        'explanation': explanation,
        'hints': hints,
        'words_meanings': wordsMeanings.map((e) => e.toJson()).toList(),
      };
}

class WordMeaning {
  const WordMeaning({
    required this.word,
    required this.meaning,
  });

  final String word;
  final String meaning;

  factory WordMeaning.fromJson(Map<String, dynamic> json) {
    return WordMeaning(
      word: json['word']?.toString() ?? '',
      meaning: json['meaning']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'word': word,
        'meaning': meaning,
      };
}
