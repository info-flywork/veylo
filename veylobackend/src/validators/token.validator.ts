import { z } from 'zod';
import { BOOST_OPTIONS, TOKEN_PRODUCTS } from '../config/constants';

export const borderParams = z.object({ borderId: z.string().min(1).max(32) });

export const boostBody = z.object({
  option: z.enum(Object.keys(BOOST_OPTIONS) as [keyof typeof BOOST_OPTIONS, ...(keyof typeof BOOST_OPTIONS)[]]),
});

export const testPurchaseBody = z.object({
  productId: z.enum(Object.keys(TOKEN_PRODUCTS) as [string, ...string[]]),
});
