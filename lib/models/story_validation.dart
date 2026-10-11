import 'dart:convert';

/// Validacion estructural compartida por el catalogo y la carga diferida.
Never narrativeError(String story, String affected, String cause) {
  throw FormatException('Historia "$story", "$affected": $cause');
}

Object? decodeNarrative(String source, String story, String affected) {
  try {
    return jsonDecode(source);
  } on FormatException catch (error) {
    narrativeError(story, affected, 'JSON invalido: ${error.message}');
  }
}

Map<String, dynamic> narrativeObject(
    Object? value, String story, String affected) {
  if (value is! Map<String, dynamic>) {
    narrativeError(story, affected, 'se esperaba un objeto JSON');
  }
  return value;
}

String narrativeString(
    Map<String, dynamic> data, String field, String story, String affected,
    {bool allowEmpty = false}) {
  final value = data[field];
  if (value is! String || (!allowEmpty && value.trim().isEmpty)) {
    narrativeError(story, affected,
        '$field debe ser texto${allowEmpty ? '' : ' no vacio'}');
  }
  return value;
}

String narrativeStoryId(Map<String, dynamic> data) {
  return narrativeString(data, 'id', '${data['id'] ?? '<sin ID>'}', 'id');
}

int narrativeDuration(Map<String, dynamic> data, String story) {
  final value = data['estimatedDuration'];
  if (value is! int || value < 0) {
    narrativeError(
        story, 'estimatedDuration', 'debe ser un entero no negativo');
  }
  return value;
}

void uniqueStoryIds(Iterable<String> ids) {
  final seen = <String>{};
  for (final id in ids) {
    if (!seen.add(id)) narrativeError(id, id, 'ID de historia duplicado');
  }
}
