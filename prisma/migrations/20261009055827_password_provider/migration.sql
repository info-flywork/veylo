-- AlterTable
ALTER TABLE `users` MODIFY `auth_provider` ENUM('GOOGLE', 'APPLE', 'PASSWORD', 'DEV') NOT NULL;
