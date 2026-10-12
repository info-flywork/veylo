-- AlterTable
ALTER TABLE `messages` ADD COLUMN `media_id` CHAR(36) NULL;

-- AlterTable
ALTER TABLE `users` ADD COLUMN `avatar_blur_url` VARCHAR(512) NULL;

-- CreateTable
CREATE TABLE `media` (
    `id` CHAR(36) NOT NULL,
    `owner_id` CHAR(36) NOT NULL,
    `kind` ENUM('AVATAR', 'AVATAR_BLUR', 'VOICE_INTRO', 'CHAT_IMAGE', 'CHAT_VOICE') NOT NULL,
    `path` VARCHAR(255) NOT NULL,
    `url` VARCHAR(512) NOT NULL,
    `content_type` VARCHAR(64) NOT NULL,
    `size` INTEGER NOT NULL,
    `width` SMALLINT NULL,
    `height` SMALLINT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `media_path_key`(`path`),
    INDEX `media_owner_id_kind_idx`(`owner_id`, `kind`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `media` ADD CONSTRAINT `media_owner_id_fkey` FOREIGN KEY (`owner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
