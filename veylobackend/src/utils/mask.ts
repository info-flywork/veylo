/** "Jessica" → "J******" (Flutter'daki maskeli ad formatı). */
export function maskName(name: string | null | undefined): string {
  const clean = (name ?? '').trim();
  if (!clean) return 'S***';
  return clean[0]!.toUpperCase() + '*'.repeat(Math.max(3, clean.length - 1));
}

/** İki kullanıcı için sıralı, benzersiz çift anahtarı. */
export function pairKey(a: string, b: string): string {
  return a < b ? `${a}:${b}` : `${b}:${a}`;
}
