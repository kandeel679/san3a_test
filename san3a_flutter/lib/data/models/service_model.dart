/// Mirrors domain/entity/Service.kt
class Service {
  final String id;
  final String title;
  final String description;
  final List<String> suggestions;
  final String imageUrl;
  final String hint;
  final String iconImageUrl;
  final String colorCode;

  const Service({
    required this.id,
    required this.title,
    required this.description,
    required this.suggestions,
    required this.imageUrl,
    required this.hint,
    required this.iconImageUrl,
    required this.colorCode,
  });

  factory Service.fromJson(Map<String, dynamic> data, String id) {
    return Service(
      id: id,
      title: data['title']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      suggestions: (data['suggestions'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      imageUrl: data['imageUrl']?.toString() ?? '',
      hint: data['hint']?.toString() ?? '',
      iconImageUrl: data['iconImageUrl']?.toString() ?? '',
      colorCode: data['colorCode']?.toString() ?? '',
    );
  }
}
