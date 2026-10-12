-- AlterTable
ALTER TABLE `users` ADD COLUMN `is_persona` BOOLEAN NOT NULL DEFAULT false,
    MODIFY `auth_provider` ENUM('GOOGLE', 'APPLE', 'PASSWORD', 'DEV', 'PERSONA') NOT NULL;

