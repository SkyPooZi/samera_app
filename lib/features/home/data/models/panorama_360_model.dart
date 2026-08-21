import '../../domain/entities/panorama_360_entity.dart';

class Panorama360Model extends Panorama360Entity {
  const Panorama360Model({
    required super.enabled,
    super.asset,
    required super.label,
  });

  factory Panorama360Model.fromJson(Map<String, dynamic> json) {
    return Panorama360Model(
      enabled: json['enabled'] ?? false,
      asset: json['asset'],
      label: json['label'] ?? '360° Tour',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'asset': asset,
      'label': label,
    };
  }
}
