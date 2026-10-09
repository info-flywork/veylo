export interface StorageDriver {
  readonly name: string;
  /** Dosyayı verilen yola yazar (varsa üzerine yazar). */
  put(path: string, data: Buffer, contentType: string): Promise<void>;
  /** Dosyayı siler; yoksa hata vermez. */
  delete(path: string): Promise<void>;
  /** Dosyanın herkese açık (CDN) adresi. */
  publicUrl(path: string): string;
}
