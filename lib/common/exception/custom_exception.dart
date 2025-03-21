class BadRequestException implements Exception {
  final String message;
  final int code;
  final String url;

  const BadRequestException([
    this.message = "",
    this.code = 400,
    this.url = '',
  ]);
}

class ForbiddenException implements Exception {
  final String message;
  final int code;
  final String url;

  const ForbiddenException([this.message = "", this.code = 403, this.url = '']);
}

class UnauthorizedException implements Exception {
  final String message;
  final int code;
  final String url;

  const UnauthorizedException([
    this.message = "",
    this.code = 401,
    this.url = '',
  ]);
}
