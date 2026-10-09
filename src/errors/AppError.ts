export class AppError extends Error {
  constructor(
    public readonly status: number,
    public readonly code: string,
    message?: string,
  ) {
    super(message ?? code);
  }

  static badRequest(code = 'BAD_REQUEST', message?: string) {
    return new AppError(400, code, message);
  }
  static unauthorized(code = 'UNAUTHORIZED', message?: string) {
    return new AppError(401, code, message);
  }
  static forbidden(code = 'FORBIDDEN', message?: string) {
    return new AppError(403, code, message);
  }
  static notFound(code = 'NOT_FOUND', message?: string) {
    return new AppError(404, code, message);
  }
  static conflict(code = 'CONFLICT', message?: string) {
    return new AppError(409, code, message);
  }
  /** Yetersiz token: uygulama bu kodu görünce mağaza sheet'ini açar. */
  static insufficientTokens(required: number, balance: number) {
    return new AppError(402, 'INSUFFICIENT_TOKENS', `required=${required} balance=${balance}`);
  }
}
