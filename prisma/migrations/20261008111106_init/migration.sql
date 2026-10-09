-- CreateTable
CREATE TABLE `users` (
    `id` CHAR(36) NOT NULL,
    `firebase_uid` VARCHAR(128) NOT NULL,
    `auth_provider` ENUM('GOOGLE', 'APPLE', 'DEV') NOT NULL,
    `email` VARCHAR(255) NULL,
    `full_name` VARCHAR(100) NULL,
    `username` VARCHAR(30) NULL,
    `display_name` VARCHAR(50) NULL,
    `avatar_url` VARCHAR(512) NULL,
    `bio` VARCHAR(160) NULL,
    `gender` ENUM('FEMALE', 'MALE', 'NON_BINARY', 'PREFER_NOT_TO_SAY') NULL,
    `interests` JSON NULL,
    `chat_goal` VARCHAR(32) NULL,
    `height_cm` SMALLINT NULL,
    `languages` JSON NULL,
    `relationship_goal` VARCHAR(32) NULL,
    `zodiac` VARCHAR(16) NULL,
    `education` VARCHAR(16) NULL,
    `pets` VARCHAR(24) NULL,
    `drinking` VARCHAR(24) NULL,
    `smoking` VARCHAR(24) NULL,
    `voice_intro_url` VARCHAR(512) NULL,
    `border_id` VARCHAR(32) NULL,
    `profile_visible` BOOLEAN NOT NULL DEFAULT true,
    `onboarding_completed` BOOLEAN NOT NULL DEFAULT false,
    `token_balance` INTEGER NOT NULL DEFAULT 0,
    `status` ENUM('ACTIVE', 'SUSPENDED', 'DELETION_REQUESTED') NOT NULL DEFAULT 'ACTIVE',
    `last_seen_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `users_firebase_uid_key`(`firebase_uid`),
    UNIQUE INDEX `users_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `follows` (
    `follower_id` CHAR(36) NOT NULL,
    `following_id` CHAR(36) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `follows_following_id_created_at_idx`(`following_id`, `created_at`),
    PRIMARY KEY (`follower_id`, `following_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `device_tokens` (
    `id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `token` VARCHAR(255) NOT NULL,
    `platform` VARCHAR(16) NOT NULL,
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `device_tokens_token_key`(`token`),
    INDEX `device_tokens_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `conversations` (
    `id` CHAR(36) NOT NULL,
    `type` ENUM('DIRECT', 'ANONYMOUS', 'GROUP') NOT NULL,
    `status` ENUM('PENDING', 'ACCEPTED', 'REJECTED') NOT NULL DEFAULT 'ACCEPTED',
    `pair_key` VARCHAR(80) NULL,
    `initiator_id` CHAR(36) NOT NULL,
    `title` VARCHAR(80) NULL,
    `connection_progress` TINYINT NOT NULL DEFAULT 0,
    `revealed_at` DATETIME(3) NULL,
    `context_quote` VARCHAR(160) NULL,
    `last_seq` INTEGER NOT NULL DEFAULT 0,
    `last_sender_id` CHAR(36) NULL,
    `last_message_at` DATETIME(3) NULL,
    `last_message_preview` VARCHAR(120) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    INDEX `conversations_last_message_at_idx`(`last_message_at`),
    UNIQUE INDEX `conversations_type_pair_key_key`(`type`, `pair_key`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `conversation_members` (
    `conversation_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `role` ENUM('OWNER', 'ADMIN', 'MEMBER') NOT NULL DEFAULT 'MEMBER',
    `alias` VARCHAR(40) NULL,
    `last_read_seq` INTEGER NOT NULL DEFAULT 0,
    `cleared_seq` INTEGER NOT NULL DEFAULT 0,
    `hidden` BOOLEAN NOT NULL DEFAULT false,
    `pinned` BOOLEAN NOT NULL DEFAULT false,
    `muted` BOOLEAN NOT NULL DEFAULT false,
    `reveal_consent` BOOLEAN NOT NULL DEFAULT false,
    `joined_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `conversation_members_user_id_idx`(`user_id`),
    PRIMARY KEY (`conversation_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `messages` (
    `id` CHAR(36) NOT NULL,
    `conversation_id` CHAR(36) NOT NULL,
    `seq` INTEGER NOT NULL,
    `sender_id` CHAR(36) NOT NULL,
    `client_msg_id` VARCHAR(64) NOT NULL,
    `type` ENUM('TEXT', 'IMAGE', 'VOICE', 'SYSTEM') NOT NULL DEFAULT 'TEXT',
    `body` TEXT NULL,
    `media_url` VARCHAR(512) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `messages_conversation_id_seq_key`(`conversation_id`, `seq`),
    UNIQUE INDEX `messages_sender_id_client_msg_id_key`(`sender_id`, `client_msg_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blocks` (
    `blocker_id` CHAR(36) NOT NULL,
    `blocked_id` CHAR(36) NOT NULL,
    `type` ENUM('BLOCK', 'RESTRICT') NOT NULL,
    `anonymous` BOOLEAN NOT NULL DEFAULT false,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `blocks_blocked_id_idx`(`blocked_id`),
    PRIMARY KEY (`blocker_id`, `blocked_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reports` (
    `id` CHAR(36) NOT NULL,
    `reporter_id` CHAR(36) NOT NULL,
    `target_user_id` CHAR(36) NOT NULL,
    `context` ENUM('PROFILE', 'CHAT', 'CALL', 'ROOM') NOT NULL,
    `conversation_id` CHAR(36) NULL,
    `reason` ENUM('HARASSMENT', 'HATE_SPEECH', 'NUDITY', 'UNDERAGE', 'SPAM', 'SCAM', 'VIOLENCE', 'IMPERSONATION', 'OTHER') NOT NULL,
    `details` VARCHAR(1000) NULL,
    `status` ENUM('OPEN', 'REVIEWING', 'ACTIONED', 'DISMISSED') NOT NULL DEFAULT 'OPEN',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    INDEX `reports_status_created_at_idx`(`status`, `created_at`),
    INDEX `reports_target_user_id_idx`(`target_user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `account_deletion_requests` (
    `id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `reason` VARCHAR(1000) NULL,
    `status` ENUM('PENDING', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `account_deletion_requests_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `token_ledger` (
    `id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `delta` INTEGER NOT NULL,
    `balance_after` INTEGER NOT NULL,
    `reason` ENUM('WELCOME_BONUS', 'PURCHASE', 'REFUND', 'ROOM_CREATE', 'ROOM_JOIN', 'CALL_GENDER_FILTER', 'VIDEO_CALL', 'BORDER_PURCHASE', 'POST_BOOST', 'ADMIN_ADJUST') NOT NULL,
    `ref_id` VARCHAR(128) NULL,
    `meta` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `token_ledger_user_id_created_at_idx`(`user_id`, `created_at`),
    UNIQUE INDEX `token_ledger_reason_ref_id_key`(`reason`, `ref_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `owned_items` (
    `user_id` CHAR(36) NOT NULL,
    `item_type` ENUM('BORDER', 'FONT') NOT NULL,
    `item_id` VARCHAR(32) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`user_id`, `item_type`, `item_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `follows` ADD CONSTRAINT `follows_follower_id_fkey` FOREIGN KEY (`follower_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `follows` ADD CONSTRAINT `follows_following_id_fkey` FOREIGN KEY (`following_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `device_tokens` ADD CONSTRAINT `device_tokens_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `conversation_members` ADD CONSTRAINT `conversation_members_conversation_id_fkey` FOREIGN KEY (`conversation_id`) REFERENCES `conversations`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `conversation_members` ADD CONSTRAINT `conversation_members_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `messages` ADD CONSTRAINT `messages_conversation_id_fkey` FOREIGN KEY (`conversation_id`) REFERENCES `conversations`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `messages` ADD CONSTRAINT `messages_sender_id_fkey` FOREIGN KEY (`sender_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blocks` ADD CONSTRAINT `blocks_blocker_id_fkey` FOREIGN KEY (`blocker_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blocks` ADD CONSTRAINT `blocks_blocked_id_fkey` FOREIGN KEY (`blocked_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reports` ADD CONSTRAINT `reports_reporter_id_fkey` FOREIGN KEY (`reporter_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reports` ADD CONSTRAINT `reports_target_user_id_fkey` FOREIGN KEY (`target_user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `account_deletion_requests` ADD CONSTRAINT `account_deletion_requests_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `token_ledger` ADD CONSTRAINT `token_ledger_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `owned_items` ADD CONSTRAINT `owned_items_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
