import type { NextFunction, Request, Response } from 'express';
import type { ZodType } from 'zod';

interface Schemas {
  body?: ZodType;
  query?: ZodType;
  params?: ZodType;
}

/** Gelen isteği zod ile doğrular; ayrıştırılmış değerleri req.valid'e koyar. */
export function validate(schemas: Schemas) {
  return (req: Request, _res: Response, next: NextFunction) => {
    req.valid = {
      body: schemas.body ? schemas.body.parse(req.body ?? {}) : undefined,
      query: schemas.query ? schemas.query.parse(req.query) : undefined,
      params: schemas.params ? schemas.params.parse(req.params) : undefined,
    };
    next();
  };
}
