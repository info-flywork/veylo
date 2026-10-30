ALTER TABLE `conversation_members`
  ADD COLUMN `photo_shared` BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN `profile_shared` BOOLEAN NOT NULL DEFAULT false;
