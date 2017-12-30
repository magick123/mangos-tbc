ALTER TABLE character_db_version CHANGE COLUMN required_s2325_02_characters required_s2327_01_characters_pvpstats bit;

ALTER TABLE pvpstats_players CHANGE COLUMN player_guid character_guid int(10) unsigned NOT NULL AFTER battleground_id;
ALTER TABLE character_db_version CHANGE COLUMN required_s2327_01_characters_pvpstats required_s2333_01_characters_reset_talents bit;

UPDATE characters SET at_login = at_login | 0x4;
ALTER TABLE character_db_version CHANGE COLUMN required_s2333_01_characters_reset_talents required_s2335_01_characters_wotlk_timer_port bit;

DROP TABLE IF EXISTS `character_queststatus_monthly`;
CREATE TABLE `character_queststatus_monthly` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';

ALTER TABLE saved_variables
ADD `NextMonthlyQuestResetTime` bigint(40) unsigned NOT NULL DEFAULT '0';
ALTER TABLE saved_variables
ADD `NextWeeklyQuestResetTime` bigint(40) unsigned NOT NULL DEFAULT '0';
ALTER TABLE character_db_version CHANGE COLUMN required_s2335_01_characters_wotlk_timer_port required_s2337_01_characters_weekly_quests bit;

DROP TABLE IF EXISTS `character_queststatus_weekly`;
CREATE TABLE `character_queststatus_weekly` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Player System';

ALTER TABLE character_db_version CHANGE COLUMN required_s2337_01_characters_weekly_quests required_s2343_01_characters_mangle_cleanup bit;

UPDATE characters as c JOIN character_spell as cs ON c.guid = cs.guid SET c.at_login = c.at_login | 4 WHERE cs.spell in (33876,33878,33982,33983,33986,33987,48563,48564,48565,48566);
DELETE FROM character_spell WHERE spell in (33876,33878,33982,33983,33986,33987,48563,48564,48565,48566);
ALTER TABLE character_db_version CHANGE COLUMN required_s2343_01_characters_mangle_cleanup required_s2345_01_characters_instance bit;

ALTER TABLE instance ADD COLUMN `encountersMask` int(10) unsigned NOT NULL DEFAULT '0' AFTER difficulty;


-- MySQL Manual Build
--
-- Host: localhost    Database: characters
-- ------------------------------------------------------

ALTER TABLE character_db_version CHANGE COLUMN required_s2345_01_characters_instance required_s2346_01_characters_playerbot_saved_data bit;

-- ----------------------------
-- Table structure for `playerbot_saved_data`
-- ----------------------------
DROP TABLE IF EXISTS `playerbot_saved_data`;
CREATE TABLE `playerbot_saved_data` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `bot_primary_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bot_secondary_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `primary_target` int(11) unsigned NOT NULL DEFAULT '0',
  `secondary_target` int(11) unsigned NOT NULL DEFAULT '0',
  `pname` varchar(12) NOT NULL DEFAULT '',
  `sname` varchar(12) NOT NULL DEFAULT '',
  `combat_delay` INT(11) unsigned NOT NULL DEFAULT '0',
  `auto_follow` INT(11) unsigned NOT NULL DEFAULT '1',
  `autoequip` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Persistent Playerbot settings per alt';
ALTER TABLE character_db_version CHANGE COLUMN required_s2346_01_characters_playerbot_saved_data required_s2352_01_characters_fix_revision bit;

ALTER TABLE character_db_version CHANGE COLUMN required_s2352_01_characters_fix_revision required_s2357_01_characters_spell_cooldown bit;

ALTER TABLE character_spell_cooldown CHANGE COLUMN guid LowGuid int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier, Low part';
ALTER TABLE character_spell_cooldown CHANGE COLUMN spell SpellId int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell Identifier';
ALTER TABLE character_spell_cooldown CHANGE COLUMN time SpellExpireTime bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell cooldown expire time';
ALTER TABLE character_spell_cooldown CHANGE COLUMN item ItemId int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Item Identifier' AFTER SpellExpireTime;
ALTER TABLE character_spell_cooldown ADD Category int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell category' AFTER SpellExpireTime;
ALTER TABLE character_spell_cooldown ADD CategoryExpireTime bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell category cooldown expire time' AFTER Category;ALTER TABLE character_db_version CHANGE COLUMN required_s2357_01_characters_spell_cooldown required_s2358_01_characters_event_group_chosen bit;

DROP TABLE IF EXISTS `event_group_chosen`;
CREATE TABLE `event_group_chosen` (
`eventGroup` mediumint(8) unsigned NOT NULL DEFAULT '0',
`entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
PRIMARY KEY (`eventGroup`,`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Quest Group picked';


ALTER TABLE character_db_version CHANGE COLUMN required_s2358_01_characters_event_group_chosen required_s2359_01_characters_account_instances_entered bit;

DROP TABLE IF EXISTS `account_instances_entered`;
CREATE TABLE `account_instances_entered` (
   `AccountId` INT(11) UNSIGNED NOT NULL COMMENT 'Player account',
   `ExpireTime` BIGINT(40) NOT NULL COMMENT 'Time when instance was entered',
   `InstanceId` INT(11) UNSIGNED NOT NULL COMMENT 'ID of instance entered',
   PRIMARY KEY(`AccountId`,`InstanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Instance reset limit system';
