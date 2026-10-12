-- AlterTable
ALTER TABLE `conversation_members` ADD COLUMN `anonymous` BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE `conversations` ADD COLUMN `is_private` BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE `reports` MODIFY `context` ENUM('PROFILE', 'CHAT', 'CALL', 'ROOM', 'VIBE', 'GROUP') NOT NULL;

-- CreateTable
CREATE TABLE `group_join_requests` (
    `id` CHAR(36) NOT NULL,
    `conversation_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `message` VARCHAR(200) NULL,
    `anonymous` BOOLEAN NOT NULL DEFAULT false,
    `status` ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    `decided_by_id` CHAR(36) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    INDEX `group_join_requests_conversation_id_status_idx`(`conversation_id`, `status`),
    UNIQUE INDEX `group_join_requests_conversation_id_user_id_key`(`conversation_id`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vibes` (
    `id` CHAR(36) NOT NULL,
    `author_id` CHAR(36) NOT NULL,
    `body` VARCHAR(280) NOT NULL,
    `anonymous` BOOLEAN NOT NULL DEFAULT true,
    `like_count` INTEGER NOT NULL DEFAULT 0,
    `expires_at` DATETIME(3) NOT NULL,
    `deleted_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `vibes_expires_at_created_at_idx`(`expires_at`, `created_at`),
    INDEX `vibes_author_id_created_at_idx`(`author_id`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vibe_likes` (
    `vibe_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `vibe_likes_user_id_idx`(`user_id`),
    PRIMARY KEY (`vibe_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `group_join_requests` ADD CONSTRAINT `group_join_requests_conversation_id_fkey` FOREIGN KEY (`conversation_id`) REFERENCES `conversations`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `group_join_requests` ADD CONSTRAINT `group_join_requests_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vibes` ADD CONSTRAINT `vibes_author_id_fkey` FOREIGN KEY (`author_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vibe_likes` ADD CONSTRAINT `vibe_likes_vibe_id_fkey` FOREIGN KEY (`vibe_id`) REFERENCES `vibes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vibe_likes` ADD CONSTRAINT `vibe_likes_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

