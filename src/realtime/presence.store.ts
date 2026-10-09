/**
 * Kim çevrimiçi: tamamen bellekte (tek Node süreci varsayımı).
 * Bir kullanıcı birden fazla cihazdan bağlı olabilir, bu yüzden socket id kümesi tutulur.
 * İleride birden fazla sunucuya geçilirse sadece bu sınıfın içi değişir.
 */
class PresenceStore {
  private sockets = new Map<string, Set<string>>();

  /** true dönerse kullanıcı bu bağlantıyla çevrimiçi oldu. */
  add(userId: string, socketId: string): boolean {
    let set = this.sockets.get(userId);
    const wasOffline = !set || set.size === 0;
    if (!set) {
      set = new Set();
      this.sockets.set(userId, set);
    }
    set.add(socketId);
    return wasOffline;
  }

  /** true dönerse kullanıcı tamamen çevrimdışı oldu. */
  remove(userId: string, socketId: string): boolean {
    const set = this.sockets.get(userId);
    if (!set) return false;
    set.delete(socketId);
    if (set.size === 0) {
      this.sockets.delete(userId);
      return true;
    }
    return false;
  }

  isOnline(userId: string): boolean {
    return (this.sockets.get(userId)?.size ?? 0) > 0;
  }

  get onlineCount(): number {
    return this.sockets.size;
  }
}

export const presence = new PresenceStore();
