import crypto from 'node:crypto';
import type { StorageDriver } from './storage.types';

interface BunnyOptions {
  zone: string;
  password: string;
  /** Boş = Falkenstein (storage.bunnycdn.com). */
  region?: string;
  cdnUrl: string;
}

/**
 * Bunny Edge Storage HTTP API.
 * PUT/DELETE https://{region.}storage.bunnycdn.com/{zone}/{path}  (AccessKey: storage zone şifresi)
 * Dosyalar zone'a bağlı Pull Zone üzerinden (BUNNY_CDN_URL) servis edilir.
 */
export class BunnyStorage implements StorageDriver {
  readonly name = 'bunny';
  private readonly endpoint: string;
  private readonly cdnUrl: string;

  constructor(private readonly opts: BunnyOptions) {
    const host = opts.region ? `${opts.region}.storage.bunnycdn.com` : 'storage.bunnycdn.com';
    this.endpoint = `https://${host}/${opts.zone}`;
    this.cdnUrl = opts.cdnUrl.replace(/\/$/, '');
  }

  async put(path: string, data: Buffer, _contentType: string) {
    const res = await fetch(`${this.endpoint}/${path}`, {
      method: 'PUT',
      headers: {
        AccessKey: this.opts.password,
        'Content-Type': 'application/octet-stream',
        // Bunny dosyanın bozulmadan geldiğini bu özetle doğrular.
        Checksum: crypto.createHash('sha256').update(data).digest('hex').toUpperCase(),
      },
      body: new Uint8Array(data),
      signal: AbortSignal.timeout(30_000),
    });
    if (res.status !== 201 && res.status !== 200) {
      throw new Error(`Bunny upload failed (${res.status}): ${await res.text().catch(() => '')}`);
    }
  }

  async delete(path: string) {
    const res = await fetch(`${this.endpoint}/${path}`, {
      method: 'DELETE',
      headers: { AccessKey: this.opts.password },
      signal: AbortSignal.timeout(15_000),
    });
    if (!res.ok && res.status !== 404) {
      throw new Error(`Bunny delete failed (${res.status})`);
    }
  }

  publicUrl(path: string) {
    return `${this.cdnUrl}/${path}`;
  }
}
