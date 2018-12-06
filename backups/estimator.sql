-- Adminer 4.7.0 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `answer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `last_score` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DADD4A251E27F6BF` (`question_id`),
  KEY `IDX_DADD4A25166D1F9C` (`project_id`),
  CONSTRAINT `FK_DADD4A25166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `FK_DADD4A251E27F6BF` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `answer` (`id`, `question_id`, `answer`, `project_id`, `last_score`) VALUES
(1,	1,	'0',	10,	-0.5),
(2,	2,	'0',	10,	0),
(3,	3,	'0',	10,	0),
(4,	4,	'0',	10,	0),
(5,	5,	'0',	10,	0),
(6,	6,	'0',	10,	0),
(7,	7,	'0',	10,	0),
(8,	8,	'0',	10,	0),
(9,	9,	'0',	10,	0),
(10,	10,	'0',	10,	0),
(11,	11,	'0',	10,	0),
(12,	12,	'0',	10,	0),
(13,	13,	'0',	10,	0),
(14,	14,	'0',	10,	0),
(15,	15,	'0',	10,	0),
(16,	16,	'0',	10,	0),
(17,	17,	'0',	10,	0),
(18,	18,	'0',	10,	0),
(19,	19,	'0',	10,	0),
(20,	20,	'0',	10,	-0.9),
(21,	21,	'0',	10,	0),
(22,	22,	'0',	10,	0),
(23,	23,	'0',	10,	0),
(24,	24,	'0',	10,	0),
(25,	25,	'0',	10,	-0),
(26,	26,	'0',	10,	0),
(27,	1,	'n',	11,	NULL),
(28,	2,	'y',	11,	NULL),
(29,	3,	'y',	11,	NULL),
(30,	4,	'y',	11,	NULL),
(31,	5,	'10',	11,	NULL),
(32,	6,	'30',	11,	NULL),
(33,	7,	'0',	11,	NULL),
(34,	8,	'10',	11,	NULL),
(35,	9,	'y',	11,	NULL),
(36,	10,	'10',	11,	NULL),
(37,	11,	'y',	11,	NULL),
(38,	12,	'y',	11,	NULL),
(39,	13,	'y',	11,	NULL),
(40,	14,	'y',	11,	NULL),
(41,	15,	'y',	11,	NULL),
(42,	16,	'y',	11,	NULL),
(43,	17,	'y',	11,	NULL),
(44,	18,	'y',	11,	NULL),
(45,	19,	'y',	11,	NULL),
(46,	20,	'n',	11,	NULL),
(47,	21,	'y',	11,	NULL),
(48,	22,	'y',	11,	NULL),
(49,	23,	'y',	11,	NULL),
(50,	24,	'y',	11,	NULL),
(51,	25,	'1',	11,	NULL),
(52,	26,	'n',	11,	NULL);

DROP TABLE IF EXISTS `migration_versions`;
CREATE TABLE `migration_versions` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `migration_versions` (`version`) VALUES
('20181206101115'),
('20181206101811'),
('20181206103212'),
('20181206103439'),
('20181206114721'),
('20181206115413'),
('20181206135346'),
('20181206160150');

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` double DEFAULT NULL,
  `estimation` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `project` (`id`, `score`, `estimation`) VALUES
(10,	-1.4,	-42.583333333333),
(11,	NULL,	NULL);

DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` double NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `question_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `question` (`id`, `name`, `question_text`, `weight`, `description`, `question_order`) VALUES
(1,	'author_is_same',	'Is the code authored by the same person? (y/n)',	0.5,	'',	1),
(2,	'third_party',	'Does it integrate with third-party software? (y/n)',	0.3,	'',	2),
(3,	'login_system',	'Does the it require a login system? (y/n)',	0.2,	'',	3),
(4,	'email_templating',	'Will it require email templating? (y/n)',	0.2,	'',	4),
(5,	'custom_design_level',	'What is the graphic design effort level (0-10)?',	0.6,	'',	5),
(6,	'screens_num',	'How many different screens? (1-...)',	0.7,	'Different screens include pop-ups and data regenerated  in the same screen.',	6),
(7,	'code_age',	'How old is the code base (in months)? (0-...)',	0.7,	'The number of months a code base has since start.',	7),
(8,	'complexity_level',	'How complex would you rate this code (0-10)?',	0.8,	'',	8),
(9,	'two_fa',	'Two Factor Authentication required? (y/n)',	0.5,	'',	9),
(10,	'security_level',	'What would the security level be? (0-10)',	0.4,	'',	10),
(11,	'eommerce',	'Is this for or a complete eCommerce piece of software? (y/n)',	0.7,	'',	11),
(12,	'video',	'Will it include video? (y/n)',	0.2,	'',	12),
(13,	'cms',	'Is this a part or the start of a CMS? (y/n)',	0.6,	'',	100),
(14,	'admin',	'Will it require backend administration? (y/n)',	0.7,	'',	120),
(15,	'statistics',	'Will it require statistical analysis or a dashboard of the sorts? (y/n)',	0.2,	'',	150),
(16,	'google_analytics',	'Will it require google analytics? (yes/no)',	0.1,	'',	200),
(17,	'custom_analytics',	'Will it require custom analytics? (yes/no)',	0.6,	'',	210),
(18,	'data_migration',	'Will it require data migration of sorts? (y/n)',	0.5,	'',	220),
(19,	'existing_database',	'Does it make use of an existing database? (y/n)',	0.8,	'',	240),
(20,	'server_control',	'Do we have control over all environment servers? (y/n)',	0.9,	'',	300),
(21,	'user_management',	'Does it require user management? (y/n)',	0.6,	'',	310),
(22,	'notifications',	'Will it require a notification system? (y/n)',	0.3,	'',	330),
(23,	'user_walls',	'Will it make use of a user forum \"wall\"? (y/n)',	0.5,	'',	350),
(24,	'time_constraints',	'Are there hard time constraints? (y/n)',	0.8,	'',	400),
(25,	'number_of_developers',	'How many developers will be working on this? (1-...)',	0.5,	'',	450),
(26,	'domain_familiarity',	'Does the team or developer have familiarity with the business domain? (y/n)',	0.6,	'',	500);

-- 2018-12-06 16:50:11
