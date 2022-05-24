class Role {
  final int id;
  final String nameAr;
  final String nameEn;

  Role({required this.id, required this.nameAr, required this.nameEn});

  factory Role.fromJson(Map json) {
    return Role(id: json['id'], nameAr: json['nameAr'], nameEn: json['nameEn']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameAr': nameAr,
        'nameEn': nameEn
      }..removeWhere((key, value) => value == null);
}
