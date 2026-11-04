-- Gönderi düzenleme: yazısız orijinal fotoğraf + editör katmanları (boş bırakılabilir).
ALTER TABLE `posts`
  ADD COLUMN `source_url` VARCHAR(512) NULL,
  ADD COLUMN `editor_state` JSON NULL;
