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

