class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languages() {
    return <Language>[
      Language(1, "🇬🇧", "English", "en"),
      Language(2, "🇵🇸", "العربية", "ar"),
    ];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Language && languageCode == other.languageCode;

  @override
  int get hashCode => languageCode.hashCode;
}
