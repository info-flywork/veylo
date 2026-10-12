import { BORDER_CATALOG, TOKEN_PRODUCTS } from '../config/constants';
import { AppError } from '../errors/AppError';
import { prisma } from '../lib/prisma';
import { tokenService } from './token.service';

async function listBorders(userId: string) {
  const owned = await prisma.ownedItem.findMany({
    where: { userId, itemType: 'BORDER' },
    select: { itemId: true },
  });
  const ownedSet = new Set(owned.map((o) => o.itemId));
  return Object.entries(BORDER_CATALOG).map(([id, price]) => ({ id, price, owned: ownedSet.has(id) }));
}

/** Çerçeveyi token ile satın alır ve hemen takar. Zaten sahipse sadece takar. */
async function purchaseBorder(userId: string, borderId: string) {
  const price = BORDER_CATALOG[borderId];
  if (price === undefined) throw AppError.notFound('UNKNOWN_BORDER');

  return prisma.$transaction(async (tx) => {
    const key = { userId_itemType_itemId: { userId, itemType: 'BORDER' as const, itemId: borderId } };
    const already = await tx.ownedItem.findUnique({ where: key });
    let balance: number;
    if (already) {
      balance = (await tx.user.findUniqueOrThrow({ where: { id: userId } })).tokenBalance;
    } else {
      ({ balance } = await tokenService.spend(tx, userId, price, 'BORDER_PURCHASE', `border:${userId}:${borderId}`));
      await tx.ownedItem.create({ data: { userId, itemType: 'BORDER', itemId: borderId } });
    }
    await tx.user.update({ where: { id: userId }, data: { borderId } });
    return { borderId, balance, charged: already ? 0 : price };
  });
}

function listTokenProducts() {
  return Object.entries(TOKEN_PRODUCTS).map(([productId, tokens]) => ({ productId, tokens }));
}

export const storeService = { listBorders, purchaseBorder, listTokenProducts };
