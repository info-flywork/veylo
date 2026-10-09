import fs from 'node:fs/promises';
import path from 'node:path';
import type { StorageDriver } from './storage.types';

/** Sadece geliştirme: Bunny ayarlı değilken dosyaları ./uploads altına yazar, Express servis eder. */
export class LocalStorage implements StorageDriver {
  readonly name = 'local';

  constructor(
    readonly root: string,
    private readonly baseUrl: string,
  ) {}

  async put(rel: string, data: Buffer) {
    const full = path.join(this.root, rel);
    await fs.mkdir(path.dirname(full), { recursive: true });
    await fs.writeFile(full, data);
  }

  async delete(rel: string) {
    await fs.rm(path.join(this.root, rel), { force: true });
  }

  publicUrl(rel: string) {
    return `${this.baseUrl}/uploads/${rel}`;
  }
}
