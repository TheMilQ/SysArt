-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sysartdb
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__efmigrationshistory`
--

LOCK TABLES `__efmigrationshistory` WRITE;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` VALUES ('20250918224611_InitialCreate','8.0.10'),('20250919223017_UpdateUsers','8.0.10'),('20250919223617_InitialIdentity','8.0.10'),('20250919224137_RemoveRoleFromUsers','8.0.10'),('20250919224323_MakeUniversityNullable','8.0.10'),('20250920011345_AddRoleRequests','8.0.10'),('20250920030632_IDKKKKKKKKKKKKKK','8.0.10'),('20250920060728_AddCoAuthorsToArticles','8.0.10'),('20250920060837_AddCoAuthorsToArticles','8.0.10');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articleauthors`
--

DROP TABLE IF EXISTS `articleauthors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articleauthors` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ArticleId` int NOT NULL,
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_ArticleAuthors_ArticleId_UserId` (`ArticleId`,`UserId`),
  KEY `IX_ArticleAuthors_UserId` (`UserId`),
  CONSTRAINT `FK_ArticleAuthors_Articles_ArticleId` FOREIGN KEY (`ArticleId`) REFERENCES `articles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ArticleAuthors_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articleauthors`
--

LOCK TABLES `articleauthors` WRITE;
/*!40000 ALTER TABLE `articleauthors` DISABLE KEYS */;
INSERT INTO `articleauthors` VALUES (1,1,'de00b64a-b81f-41b3-b7ba-71a5bb94a4b8');
/*!40000 ALTER TABLE `articleauthors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) NOT NULL,
  `TopicId` int NOT NULL DEFAULT '0',
  `Topic` varchar(255) DEFAULT NULL,
  `CoAuthors` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  KEY `IX_Articles_TopicId` (`TopicId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'artykuł nr2137','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vel turpis rutrum, commodo libero vitae, accumsan justo. In ut arcu tortor. Nulla mollis odio sed velit hendrerit feugiat. Integer efficitur, odio a tempus malesuada, turpis sem sagittis magna, sit amet aliquam massa ipsum rutrum quam. Phasellus et felis tincidunt, iaculis ante id, lacinia sem. Maecenas dictum elit blandit nisi rutrum congue. In laoreet aliquet leo ut iaculis. Sed finibus, tortor quis dignissim vehicula, nisl orci bibendum quam, non malesuada risus neque eget urna.\r\n\r\nDonec sagittis neque quis ipsum sagittis pharetra. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus dapibus urna laoreet neque rutrum, id lacinia lectus placerat. Sed euismod mauris eu tortor maximus, ac fermentum enim porttitor. In eu sapien risus. Vivamus ac tempor ex. Sed lectus felis, egestas in tincidunt eu, finibus sit amet dolor. Phasellus mattis rutrum nibh. Integer quis metus sapien. Chciałbym teraz wypić piwko a muszę o 6:36 pisać kod bo nie zdam\r\n\r\nAenean volutpat non nisl vel iaculis. Donec porttitor porttitor ultricies. Maecenas ac ornare sem. In facilisis, ligula eget gravida semper, tortor ex pharetra mi, sit amet dapibus mauris odio aliquam eros. Nam pharetra luctus diam eu finibus. Nullam malesuada massa sit amet luctus tristique. Praesent a fringilla magna, ac eleifend neque.\r\n\r\nQuisque ornare dolor nec interdum ultricies. Duis pretium ut dui vel ornare. In finibus ex sed mauris ornare bibendum. Nullam tempus mauris vel lectus pellentesque, eu varius mauris mollis. Nam id velit eget nisi fringilla malesuada. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris eu tincidunt eros, non blandit leo. Quisque ornare laoreet posuere. Nulla et mauris ac sem condimentum consequat. Praesent at tellus sit amet erat bibendum auctor ac eu nisi. Praesent in tellus sagittis, gravida dui quis, tempus nisl. Duis vestibulum lorem tellus, ut pretium magna tincidunt at. Nullam fermentum augue at felis tempor accumsan. Aenean nec turpis blandit, mollis arcu a, maximus lectus. Nunc non lorem nec nulla congue venenatis id facilisis sapien.\r\n\r\nVestibulum eget interdum mi. Pellentesque vestibulum fringilla ex sagittis tincidunt. In tincidunt purus odio, sit amet aliquet diam lobortis id. Nulla fringilla fringilla ex dapibus luctus. Nulla sodales arcu rutrum, dignissim justo sed, dapibus velit. Praesent ut nulla at arcu luctus rhoncus. Pellentesque blandit accumsan metus, et pretium felis egestas a.','Approved','2025-09-20 06:05:08.593240','2025-09-20 07:27:43.179012',1,NULL,''),(2,'aaaa','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','Pending','2025-09-20 08:24:55.287414','2025-09-20 08:24:55.287453',2,NULL,'121580@student.san.edu.pl'),(3,'wlazł kotek','na płotek ','Pending','2025-09-20 08:25:20.220874','2025-09-20 08:25:20.220880',1,NULL,'121580@student.san.edu.pl');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetroleclaims`
--

DROP TABLE IF EXISTS `aspnetroleclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetroleclaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ClaimType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClaimValue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetroleclaims`
--

LOCK TABLES `aspnetroleclaims` WRITE;
/*!40000 ALTER TABLE `aspnetroleclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetroleclaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetroles`
--

DROP TABLE IF EXISTS `aspnetroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetroles` (
  `Id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetroles`
--

LOCK TABLES `aspnetroles` WRITE;
/*!40000 ALTER TABLE `aspnetroles` DISABLE KEYS */;
INSERT INTO `aspnetroles` VALUES ('b3336ef9-c2a6-4fd8-a487-7da91a1c5ff1','Admin','ADMIN',NULL),('c77bd55d-f1c9-4866-ba33-1cf530fc2a23','Author','AUTHOR',NULL),('ecd5fc15-10c2-4ad3-9666-770291974f15','Reviewer','REVIEWER',NULL),('fe1abb65-56fa-4187-bc79-3ca2366de7b3','Guest','GUEST',NULL);
/*!40000 ALTER TABLE `aspnetroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserclaims`
--

DROP TABLE IF EXISTS `aspnetuserclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetuserclaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ClaimType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClaimValue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserclaims`
--

LOCK TABLES `aspnetuserclaims` WRITE;
/*!40000 ALTER TABLE `aspnetuserclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserclaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserlogins`
--

DROP TABLE IF EXISTS `aspnetuserlogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetuserlogins` (
  `LoginProvider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProviderKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProviderDisplayName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserlogins`
--

LOCK TABLES `aspnetuserlogins` WRITE;
/*!40000 ALTER TABLE `aspnetuserlogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserlogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserroles`
--

DROP TABLE IF EXISTS `aspnetuserroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetuserroles` (
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserroles`
--

LOCK TABLES `aspnetuserroles` WRITE;
/*!40000 ALTER TABLE `aspnetuserroles` DISABLE KEYS */;
INSERT INTO `aspnetuserroles` VALUES ('697a3ab7-90bf-406d-a937-e4355a417b76','b3336ef9-c2a6-4fd8-a487-7da91a1c5ff1'),('de00b64a-b81f-41b3-b7ba-71a5bb94a4b8','c77bd55d-f1c9-4866-ba33-1cf530fc2a23'),('de00b64a-b81f-41b3-b7ba-71a5bb94a4b8','ecd5fc15-10c2-4ad3-9666-770291974f15'),('de00b64a-b81f-41b3-b7ba-71a5bb94a4b8','fe1abb65-56fa-4187-bc79-3ca2366de7b3');
/*!40000 ALTER TABLE `aspnetuserroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetusers`
--

DROP TABLE IF EXISTS `aspnetusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetusers` (
  `Id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LastName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `University` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `DegreeId` int NOT NULL,
  `UserName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedUserName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedEmail` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `SecurityStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PhoneNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`),
  KEY `IX_AspNetUsers_DegreeId` (`DegreeId`),
  CONSTRAINT `FK_AspNetUsers_Degrees_DegreeId` FOREIGN KEY (`DegreeId`) REFERENCES `degrees` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetusers`
--

LOCK TABLES `aspnetusers` WRITE;
/*!40000 ALTER TABLE `aspnetusers` DISABLE KEYS */;
INSERT INTO `aspnetusers` VALUES ('697a3ab7-90bf-406d-a937-e4355a417b76','Admin','Admin','Admin University',1,'admin@test.com','ADMIN@TEST.COM','admin@test.com','ADMIN@TEST.COM',0,'AQAAAAIAAYagAAAAELDqzloWtVA2vLndNnnSodtQh4IMMROACiAWSch9MkTCNKyaWKxM326lNyLX23KWyA==','5H5FYG3DFMRV5C3A4YNXGEQYBP7GQSBL','28f27e93-4879-4ba6-8061-0d5dea6c2308',NULL,0,0,NULL,1,0),('de00b64a-b81f-41b3-b7ba-71a5bb94a4b8','Maciej','Milczarek','SAN w Łodzi',1,'121580@student.san.edu.pl','121580@STUDENT.SAN.EDU.PL','121580@student.san.edu.pl','121580@STUDENT.SAN.EDU.PL',0,'AQAAAAIAAYagAAAAEO8djoeSzrR742oCmRJPl/GrTrEoird/LQTML3DXH+yPm+iqwJja/uz4qYm9+hRKNA==','XP5BVSSHX6PA33SWDCTMJYMLP5KYY54Y','15ce71e7-d841-4cc9-b728-1f73c4b5eaa9',NULL,0,0,NULL,1,0);
/*!40000 ALTER TABLE `aspnetusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetusertokens`
--

DROP TABLE IF EXISTS `aspnetusertokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetusertokens` (
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LoginProvider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetusertokens`
--

LOCK TABLES `aspnetusertokens` WRITE;
/*!40000 ALTER TABLE `aspnetusertokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetusertokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degrees`
--

DROP TABLE IF EXISTS `degrees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `degrees` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degrees`
--

LOCK TABLES `degrees` WRITE;
/*!40000 ALTER TABLE `degrees` DISABLE KEYS */;
INSERT INTO `degrees` VALUES (1,'Brak'),(2,'Licencjat'),(3,'Magister'),(4,'Doktor'),(5,'Profesor'),(6,'Student');
/*!40000 ALTER TABLE `degrees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ArticleId` int NOT NULL,
  `ReviewerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `AssignedAt` datetime(6) NOT NULL,
  `Content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Rating` int NOT NULL,
  `IsFinal` tinyint(1) NOT NULL,
  `Confidential` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Reviews_ArticleId` (`ArticleId`),
  KEY `IX_Reviews_ReviewerId` (`ReviewerId`),
  CONSTRAINT `FK_Reviews_Articles_ArticleId` FOREIGN KEY (`ArticleId`) REFERENCES `articles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Reviews_AspNetUsers_ReviewerId` FOREIGN KEY (`ReviewerId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `CK_Reviews_Rating` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,'de00b64a-b81f-41b3-b7ba-71a5bb94a4b8','2025-09-20 06:22:38.264954','fajne fajne serio',5,0,0);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolerequests`
--

DROP TABLE IF EXISTS `rolerequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rolerequests` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RoleName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `IsApproved` tinyint(1) NOT NULL,
  `RequestedAt` datetime(6) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_RoleRequests_UserId` (`UserId`),
  CONSTRAINT `FK_RoleRequests_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolerequests`
--

LOCK TABLES `rolerequests` WRITE;
/*!40000 ALTER TABLE `rolerequests` DISABLE KEYS */;
INSERT INTO `rolerequests` VALUES (1,'de00b64a-b81f-41b3-b7ba-71a5bb94a4b8','Author',1,'2025-09-20 03:14:51.172862'),(2,'de00b64a-b81f-41b3-b7ba-71a5bb94a4b8','Reviewer',1,'2025-09-20 03:14:55.052687'),(3,'de00b64a-b81f-41b3-b7ba-71a5bb94a4b8','Author',0,'2025-09-20 08:52:18.944812');
/*!40000 ALTER TABLE `rolerequests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statuses` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` VALUES (1,'Informatyka'),(2,'Matematyka'),(3,'Fizyka'),(4,'Chemia'),(5,'Biologia'),(6,'Medycyna'),(7,'Psychologia'),(8,'Ekonomia'),(9,'Sztuczna inteligencja (AI)'),(10,'Robotyka'),(11,'Inżynieria środowiska'),(12,'Nauki społeczne'),(13,'Filozofia'),(14,'Historia'),(15,'Literatura');
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-20 13:39:28
