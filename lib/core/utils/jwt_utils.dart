import 'dart:convert';


Map<String, dynamic> decodeJwtPayload(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw FormatException('Invalid JWT');
  }
  final payloadBase64 = parts[1]
      .replaceAll('-', '+')
      .replaceAll('_', '/');
  final normalized = base64Url.normalize(payloadBase64);
  final payloadString = utf8.decode(base64Url.decode(normalized));
  return jsonDecode(payloadString) as Map<String, dynamic>;
}
