-- CreateTable
CREATE TABLE `users` (
    `id` CHAR(36) NOT NULL,
    `firebase_uid` VARCHAR(128) NOT NULL,
    `auth_provider` ENUM('GOOGLE', 'APPLE', 'PASSWORD', 'DEV', 'PERSONA') NOT NULL,
    `email` VARCHAR(255) NULL,
    `full_name` VARCHAR(100) NULL,
    `username` VARCHAR(30) NULL,
    `display_name` VARCHAR(50) NULL,
    `avatar_url` VARCHAR(512) NULL,
    `avatar_blur_url` VARCHAR(512) NULL,
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
    `suspended_until` DATETIME(3) NULL,
    `suspended_reason` VARCHAR(500) NULL,
    `checkin_day` TINYINT NOT NULL DEFAULT 0,
    `last_checkin_at` DATETIME(3) NULL,
    `boosted_until` DATETIME(3) NULL,
    `boost_level` TINYINT NOT NULL DEFAULT 0,
    `is_persona` BOOLEAN NOT NULL DEFAULT false,
    `last_seen_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `users_firebase_uid_key`(`firebase_uid`),
    UNIQUE INDEX `users_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `media` (
    `id` CHAR(36) NOT NULL,
    `owner_id` CHAR(36) NOT NULL,
    `kind` ENUM('AVATAR', 'AVATAR_BLUR', 'VOICE_INTRO', 'CHAT_IMAGE', 'CHAT_VOICE', 'POST_IMAGE', 'POST_THUMB') NOT NULL,
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
    `locale` VARCHAR(8) NOT NULL DEFAULT 'en',
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
    `is_private` BOOLEAN NOT NULL DEFAULT false,
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
    `name_shared` BOOLEAN NOT NULL DEFAULT false,
    `anonymous` BOOLEAN NOT NULL DEFAULT false,
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
    `media_id` CHAR(36) NULL,
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
    `context` ENUM('PROFILE', 'CHAT', 'CALL', 'ROOM', 'VIBE', 'GROUP', 'POST') NOT NULL,
    `conversation_id` CHAR(36) NULL,
    `content_id` CHAR(36) NULL,
    `reason` ENUM('HARASSMENT', 'HATE_SPEECH', 'NUDITY', 'UNDERAGE', 'SPAM', 'SCAM', 'VIOLENCE', 'IMPERSONATION', 'OTHER') NOT NULL,
    `details` VARCHAR(1000) NULL,
    `status` ENUM('OPEN', 'REVIEWING', 'ACTIONED', 'DISMISSED') NOT NULL DEFAULT 'OPEN',
    `resolution` VARCHAR(32) NULL,
    `admin_note` VARCHAR(1000) NULL,
    `resolved_at` DATETIME(3) NULL,
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
    `purge_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `processed_at` DATETIME(3) NULL,

    INDEX `account_deletion_requests_status_purge_at_idx`(`status`, `purge_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `token_ledger` (
    `id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `delta` INTEGER NOT NULL,
    `balance_after` INTEGER NOT NULL,
    `reason` ENUM('WELCOME_BONUS', 'PURCHASE', 'REFUND', 'ROOM_CREATE', 'ROOM_JOIN', 'CALL_GENDER_FILTER', 'VIDEO_CALL', 'BORDER_PURCHASE', 'POST_BOOST', 'ADMIN_ADJUST', 'DAILY_CHECKIN', 'PROFILE_BOOST') NOT NULL,
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

-- CreateTable
CREATE TABLE `notes` (
    `user_id` CHAR(36) NOT NULL,
    `text` VARCHAR(60) NOT NULL,
    `expires_at` DATETIME(3) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    INDEX `notes_expires_at_idx`(`expires_at`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `posts` (
    `id` CHAR(36) NOT NULL,
    `author_id` CHAR(36) NOT NULL,
    `status` ENUM('DRAFT', 'PUBLISHED') NOT NULL DEFAULT 'PUBLISHED',
    `media_url` VARCHAR(512) NOT NULL,
    `thumb_url` VARCHAR(512) NOT NULL,
    `width` SMALLINT NULL,
    `height` SMALLINT NULL,
    `caption` VARCHAR(500) NULL,
    `music` JSON NULL,
    `like_count` INTEGER NOT NULL DEFAULT 0,
    `comment_count` INTEGER NOT NULL DEFAULT 0,
    `view_count` INTEGER NOT NULL DEFAULT 0,
    `boosted_until` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    INDEX `posts_status_created_at_idx`(`status`, `created_at`),
    INDEX `posts_boosted_until_idx`(`boosted_until`),
    INDEX `posts_author_id_status_created_at_idx`(`author_id`, `status`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post_likes` (
    `post_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `post_likes_user_id_idx`(`user_id`),
    PRIMARY KEY (`post_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post_saves` (
    `post_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `post_saves_user_id_created_at_idx`(`user_id`, `created_at`),
    PRIMARY KEY (`post_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post_views` (
    `post_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`post_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `comments` (
    `id` CHAR(36) NOT NULL,
    `post_id` CHAR(36) NOT NULL,
    `author_id` CHAR(36) NOT NULL,
    `body` VARCHAR(500) NOT NULL,
    `deleted_at` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `comments_post_id_created_at_idx`(`post_id`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `calls` (
    `id` CHAR(36) NOT NULL,
    `user_a_id` CHAR(36) NOT NULL,
    `user_b_id` CHAR(36) NOT NULL,
    `a_filter` VARCHAR(16) NULL,
    `b_filter` VARCHAR(16) NULL,
    `started_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `revealed_at` DATETIME(3) NULL,
    `conversation_id` CHAR(36) NULL,
    `video_minutes` INTEGER NOT NULL DEFAULT 0,
    `ended_at` DATETIME(3) NULL,
    `end_reason` ENUM('HANGUP', 'TIMEOUT', 'DISCONNECT', 'NO_KEEP') NULL,

    INDEX `calls_user_a_id_started_at_idx`(`user_a_id`, `started_at`),
    INDEX `calls_user_b_id_started_at_idx`(`user_b_id`, `started_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `rooms` (
    `id` CHAR(36) NOT NULL,
    `host_id` CHAR(36) NOT NULL,
    `title` VARCHAR(60) NOT NULL,
    `is_private` BOOLEAN NOT NULL DEFAULT false,
    `host_anonymous` BOOLEAN NOT NULL DEFAULT false,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ended_at` DATETIME(3) NULL,

    INDEX `rooms_ended_at_created_at_idx`(`ended_at`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `room_join_requests` (
    `id` CHAR(36) NOT NULL,
    `room_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `message` VARCHAR(200) NULL,
    `anonymous` BOOLEAN NOT NULL DEFAULT false,
    `status` ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `room_join_requests_room_id_user_id_key`(`room_id`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `admin_actions` (
    `id` CHAR(36) NOT NULL,
    `actor` VARCHAR(100) NOT NULL,
    `action` VARCHAR(32) NOT NULL,
    `target_user_id` CHAR(36) NULL,
    `target_label` VARCHAR(100) NULL,
    `report_id` CHAR(36) NULL,
    `note` VARCHAR(1000) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `admin_actions_target_user_id_idx`(`target_user_id`),
    INDEX `admin_actions_created_at_idx`(`created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `media` ADD CONSTRAINT `media_owner_id_fkey` FOREIGN KEY (`owner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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

-- AddForeignKey
ALTER TABLE `notes` ADD CONSTRAINT `notes_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `posts` ADD CONSTRAINT `posts_author_id_fkey` FOREIGN KEY (`author_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `post_likes` ADD CONSTRAINT `post_likes_post_id_fkey` FOREIGN KEY (`post_id`) REFERENCES `posts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `post_likes` ADD CONSTRAINT `post_likes_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `post_saves` ADD CONSTRAINT `post_saves_post_id_fkey` FOREIGN KEY (`post_id`) REFERENCES `posts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `post_saves` ADD CONSTRAINT `post_saves_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `post_views` ADD CONSTRAINT `post_views_post_id_fkey` FOREIGN KEY (`post_id`) REFERENCES `posts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `post_views` ADD CONSTRAINT `post_views_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `comments_post_id_fkey` FOREIGN KEY (`post_id`) REFERENCES `posts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `comments_author_id_fkey` FOREIGN KEY (`author_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `calls` ADD CONSTRAINT `calls_user_a_id_fkey` FOREIGN KEY (`user_a_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `calls` ADD CONSTRAINT `calls_user_b_id_fkey` FOREIGN KEY (`user_b_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `rooms` ADD CONSTRAINT `rooms_host_id_fkey` FOREIGN KEY (`host_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `room_join_requests` ADD CONSTRAINT `room_join_requests_room_id_fkey` FOREIGN KEY (`room_id`) REFERENCES `rooms`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `room_join_requests` ADD CONSTRAINT `room_join_requests_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

