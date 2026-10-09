/**
 * Ses dosyası türünü istemcinin söylediği Content-Type'a değil, dosyanın ilk byte'larına bakarak belirler.
 * (Görseller için sharp zaten formatı kendisi algılıyor.)
 */
export function sniffAudio(buf: Buffer): { contentType: string; ext: string } | null {
  if (buf.length < 12) return null;
  const ascii = (start: number, end: number) => buf.toString('latin1', start, end);

  // MP4/M4A (Flutter `record` paketinin varsayılanı: AAC-LC .m4a)
  if (ascii(4, 8) === 'ftyp') return { contentType: 'audio/mp4', ext: 'm4a' };
  if (ascii(0, 4) === 'OggS') return { contentType: 'audio/ogg', ext: 'ogg' };
  if (ascii(0, 4) === 'RIFF' && ascii(8, 12) === 'WAVE') return { contentType: 'audio/wav', ext: 'wav' };
  if (ascii(0, 3) === 'ID3') return { contentType: 'audio/mpeg', ext: 'mp3' };
  // Ham AAC (ADTS) veya başlıksız MP3 çerçevesi: 0xFFF senkron bitleri
  if (buf[0] === 0xff && (buf[1]! & 0xf6) === 0xf0) return { contentType: 'audio/aac', ext: 'aac' };
  if (buf[0] === 0xff && (buf[1]! & 0xe0) === 0xe0) return { contentType: 'audio/mpeg', ext: 'mp3' };
  return null;
}
