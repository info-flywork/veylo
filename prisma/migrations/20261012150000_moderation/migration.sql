-- DropIndex
DROP INDEX `account_deletion_requests_status_idx` ON `account_deletion_requests`;

-- AlterTable
ALTER TABLE `account_deletion_requests` ADD COLUMN `processed_at` DATETIME(3) NULL,
    ADD COLUMN `purge_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `reports` ADD COLUMN `admin_note` VARCHAR(1000) NULL,
    ADD COLUMN `content_id` CHAR(36) NULL,
    ADD COLUMN `resolution` VARCHAR(32) NULL,
    ADD COLUMN `resolved_at` DATETIME(3) NULL;

-- AlterTable
ALTER TABLE `users` ADD COLUMN `suspended_reason` VARCHAR(500) NULL,
    ADD COLUMN `suspended_until` DATETIME(3) NULL;

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

-- CreateIndex
CREATE INDEX `account_deletion_requests_status_purge_at_idx` ON `account_deletion_requests`(`status`, `purge_at`);


-- Mevcut silme istekleri: istekten 30 gün sonra silinsin.
UPDATE `account_deletion_requests` SET `purge_at` = DATE_ADD(`created_at`, INTERVAL 30 DAY);

-- Eski vibe/gönderi şikayetlerinde içerik id'si açıklamanın ilk satırındaydı ("vibe:<id>" / "post:<id>").
UPDATE `reports` SET `content_id` = SUBSTRING(`details`, 6, 36) WHERE `context` = 'VIBE' AND `details` LIKE 'vibe:%';
UPDATE `reports` SET `content_id` = SUBSTRING(`details`, 6, 36) WHERE `context` = 'POST' AND `details` LIKE 'post:%';
