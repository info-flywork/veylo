-- Sütun zaten varsa (önceki kayıt duplicate column ile durmuştu) tekrar ekleme.

SET @veylo_sql = (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = 'checkin_day') = 0,
  'ALTER TABLE `users` ADD COLUMN `checkin_day` TINYINT NOT NULL DEFAULT 0',
  'SELECT 1'
));
PREPARE veylo_stmt FROM @veylo_sql;
EXECUTE veylo_stmt;
DEALLOCATE PREPARE veylo_stmt;

SET @veylo_sql = (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = 'last_checkin_at') = 0,
  'ALTER TABLE `users` ADD COLUMN `last_checkin_at` DATETIME(3) NULL',
  'SELECT 1'
));
PREPARE veylo_stmt FROM @veylo_sql;
EXECUTE veylo_stmt;
DEALLOCATE PREPARE veylo_stmt;

SET @veylo_sql = (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = 'boosted_until') = 0,
  'ALTER TABLE `users` ADD COLUMN `boosted_until` DATETIME(3) NULL',
  'SELECT 1'
));
PREPARE veylo_stmt FROM @veylo_sql;
EXECUTE veylo_stmt;
DEALLOCATE PREPARE veylo_stmt;

SET @veylo_sql = (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = 'boost_level') = 0,
  'ALTER TABLE `users` ADD COLUMN `boost_level` TINYINT NOT NULL DEFAULT 0',
  'SELECT 1'
));
PREPARE veylo_stmt FROM @veylo_sql;
EXECUTE veylo_stmt;
DEALLOCATE PREPARE veylo_stmt;

ALTER TABLE `token_ledger` MODIFY `reason` ENUM('WELCOME_BONUS', 'PURCHASE', 'REFUND', 'ROOM_CREATE', 'ROOM_JOIN', 'CALL_GENDER_FILTER', 'VIDEO_CALL', 'BORDER_PURCHASE', 'POST_BOOST', 'ADMIN_ADJUST', 'DAILY_CHECKIN', 'PROFILE_BOOST') NOT NULL;
