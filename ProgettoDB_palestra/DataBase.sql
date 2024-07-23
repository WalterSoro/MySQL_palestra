CREATE DATABASE  IF NOT EXISTS `fitness` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fitness`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: fitness
-- ------------------------------------------------------
-- Server version	5.7.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Accesso`
--

DROP TABLE IF EXISTS `Accesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Accesso` (
  `Data` date NOT NULL,
  `OrarioIngresso` time NOT NULL,
  `Cliente` varchar(16) NOT NULL,
  `Uscita` time NOT NULL,
  `Centro` int(11) NOT NULL,
  `Armadietto` int(11) NOT NULL,
  `Spogliatoio` varchar(10) NOT NULL,
  `PiscinaInt` tinyint(4) NOT NULL,
  `PiscinaEst` tinyint(4) NOT NULL,
  PRIMARY KEY (`Data`,`OrarioIngresso`,`Cliente`),
  KEY `fk_12_idx` (`Cliente`),
  CONSTRAINT `fk_12` FOREIGN KEY (`Cliente`) REFERENCES `Cliente` (`CodFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Accesso`
--

LOCK TABLES `Accesso` WRITE;
/*!40000 ALTER TABLE `Accesso` DISABLE KEYS */;
INSERT INTO `Accesso` VALUES ('2017-08-01','19:30:00','ccc01','21:30:00',1,1,'U_001_01',0,0),('2017-11-20','19:30:00','bbb01','21:30:00',1,24,'U_001_01',0,0),('2017-12-11','19:30:00','ccc01','21:30:00',1,76,'U_001_01',1,0),('2018-01-24','19:30:00','ddd01','21:30:00',2,27,'U_002_01',1,0),('2018-02-22','14:00:00','ttt01','16:00:00',2,27,'U_002_01',0,0),('2018-03-23','16:00:00','eee01','17:30:00',3,36,'D_003_01',0,0),('2018-03-23','19:30:00','ggg01','21:30:00',3,56,'D_003_01',1,0),('2018-04-12','19:30:00','aaa01','21:30:00',1,33,'U_001_01',1,0),('2018-04-14','11:30:00','lll01','13:00:00',1,1,'U_001_01',0,0),('2018-04-14','13:00:00','lll01','15:00:00',1,55,'D_001_01',0,0),('2018-04-14','19:30:00','aaa01','21:30:00',1,33,'U_001_01',1,0),('2018-04-15','11:30:00','lll01','13:00:00',1,45,'U_001_01',0,0),('2018-04-16','19:30:00','aaa01','21:30:00',1,1,'U_001_01',0,0),('2018-04-17','19:30:00','aaa01','21:30:00',1,22,'U_001_01',1,0),('2018-04-18','19:30:00','aaa01','21:30:00',1,76,'U_001_01',1,0),('2018-04-19','19:30:00','aaa01','21:30:00',1,89,'U_001_01',0,0),('2018-04-20','08:00:00','lll01','09:30:00',3,98,'D_003_01',0,0),('2018-04-20','12:30:00','ddd01','14:00:00',1,25,'U_001_01',0,0),('2018-04-20','19:30:00','aaa01','21:30:00',1,14,'U_001_01',1,0);
/*!40000 ALTER TABLE `Accesso` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AssegnaArmadietto
BEFORE INSERT ON Accesso
FOR EACH ROW
BEGIN 

	IF( 0 = ( 	SELECT Libero
					FROM Armadietto 
					WHERE	Spogliatoio = NEW.Spogliatoio AND
									Numero = NEW.Armadietto
				)
	) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Armadietto occupato';
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ControlloAccessi
BEFORE INSERT ON Accesso
FOR EACH ROW
BEGIN
	
	IF EXISTS (
						SELECT *
						FROM Accesso A
						WHERE	A.Cliente = NEW.Cliente AND
										A.Data = (	SELECT MAX(Data)
															FROM Accesso
															WHERE Cliente = NEW.Cliente
														) 
										AND A.OrarioIngresso = (	SELECT MAX(OrarioIngresso)
																					FROM Accesso
																					WHERE	Cliente = NEW.Cliente AND
																									Data = A.Data
																				)
										AND A.Uscita = NULL
                            )
	THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: ingresso non consentito!';
	END IF;
							

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER op9
BEFORE INSERT ON Accesso 
FOR EACH ROW
BEGIN 
	IF EXISTS(	SELECT *
						FROM Rata R INNER JOIN Contratto C 
									ON C.Cod_Contratto = R.Contratto 
						WHERE	C.Cliente = NEW.Cliente
										AND R.Stato = 'Scaduto'
						) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ATTENZIONE: IL CLIENTE HA UNA RATA SCADUTA!';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER OccupaArmadietto
AFTER INSERT ON Accesso
FOR EACH ROW
BEGIN 

	UPDATE Armadietto
    SET Libero = 0
    WHERE	Numero = NEW.Armadietto AND
					Spogliatoio = NEW.Spogliatoio;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account` (
  `Username` varchar(15) NOT NULL,
  `Cliente` varchar(16) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Credibilita` float DEFAULT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account`
--

LOCK TABLES `Account` WRITE;
/*!40000 ALTER TABLE `Account` DISABLE KEYS */;
INSERT INTO `Account` VALUES ('anty','aaa01','fiufu',5),('claudio','ccc01','fhc',4),('dario','ddd01','dfrt',4.5),('eleonora','eee01','f5vd',3.5),('francy','fff01','f57g',5),('gio','ggg01','f46c',4),('linda','lll01','a3s3',NULL),('mary','mmm01','d46f',NULL),('poppy','ppp01','AhdyA',NULL),('star','bbb01','STAr',NULL),('tasso','ttt01','AJF9dc',4);
/*!40000 ALTER TABLE `Account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Adesione`
--

DROP TABLE IF EXISTS `Adesione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Adesione` (
  `Proponente` varchar(15) NOT NULL,
  `DataLancio` date NOT NULL,
  `Partecipante` varchar(15) NOT NULL,
  `Sforzo` int(11) DEFAULT NULL,
  PRIMARY KEY (`Proponente`,`DataLancio`,`Partecipante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Adesione`
--

LOCK TABLES `Adesione` WRITE;
/*!40000 ALTER TABLE `Adesione` DISABLE KEYS */;
INSERT INTO `Adesione` VALUES ('anty','2018-04-18','fra',NULL),('anty','2018-04-18','gio',NULL),('claudio','2017-08-11','francy',5),('claudio','2017-08-11','tasso',3),('francy','2018-04-21','anty',NULL),('francy','2018-04-21','francy',NULL),('linda','2017-11-20','anty',4),('linda','2017-11-20','star',2),('linda','2018-04-17','anty',NULL),('linda','2018-04-17','gio',NULL),('linda','2018-04-17','mary',NULL),('mary','2017-12-20','gio',4),('mary','2017-12-20','linda',5);
/*!40000 ALTER TABLE `Adesione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AmiciCerchia`
--

DROP TABLE IF EXISTS `AmiciCerchia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AmiciCerchia` (
  `Cerchia` varchar(45) NOT NULL,
  `Creatore` varchar(15) NOT NULL,
  `Amico` varchar(15) NOT NULL,
  `Stato` varchar(45) NOT NULL,
  PRIMARY KEY (`Cerchia`,`Creatore`,`Amico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AmiciCerchia`
--

LOCK TABLES `AmiciCerchia` WRITE;
/*!40000 ALTER TABLE `AmiciCerchia` DISABLE KEYS */;
INSERT INTO `AmiciCerchia` VALUES ('Atletica','poppy','gio','Suggerita'),('Calcio','star','eleonora','Suggerita'),('Nuoto','gio','claudio','Suggerita'),('Pallanuoto','anty','claudio','Accettata'),('Pallanuoto','anty','dario','Suggerito'),('Pallavolo','dario','anty','Suggerito'),('Pallavolo','dario','star','Suggerita'),('Pallavolo','mary','francy','Accettata'),('Taekwondo','anty','dario','Suggerito'),('Taekwondo','claudio','anty','Suggerita'),('Tennis','eleonora','francy','Accettata'),('Tennis','eleonora','star','Suggerita'),('Tuffi','francy','mary','Accettata');
/*!40000 ALTER TABLE `AmiciCerchia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Armadietto`
--

DROP TABLE IF EXISTS `Armadietto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Armadietto` (
  `Numero` int(11) NOT NULL,
  `Spogliatoio` varchar(10) NOT NULL,
  `Libero` tinyint(4) NOT NULL,
  `Password` int(4) NOT NULL,
  PRIMARY KEY (`Numero`,`Spogliatoio`),
  KEY `fk_13_idx` (`Spogliatoio`),
  CONSTRAINT `fk_13` FOREIGN KEY (`Spogliatoio`) REFERENCES `Spogliatoio` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Armadietto`
--

LOCK TABLES `Armadietto` WRITE;
/*!40000 ALTER TABLE `Armadietto` DISABLE KEYS */;
INSERT INTO `Armadietto` VALUES (1,'D_001_01',1,364),(1,'U_001_01',1,567),(2,'D_001_01',1,345),(2,'U_001_01',1,234),(3,'D_001_01',1,234),(3,'U_001_01',1,536),(4,'D_001_01',1,235),(4,'U_001_01',1,387),(5,'D_001_01',1,342),(5,'U_001_01',1,474),(6,'D_001_01',1,123),(6,'U_001_01',1,566),(7,'D_001_01',1,475),(7,'U_001_01',1,352),(8,'D_001_01',1,987),(8,'U_001_01',1,745),(9,'D_001_01',1,876),(9,'U_001_01',1,753),(10,'D_001_01',1,476),(10,'U_001_01',1,347);
/*!40000 ALTER TABLE `Armadietto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Attivita`
--

DROP TABLE IF EXISTS `Attivita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attivita` (
  `Cliente` varchar(16) NOT NULL,
  `Corso` varchar(45) NOT NULL,
  `Livello` varchar(45) NOT NULL,
  `DataInizio` date NOT NULL,
  PRIMARY KEY (`Cliente`,`Corso`,`Livello`,`DataInizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attivita`
--

LOCK TABLES `Attivita` WRITE;
/*!40000 ALTER TABLE `Attivita` DISABLE KEYS */;
INSERT INTO `Attivita` VALUES ('aaa01','Boxe ','Avanzato','2018-02-05'),('aaa01','Boxe','Principiante','2018-01-20'),('aaa01','Pallavolo','Intermedio','2017-11-20'),('aaa01','Taekwondo','Avanzato','2017-07-07'),('aab01','Boxe ','Avanzato','2018-02-05'),('abb01','Nuoto','Intermedio','2017-10-10'),('abc01','Boxe ','Avanzato','2018-02-05'),('abc01','Nuoto','Intermedio','2017-10-10'),('abx01','Boxe ','Avanzato','2018-02-05'),('abx01','Nuoto','Intermedio','2017-10-10'),('acb01','Boxe ','Avanzato','2018-02-05'),('acc01','Boxe ','Avanzato','2018-02-05'),('asq01','Pallavolo','Intermedio','2017-11-20'),('bbb01','Boxe ','Avanzato','2018-02-05'),('bbb01','Boxe','Principiante','2018-01-20'),('bbb01','Pallavolo','Intermedio','2017-11-20'),('bbb01','Tuffi','Intermedio','2018-01-30'),('bbc01','Boxe ','Avanzato','2018-02-05'),('bbd01','Boxe ','Avanzato','2018-02-05'),('bbx01','Boxe ','Avanzato','2018-02-05'),('bcb01','Boxe ','Avanzato','2018-02-05'),('bcc01','Boxe ','Avanzato','2018-02-05'),('bfg01','Nuoto','Intermedio','2017-10-10'),('cac01','Boxe','Principiante','2018-01-20'),('car01','Taekwondo','Avanzato','2017-07-07'),('cbb01','Boxe','Principiante','2018-01-20'),('cbc01','Boxe','Principiante','2018-01-20'),('cca01','Boxe','Principiante','2018-01-20'),('ccb01','Boxe','Principiante','2018-01-20'),('ccc01','Boxe ','Avanzato','2018-02-05'),('ccc01','Boxe','Principiante','2018-01-20'),('ccc01','Pallavolo','Intermedio','2017-11-20'),('ccc01','Taekwondo','Avanzato','2017-07-07'),('ccd01','Boxe','Principiante','2018-01-20'),('cce01','Boxe','Principiante','2018-01-20'),('cdc01','Boxe','Principiante','2018-01-20'),('cdx01','Boxe','Principiante','2018-01-20'),('cec01','Boxe','Principiante','2018-01-20'),('cpc01','Boxe','Principiante','2018-01-20'),('dad01','Tennis','Avanzato','2017-08-21'),('dda01','Boxe','Principiante','2018-01-20'),('ddb01','Boxe','Principiante','2018-01-20'),('ddc01','Boxe','Principiante','2018-01-20'),('ddd01','Taekwondo','Avanzato','2017-07-07'),('ddd01','Tennis','Avanzato','2017-08-21'),('ddd01','Tuffi','Intermedio','2018-01-30'),('dde01','Boxe','Principiante','2018-01-20'),('ddf01','Boxe','Principiante','2018-01-20'),('ddh01','Boxe','Principiante','2018-01-20'),('ddr01','Boxe','Principiante','2018-01-20'),('dds01','Boxe','Principiante','2018-01-20'),('eee01','Tennis','Avanzato','2017-08-21'),('eee01','Tuffi','Intermedio','2018-01-30'),('eee01','Zumba','Intermedio','2017-04-04'),('eff01','Nuoto','Intermedio','2017-10-10'),('fer01','Taekwondo','Avanzato','2017-07-07'),('fff01','Nuoto','Intermedio','2017-10-10'),('fff01','Nuoto sincronizzato','Avanzato','2017-11-24'),('fff01','Tennis','Avanzato','2017-08-21'),('fff01','Zumba','Intermedio','2017-04-04'),('fof01','Tennis','Avanzato','2017-08-21'),('fre01','Tennis','Avanzato','2017-08-21'),('gag01','Pallavolo','Intermedio','2017-11-20'),('ggf01','Taekwondo','Avanzato','2017-07-07'),('ggg01','Nuoto','Intermedio','2017-10-10'),('ggg01','Nuoto sincronizzato','Avanzato','2017-11-24'),('ggg01','Zumba','Intermedio','2017-04-04'),('kfc01','Pallavolo','Intermedio','2017-11-20'),('lll01','Nuoto','Intermedio','2017-10-10'),('lll01','Nuoto sincronizzato','Avanzato','2017-11-24'),('mam01','Tennis','Avanzato','2017-08-21'),('mom01','Tennis','Avanzato','2017-08-21'),('pad01','Pallavolo','Intermedio','2017-11-20'),('pol01','Pallavolo','Intermedio','2017-11-20'),('sas01','Taekwondo','Avanzato','2017-07-07'),('sed01','Pallavolo','Intermedio','2017-11-20'),('srt01','Nuoto','Intermedio','2017-10-10'),('tkd01','Taekwondo','Avanzato','2017-07-07'),('vva01','Nuoto','Intermedio','2017-10-10'),('vvx01','Nuoto','Intermedio','2017-10-10'),('zfc01','Nuoto','Intermedio','2017-10-10');
/*!40000 ALTER TABLE `Attivita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Attrezzatura`
--

DROP TABLE IF EXISTS `Attrezzatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attrezzatura` (
  `Codice` varchar(10) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Sala` varchar(45) NOT NULL,
  `Categoria` varchar(45) NOT NULL,
  `Consumo_Energetico` int(11) NOT NULL,
  `Liv_Usura` int(11) NOT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attrezzatura`
--

LOCK TABLES `Attrezzatura` WRITE;
/*!40000 ALTER TABLE `Attrezzatura` DISABLE KEYS */;
INSERT INTO `Attrezzatura` VALUES ('112','Tappetino','sala1','Potenziamento',130,2),('234','Climbmill','sala4','Potenziamento',350,88),('243','Cyclette','sala1','Cardio',240,15),('274','Tapis Roulant','sala1','Cardio',240,43),('343','Tappetino','sala5','Potenziamento',130,0),('345','Cyclette','sala3','Cardio',240,11),('346','Abcoaster','sala6','Potenziamento',200,14),('348','Squat Rack','sala2','Potenziamento',300,14),('454','Adductor Machine','sala4','Potenziamento',121,97),('465','Corda','sala6','Cardio',200,0),('467','Cyclette','sala1','Cardio',240,45),('878','Tapis Roulant','sala1','Cardio',240,54);
/*!40000 ALTER TABLE `Attrezzatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Calendario`
--

DROP TABLE IF EXISTS `Calendario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Calendario` (
  `Giorno` varchar(45) NOT NULL,
  `Orario_Inizio` time NOT NULL,
  `Corso` varchar(45) NOT NULL,
  `Livello` varchar(45) NOT NULL,
  `DataInizio` date NOT NULL,
  `Centro` int(11) NOT NULL,
  `Orario_Fine` time NOT NULL,
  PRIMARY KEY (`Giorno`,`Orario_Inizio`,`Corso`,`Livello`,`DataInizio`,`Centro`),
  KEY `fk_53_idx` (`Centro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Calendario`
--

LOCK TABLES `Calendario` WRITE;
/*!40000 ALTER TABLE `Calendario` DISABLE KEYS */;
INSERT INTO `Calendario` VALUES ('Giovedi','17:00:00','Boxe','Principiante','2018-01-20',4,'18:00:00'),('Giovedi','17:00:00','Taekwondo','Principiante','2017-10-10',1,'19:00:00'),('Giovedi','19:00:00','Pallavolo','Intermedio','2017-11-20',10,'21:00:00'),('Lunedi','08:00:00','Nuoto','Intermedio','2017-10-10',1,'09:00:00'),('Lunedi','18:00:00','Boxe','Avanzato','2018-02-05',4,'20:00:00'),('Lunedi','19:00:00','Pallavolo','Intermedio','2017-11-20',10,'21:00:00'),('Lunedi','19:00:00','Taekwondo','Avanzato','2017-07-07',1,'21:00:00'),('Lunedi','19:00:00','Tuffi','Intermedio','2018-01-30',1,'21:00:00'),('Lunedi','20:00:00','Nuoto sincronizzato','Avanzato','2017-11-24',1,'22:00:00'),('Lunedi','20:00:00','Tennis','Avanzato','2017-08-21',6,'22:00:00'),('Martedi','14:00:00','Zumba','Intermedio','2017-04-04',2,'16:00:00'),('Martedi','17:00:00','Boxe','Principiante','2018-01-20',4,'18:00:00'),('Martedi','17:00:00','Taekwondo','Principiante','2017-10-10',1,'19:00:00'),('Mercoledi','08:00:00','Nuoto','Intermedio','2017-10-10',1,'09:00:00'),('Mercoledi','18:00:00','Boxe','Avanzato','2018-02-05',4,'20:00:00'),('Mercoledi','19:00:00','Taekwondo','Avanzato','2017-07-07',1,'21:00:00'),('Mercoledi','19:00:00','Tuffi','Intermedio','2018-01-30',1,'21:00:00'),('Mercoledi','20:00:00','Nuoto sincronizzato','Avanzato','2017-11-24',1,'22:00:00'),('Mercoledi','20:00:00','Tennis','Avanzato','2017-08-21',6,'22:00:00'),('Venerdi','08:00:00','Nuoto','Intermedio','2017-10-10',1,'09:00:00'),('Venerdi','18:00:00','Boxe','Avanzato','2018-02-05',4,'20:00:00'),('Venerdi','19:00:00','Taekwondo','Avanzato','2017-07-07',1,'21:00:00'),('Venerdi','19:00:00','Tuffi','Intermedio','2018-01-30',1,'21:00:00'),('Venerdi','20:00:00','Nuoto sincronizzato','Avanzato','2017-11-24',1,'22:00:00'),('Venerdi','20:00:00','Tennis','Avanzato','2017-08-21',6,'22:00:00');
/*!40000 ALTER TABLE `Calendario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ControlloCorsi
BEFORE INSERT ON Calendario
FOR EACH ROW
BEGIN
	
    DECLARE _istruttore VARCHAR (16);
    DECLARE Finito INT DEFAULT 0;
    DECLARE _inizio INT;
    DECLARE _fine INT;
    
    DECLARE cursore CURSOR FOR
   	SELECT Orario_inizio, Orario_Fine
    FROM Calendario NATURAL JOIN Corso
    WHERE	Istruttore = _istruttore AND 
					Giorno = NEW.Giorno;
                    
	DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET Finito = 1;
    
    SET _istruttore = (	SELECT	Istruttore
									FROM Corso
									WHERE	Disciplina = NEW.Corso AND
													Livello = NEW.Livello AND
													Inizio = NEW.Orario_Inizio
								);
                                
	OPEN cursore;
    
    copia: LOOP
    
		FETCH cursore INTO _inizio, _fine;
		
        IF ( (HOUR(NEW.Orario_Inizio) BETWEEN _inizio AND _fine) OR
			   (HOUR(NEW.Orario_Fine) BETWEEN _inizio AND _fine)
			) THEN
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'ERRORE: l''istruttore segue un altro corso in questa fascia oraria!';
		END IF;
	END LOOP;
    
    CLOSE cursore;
	
							
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Calibrazione`
--

DROP TABLE IF EXISTS `Calibrazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Calibrazione` (
  `Codice` varchar(10) NOT NULL,
  `Attrezzatura` varchar(45) NOT NULL,
  `Regolazione` varchar(45) NOT NULL,
  `Intensita` int(11) NOT NULL,
  PRIMARY KEY (`Codice`,`Attrezzatura`,`Regolazione`,`Intensita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Calibrazione`
--

LOCK TABLES `Calibrazione` WRITE;
/*!40000 ALTER TABLE `Calibrazione` DISABLE KEYS */;
INSERT INTO `Calibrazione` VALUES ('234','Climbmill','Velocita',5),('234','Climbmill','Velocita',10),('274','Tapis Roulant','Inclinazione',3),('274','Tapis Roulant','Inclinazione',5),('274','Tapis Roulant','Velocita',6),('274','Tapis Roulant','Velocita',8),('274','Tapis Roulant','Velocita',10),('345','Cyclette','Marcia',2),('345','Cyclette','Marcia',4),('345','Cyclette','Marcia',6),('348','Squat Rack','Peso',10),('348','Squat Rack','Peso',15),('454','Adductor Machine','Peso',20),('454','Adductor Machine','Peso',40),('488','Deltoid Machine','Peso',20),('488','Deltoid Machine','Peso',30),('488','Deltoid Machine','Peso',40),('498','Pressa','Peso',30),('498','Pressa','Peso',40),('498','Pressa','Peso',50);
/*!40000 ALTER TABLE `Calibrazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CaratteristicheContratto`
--

DROP TABLE IF EXISTS `CaratteristicheContratto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CaratteristicheContratto` (
  `Contratto` int(11) NOT NULL,
  `Tipo` varchar(45) NOT NULL,
  `Personalizzato` varchar(2) NOT NULL,
  `Ingressi_max` int(11) DEFAULT NULL,
  `PiscineInt` int(11) NOT NULL,
  `PiscineEst` int(11) NOT NULL,
  `Sale` varchar(45) DEFAULT NULL,
  `Costo` float NOT NULL,
  `CentroStipulazione` int(11) NOT NULL,
  `Centro2` int(11) DEFAULT NULL,
  `Centro3` int(11) DEFAULT NULL,
  PRIMARY KEY (`Contratto`),
  CONSTRAINT `fk_1` FOREIGN KEY (`Contratto`) REFERENCES `Contratto` (`Cod_Contratto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CaratteristicheContratto`
--

LOCK TABLES `CaratteristicheContratto` WRITE;
/*!40000 ALTER TABLE `CaratteristicheContratto` DISABLE KEYS */;
INSERT INTO `CaratteristicheContratto` VALUES (101,'Silver','si',3,4,0,'Silver',180,1,NULL,NULL),(102,'Silver','no',2,0,0,'Silver',120,2,NULL,NULL),(103,'Gold','no',4,4,4,'Gold',210,3,NULL,NULL),(104,'Gold','si',4,8,0,'Gold',520,4,3,5),(105,'Silver','si',4,4,0,'Gold',450,5,2,NULL),(106,'Platinum','no',NULL,12,12,'Platinum',300,6,4,NULL),(107,'Platinum','si',NULL,24,10,'Platinum',300,7,NULL,NULL),(108,'Gold','no',4,4,4,'Gold',210,8,NULL,NULL),(109,'Silver','no',2,0,0,'Silver',240,9,NULL,NULL),(110,'Silver','no',2,0,0,'Silver',240,10,NULL,NULL);
/*!40000 ALTER TABLE `CaratteristicheContratto` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ContrattoGold
BEFORE INSERT ON CaratteristicheContratto
FOR EACH ROW
BEGIN

	IF (	( Tipo = 'Gold' AND
			  Personalizzato = 'no' ) AND
            ( Ingressi_max <> 4 OR
              PiscineInt <> 4 OR
              PiscineEst <> 4 OR
              Sale <> 'Gold')
			)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: caratteristiche contratto non adeguate per il tipo Gold';
	END IF;			

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ContrattoPlatinum
BEFORE INSERT ON CaratteristicheContratto
FOR EACH ROW
BEGIN

	IF (	( Tipo = 'Platinum' AND
			  Personalizzato = 'no' ) AND
            ( Ingressi_max <> NULL OR
              PiscineInt <> 12 OR
              PiscineEst <> 12 OR
			  Sale <> 'Platinum')
			)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: caratteristiche contratto non adeguate per il tipo Platinum';
	END IF;			

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ContrattoSilver
BEFORE INSERT ON CaratteristicheContratto
FOR EACH ROW
BEGIN

	IF (	( Tipo = 'Silver' AND
			  Personalizzato = 'no' ) AND
            ( Ingressi_max <> 2 OR
              PiscineInt <> 0 OR
              PiscineEst <> 0 OR
              Sale <> 'Silver')
			)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: caratteristiche contratto non adeguate per il tipo Silver';
	END IF;			

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Catalogo`
--

DROP TABLE IF EXISTS `Catalogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Catalogo` (
  `Fornitore` int(11) NOT NULL,
  `Indirizzo` varchar(45) NOT NULL,
  `Integratore` varchar(45) NOT NULL,
  `Dosaggio` varchar(10) NOT NULL,
  PRIMARY KEY (`Fornitore`,`Indirizzo`,`Integratore`,`Dosaggio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Catalogo`
--

LOCK TABLES `Catalogo` WRITE;
/*!40000 ALTER TABLE `Catalogo` DISABLE KEYS */;
INSERT INTO `Catalogo` VALUES (5501,'Via Rustichello Da Pisa 87, Roma','Energia Rapida +','25 ml'),(5501,'Via Rustichello Da Pisa 87, Roma','Energy Gold','35 g'),(5501,'Via Rustichello Da Pisa 87, Roma','FL 100','200 mg'),(5502,'Via San Marco 45, Latina','HTP ','400 mg'),(5502,'Via San Marco 45, Latina','Maltoshot','30 ml'),(5502,'Via San Marco 45, Latina','PRE GARA ENDURANCE','19 g'),(5503,'Via Bonanno Pisano 67, Cagliari','Ramtech','10.5 g'),(5503,'Via Bonanno Pisano 67, Cagliari','Recupero Extreme','50 g'),(5503,'Via Bonanno Pisano 67, Cagliari','SportNuts','30 g'),(5504,'Via Repubblica 43, Cuneo','FL 100','200 mg'),(5504,'Via Repubblica 43, Cuneo','Super Dextrin','700 g'),(5505,'Via Mazzini 65, Napoli','Ramtech','10.5 g');
/*!40000 ALTER TABLE `Catalogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Centro`
--

DROP TABLE IF EXISTS `Centro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Centro` (
  `Codice` int(11) NOT NULL,
  `Indirizzo` varchar(45) NOT NULL,
  `Citta` varchar(45) NOT NULL,
  `Tariffa_Accesso` float NOT NULL,
  `Num_Telefono` varchar(45) NOT NULL,
  `Capienza_max` int(11) NOT NULL,
  `Dimensione` int(11) NOT NULL,
  `Orario_Apertura` int(11) NOT NULL,
  `Orario_Chiusura` int(11) NOT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Centro`
--

LOCK TABLES `Centro` WRITE;
/*!40000 ALTER TABLE `Centro` DISABLE KEYS */;
INSERT INTO `Centro` VALUES (1,'Via Roma 14','Pisa',7.5,'0504873478',300,800,8,22),(2,'Via San Pietro 121','Milano',10,'0405465772',350,1000,8,22),(3,'Via Ugo Foscolo 24','Napoli',5,'07845099123',250,600,8,22),(4,'Via Santa Lucia 18','Bologna',6,'0908977621',300,800,8,22),(5,'Via Trieste 41','Torino',8,'0908977876',350,1000,8,22),(6,'Via Corridoni 36','Genova',8.5,'0908722123',250,700,8,22),(7,'Via Fasulla 119','Springfield',10,'0405433123',350,1000,8,22),(8,'Via Piemonte','Palermo',7,'0234566567',250,800,8,22),(9,'Via Garibaldi 43','Cagliari',9,'0234566708',280,900,8,22),(10,'Via Dante 37','Ancona',5,'0203300940',200,600,8,22);
/*!40000 ALTER TABLE `Centro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cerchia`
--

DROP TABLE IF EXISTS `Cerchia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cerchia` (
  `Nome` varchar(45) NOT NULL,
  `Account` varchar(15) NOT NULL,
  PRIMARY KEY (`Nome`,`Account`),
  KEY `fk_2_idx` (`Account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cerchia`
--

LOCK TABLES `Cerchia` WRITE;
/*!40000 ALTER TABLE `Cerchia` DISABLE KEYS */;
INSERT INTO `Cerchia` VALUES ('Pallanuoto','anty'),('Taekwondo','anty'),('Taekwondo','claudio'),('Pallavolo','dario'),('Tennis','eleonora'),('Tuffi','francy'),('Nuoto','gio'),('Pallavolo','mary'),('Atletica','poppy'),('Calcio','star'),('Workout','tasso');
/*!40000 ALTER TABLE `Cerchia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cliente` (
  `CodFiscale` varchar(16) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Cognome` varchar(45) NOT NULL,
  `Sesso` varchar(1) NOT NULL,
  `DataNascita` date NOT NULL,
  `Indirizzo` varchar(45) NOT NULL,
  `Citta` varchar(45) NOT NULL,
  `Num_documento` varchar(45) NOT NULL,
  `LuogoRilascio` varchar(45) NOT NULL,
  PRIMARY KEY (`CodFiscale`),
  UNIQUE KEY `Num_documento_UNIQUE` (`Num_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES ('aaa01','Antonio','Ricci','M','1999-08-21','Via Roma 32','Milano','dsfhwiuehf','Milano'),('bbb01','Biagio','Antonacci','M','1972-09-11','Via Garibaldi 34','Roma','ghsdifuhewu','Roma'),('ccc01','Claudio','Bisio','M','1985-12-23','Via Rebubblica 121','Cuneo','sdfchewfih','Cuneo'),('ddd01','Dario','Argento','M','1992-02-23','Via Piemonte 67','Latina','vfusdhfiu','Latina'),('eee01','Eleonora','D\'Arborea','F','1996-04-25','Via San Marco 56','Cagliari','fvruihfduc','Cagliari'),('fff01','Francesco','Renga','M','1979-09-12','Via San Basilio 33','Napoli','dfiuwedu','Napoli'),('ggg01','Giovanna','D\'Arco','F','2000-11-11','Via Savona 98','Palermo','fsdhwef','Palermo'),('lll01','Linda','Pulita','F','1994-01-30','Via Santo Stefano 34','Bologna','fsduhcdu','Bologna'),('mmm01','Maria','Rossi','F','1993-12-28','Via Bonanno Pisano 34','Perugia','sdfwehfi','Perugia'),('ppp01','Paolo','Bonolis','F','1969-09-09','Via Santa Lucia 14','Torino','weufshdi','Torino'),('rrr01','Rino','Gaetano','M','1989-09-26','Via Sardegna','Sassari','rfsdsiueh','Sassari'),('ttt01','Torquato','Tasso','M','1984-07-21','Via Piemonte 46','Ancona','udshzfhe','Ancona');
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContrattiPassati`
--

DROP TABLE IF EXISTS `ContrattiPassati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContrattiPassati` (
  `Cod_Contratto` int(11) NOT NULL,
  `Cliente` varchar(16) NOT NULL,
  `CodConsulente` varchar(16) NOT NULL,
  `ModPagamento` varchar(45) NOT NULL,
  `DataInizio` date NOT NULL,
  `DataFine` date NOT NULL,
  `Scopo` varchar(45) NOT NULL,
  `Intensita` varchar(45) NOT NULL,
  PRIMARY KEY (`Cod_Contratto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContrattiPassati`
--

LOCK TABLES `ContrattiPassati` WRITE;
/*!40000 ALTER TABLE `ContrattiPassati` DISABLE KEYS */;
INSERT INTO `ContrattiPassati` VALUES (201,'aaa01','aaa02','Rateizzato','2017-05-05','2017-11-05','Dimagrimento','Lieve'),(202,'ccc01','ttt02','Rateizzato','2017-08-04','2018-02-04','Potenziamento muscolare','Lieve'),(203,'ppp01','eee02','Rateizzato','2017-04-21','2017-10-21','Potenziamento arti superiori','Moderato'),(204,'ttt01','ccc02','Completo','2017-04-12','2017-10-12','Tonificazione','Moderato'),(205,'eee01','bbb02','Rateizzato','2017-10-10','2018-04-10','Dimagrimento','Elevato');
/*!40000 ALTER TABLE `ContrattiPassati` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contratto`
--

DROP TABLE IF EXISTS `Contratto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Contratto` (
  `Cod_Contratto` int(11) NOT NULL,
  `Cliente` varchar(16) NOT NULL,
  `CodConsulente` varchar(16) NOT NULL,
  `ModPagamento` varchar(45) NOT NULL,
  `DataInizio` date NOT NULL,
  `DataFine` date NOT NULL,
  `Scopo` varchar(45) NOT NULL,
  `Intensita` varchar(45) NOT NULL,
  PRIMARY KEY (`Cod_Contratto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contratto`
--

LOCK TABLES `Contratto` WRITE;
/*!40000 ALTER TABLE `Contratto` DISABLE KEYS */;
INSERT INTO `Contratto` VALUES (101,'aaa01','ttt02','Rateizzato','2018-01-24','2018-07-24','Dimagrimento','Lieve'),(102,'bbb01','fff02','Rateizzato','2018-02-23','2018-08-23','Potenziamento muscolare','Moderato'),(103,'ccc01','ggg02','Rateizzato','2018-03-04','2018-11-04','Potenziamento arti inferiori','Liece'),(104,'ddd01','mmm02','Rateizzato','2018-04-05','2019-04-05','Potenziamento arti superiori','Moderato'),(105,'eee01','bbb02','Completo','2017-12-23','2018-12-23','Dimagrimento','Elevato'),(106,'fff01','eee02','Rateizzato','2018-03-21','2018-11-21','Tonificazione','Elevato'),(107,'ggg01','ppp02','Rateizzato','2018-04-10','2018-10-10','Dimagrimento','Lieve'),(108,'mmm01','sss02','Completo','2018-03-05','2018-09-05','Potenziamento muscolare','Moderato'),(109,'lll01','ccc02','Completo','2017-09-08','2018-09-08','Tonificazione','Moderato'),(110,'ttt01','aaa02','Rateizzato','2017-08-08','2018-08-08','Dimagrimento','Elevato');
/*!40000 ALTER TABLE `Contratto` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER op6
BEFORE INSERT ON Contratto
FOR EACH ROW 
BEGIN

	DECLARE contratto int(11) DEFAULt 0;
    DECLARE consulente varchar(16);
    DECLARE pagamento varchar(45);
    DECLARE inizio DATE;
    DECLARE fine DATE;
    DECLARE scopo_ varchar(45);
    DECLARE intensita_ VARCHAR(45);
    
    SELECT	C.Cod_Contratto, C.CodConsulente, C.ModPagamento, C.Data_Inizio, C.Data_Fine, C.Scopo, C.Intensita
					INTO contratto, consulente, pagamento, inizio, fine, scopo_, intensita_
    FROM Contratto C
    WHERE C.Cliente = NEW.Cliente;
    
	INSERT INTO ContrattiPassati
    VALUES(  contratto, NEW.Cliente, consulente, pagamento, inizio, fine, scopo_, intensita_ );
    
    DELETE FROM contratto
    WHERE Cliente = NEW.Cliente;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Corso`
--

DROP TABLE IF EXISTS `Corso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Corso` (
  `Disciplina` varchar(45) NOT NULL,
  `Livello` varchar(45) NOT NULL,
  `Inizio` date NOT NULL,
  `Centro` int(11) NOT NULL,
  `Fine` date NOT NULL,
  `Max_Iscritti` int(11) NOT NULL,
  `Istruttore` varchar(16) NOT NULL,
  PRIMARY KEY (`Disciplina`,`Livello`,`Inizio`,`Centro`),
  KEY `fk_20_idx` (`Centro`),
  CONSTRAINT `fk_20` FOREIGN KEY (`Centro`) REFERENCES `Centro` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Corso`
--

LOCK TABLES `Corso` WRITE;
/*!40000 ALTER TABLE `Corso` DISABLE KEYS */;
INSERT INTO `Corso` VALUES ('Boxe','Avanzato','2018-02-05',4,'2019-02-05',20,'vvv02'),('Boxe','Principiante','2018-01-20',4,'2018-07-20',30,'vvv02'),('Nuoto','Intermedio','2017-10-10',1,'2018-10-10',35,'ccc02'),('Nuoto sincronizzato','Avanzato','2017-11-24',1,'2018-11-24',25,'rrr02'),('Pallavolo','Intermedio','2017-11-20',10,'2018-05-11',25,'ccc02'),('Taekwondo','Avanzato','2017-07-07',1,'2018-01-07',30,'bbb02'),('Taekwondo','Principiante','2017-10-10',1,'2018-10-10',25,'bbb02'),('Tennis','Avanzato','2017-08-21',6,'2018-08-21',30,'fff02'),('Tuffi','Intermedio','2018-01-30',1,'2018-07-30',20,'ccc02'),('Zumba','Intermedio','2017-04-04',2,'2018-04-04',20,'ddd02');
/*!40000 ALTER TABLE `Corso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dipendente`
--

DROP TABLE IF EXISTS `Dipendente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dipendente` (
  `CodFiscale` varchar(16) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Cognome` varchar(45) NOT NULL,
  `Sesso` varchar(1) NOT NULL,
  `DataNascita` date NOT NULL,
  `Indirizzo` varchar(45) NOT NULL,
  `Citta` varchar(45) NOT NULL,
  `Num_documento` varchar(45) NOT NULL,
  `LuogoRilascio` varchar(45) NOT NULL,
  PRIMARY KEY (`CodFiscale`),
  UNIQUE KEY `Num_documento_UNIQUE` (`Num_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dipendente`
--

LOCK TABLES `Dipendente` WRITE;
/*!40000 ALTER TABLE `Dipendente` DISABLE KEYS */;
INSERT INTO `Dipendente` VALUES ('aaa02','Alessandro','Volta','M','1997-02-20','Via Delle Pere14','Milano','aviurhtu','Milano'),('bbb02','Beatrice','Vio','F','1990-04-05','Via Garibaldi 15','Roma','reiughfse','Roma'),('ccc02','Carlo','Conti','M','1963-08-08','Via Piemonte 121','Belluno','dsfhewhd','Belluno'),('ddd02','Daria','Bignardi','F','2000-08-21','Via San Marco 32','Cagliari','sdfuhweu','Cagliari'),('eee02','Eleonora','Abbagnato','F','1989-09-11','Via Dante 67','Torino','suvhdcjwd','Torino'),('fff02','Federico','Di Svevia','M','1999-06-23','Via Risorgimento 134','Sassari','sdfhuqe','Sassari'),('ggg02','Galileo','Galilei','M','1978-08-23','Via Dei Mille 54','Pisa','wiurgvdscj','Pisa'),('rrr02','Rita','Levi-Montalcini','F','1992-12-28','Via Mazzini 43','Savona','htrsthdf','Savona'),('vvv02','Valentino','Rossi','M','1993-02-18','Via Vico Pisano 46','Urbino','sduhfiuerg','Urbino');
/*!40000 ALTER TABLE `Dipendente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Esercizio`
--

DROP TABLE IF EXISTS `Esercizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Esercizio` (
  `GiornoAllenamento` int(11) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `SchedaAssociata` varchar(10) NOT NULL,
  `Tipologia` varchar(45) NOT NULL,
  `Dispendio` int(11) NOT NULL,
  `Ripetizioni` int(11) NOT NULL,
  `Serie` int(11) NOT NULL,
  `Durata` int(11) NOT NULL COMMENT 'Durata in secondi',
  `Info_Durata` varchar(5) NOT NULL,
  `Recupero` int(11) DEFAULT NULL,
  `Attrezzatura` varchar(45) DEFAULT NULL,
  `Regolazione` varchar(45) DEFAULT NULL,
  `Intensita` int(11) DEFAULT NULL,
  PRIMARY KEY (`GiornoAllenamento`,`Nome`,`SchedaAssociata`),
  KEY `fk_11_idx` (`SchedaAssociata`),
  CONSTRAINT `fk_11` FOREIGN KEY (`SchedaAssociata`) REFERENCES `SchedaAllenamento` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Esercizio`
--

LOCK TABLES `Esercizio` WRITE;
/*!40000 ALTER TABLE `Esercizio` DISABLE KEYS */;
INSERT INTO `Esercizio` VALUES (1,'Corsa','301','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant','Velocita',8),(1,'Corsa','302','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant','Velocita',8),(1,'Corsa','303','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant','Velocita',8),(1,'Corsa','305','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant','Velocita',8),(1,'Corsa','306','Cardio',550,1,2,15,'min',5,'Tapis Roulant','Velocita',8),(1,'Corsa','307','Cardio',550,1,2,15,'min',5,'Tapis Roulant','Velocita',8),(1,'Corsa','308','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant','Velocita',8),(1,'Corsa','309','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant','Velocita',7),(1,'Corsa','310','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant','Velocita',8),(1,'Cyclette','304','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant','Velocita',8),(1,'Plank','301','Potenziamento',300,1,3,30,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','302','Potenziamento',300,1,3,30,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','303','Potenziamento',300,1,3,15,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','304','Potenziamento',300,1,3,20,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','305','Potenziamento',300,1,3,20,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','306','Potenziamento',300,1,3,20,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','307','Potenziamento',300,1,3,30,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','308','Potenziamento',300,1,3,30,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','309','Potenziamento',300,1,3,30,'sec',15,'Tappetino',NULL,NULL),(1,'Plank','310','Potenziamento',300,1,3,30,'sec',15,'Tappetino',NULL,NULL),(2,'Climbmill','310','Potenziamento',200,1,3,60,'sec',15,'Climbmill',NULL,NULL),(2,'Corsa','301','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant',NULL,NULL),(2,'Corsa','302','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant',NULL,NULL),(2,'Corsa','303','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant',NULL,NULL),(2,'Corsa','304','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant',NULL,NULL),(2,'Corsa','305','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant',NULL,NULL),(2,'Corsa','306','Cardio',550,1,2,15,'min',5,'Tapis Roulant',NULL,NULL),(2,'Corsa','307','Cardio',550,1,2,15,'min',5,'Tapis Roulant',NULL,NULL),(2,'Corsa','308','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant',NULL,NULL),(2,'Corsa','309','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant',NULL,NULL),(2,'Corsa','310','Cardio',550,1,1,15,'min',NULL,'Tapis Roulant',NULL,NULL),(2,'Piegamenti sulle braccia','301','Potenziamento',300,15,3,30,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','302','Potenziamento',300,15,3,30,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','303','Potenziamento',300,30,3,15,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','304','Potenziamento',300,20,3,20,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','305','Potenziamento',300,30,3,20,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','306','Potenziamento',300,30,3,20,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','307','Potenziamento',300,20,3,30,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','308','Potenziamento',300,20,3,30,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','309','Potenziamento',300,20,3,30,'sec',15,'Tappetino',NULL,NULL),(2,'Piegamenti sulle braccia','310','Potenziamento',300,15,3,30,'sec',15,'Tappetino',NULL,NULL),(3,'Abcoaster','303','Potenziamento',350,30,2,60,'sec',30,'Abcoaster',NULL,NULL),(3,'Addutori','310','Potenziamento',300,15,3,50,'sec',NULL,'Addutor Machine',NULL,NULL),(3,'Cyclette','303','Cardio',300,1,3,10,'min',60,'Cyclette',NULL,NULL),(3,'Cyclette','304','Cardio',300,1,3,10,'min',60,'Cyclette',NULL,NULL),(3,'Cyclette','310','Cardio',300,1,3,10,'min',60,'Cyclette',NULL,NULL),(3,'Salto della corda','301','Cardio',300,1,3,10,'min',60,'Corda',NULL,NULL),(3,'Squat','304','Potenziamento',250,30,3,60,'sec',30,'Squat Rack',NULL,NULL),(4,'Cyclette','301','Cardio',300,1,3,15,'min',60,'Cyclette',NULL,NULL);
/*!40000 ALTER TABLE `Esercizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fornitore`
--

DROP TABLE IF EXISTS `Fornitore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Fornitore` (
  `Partita_IVA` int(11) NOT NULL,
  `Indirizzo` varchar(45) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Num_Tel` varchar(45) NOT NULL,
  `Forma_Soc` varchar(5) NOT NULL,
  PRIMARY KEY (`Partita_IVA`,`Indirizzo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fornitore`
--

LOCK TABLES `Fornitore` WRITE;
/*!40000 ALTER TABLE `Fornitore` DISABLE KEYS */;
INSERT INTO `Fornitore` VALUES (5501,'Via Rustichello Da Pisa 87, Roma','Sport +','352367','Snc'),(5502,'Via San Marco 45, Latina','Sport ++','235574','Spa'),(5503,'Via Bonanno Pisano 67, Cagliari','Utile X Sport','32546','Snc'),(5504,'Via Repubblica 43, Cuneo','Integratori Sportivi','212345','Sapa'),(5505,'Via Mazzini 65, Napoli','Sport e Fatica','522535','Sapa'),(5506,'Via Italia 121, Torino','Sempre Sport','23456','Srl'),(5507,'Via Piemonte 45, Bergamo','SportX2','234544','Srl'),(5508,'Via Dante 34, Milano','W Sport','567483','Spa'),(5509,'Via dei Mille 14, Pisa','Sport&Sport','7658439','Spa'),(5510,'Via San Basilio 76, Catania','Sport tropS','235576','Srl');
/*!40000 ALTER TABLE `Fornitore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InformazioniFisiche`
--

DROP TABLE IF EXISTS `InformazioniFisiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InformazioniFisiche` (
  `Codice` varchar(10) NOT NULL,
  `SchedaAssociata` varchar(10) NOT NULL,
  `Altezza` int(11) NOT NULL,
  `MassaMagra` float NOT NULL,
  `MassaGrassa` float NOT NULL,
  `Peso` float NOT NULL,
  `AcquaTot` int(11) NOT NULL,
  `Stato` varchar(15) NOT NULL,
  `Entita` varchar(15) DEFAULT NULL,
  `Data` date NOT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InformazioniFisiche`
--

LOCK TABLES `InformazioniFisiche` WRITE;
/*!40000 ALTER TABLE `InformazioniFisiche` DISABLE KEYS */;
INSERT INTO `InformazioniFisiche` VALUES ('020','301',158,2,2,49,80,'Sovrappeso','Lieve','2018-03-24'),('021','302',168,3,2,55,80,'Sottopeso','Lieve','2018-03-24'),('022','303',171,2,2,60,80,'Normopeso',NULL,'2018-03-24'),('023','304',162,0.5,3,55,80,'Normopeso',NULL,'2018-03-24'),('024','305',165,4,4,60,80,'Normopeso',NULL,'2018-03-24'),('025','306',178,3,1.5,78,80,'Normopeso',NULL,'2018-03-24'),('026','307',181,1,2,85,80,'Sovrappeso','Lieve','2018-03-24'),('027','308',166,4,2.5,65,80,'Sovrappeso','Elevato','2018-03-24'),('028','309',176,3,0.67,58,80,'Normopeso',NULL,'2018-03-24'),('029','310',166,2,4,53,80,'Sottopeso','Lieve','2018-03-24');
/*!40000 ALTER TABLE `InformazioniFisiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InformazioniFisichePassate`
--

DROP TABLE IF EXISTS `InformazioniFisichePassate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InformazioniFisichePassate` (
  `Codice` varchar(10) NOT NULL,
  `Cliente` varchar(16) NOT NULL,
  `SchedaAssociata` varchar(10) NOT NULL,
  `Altezza` int(11) NOT NULL,
  `MassaMagra` int(11) NOT NULL,
  `MassaGrassa` int(11) NOT NULL,
  `Peso` float NOT NULL,
  `AcquaTot` int(11) NOT NULL,
  `Stato` varchar(15) NOT NULL,
  `Entita` varchar(15) DEFAULT NULL,
  `Data` date NOT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InformazioniFisichePassate`
--

LOCK TABLES `InformazioniFisichePassate` WRITE;
/*!40000 ALTER TABLE `InformazioniFisichePassate` DISABLE KEYS */;
INSERT INTO `InformazioniFisichePassate` VALUES ('030','aaa01','210',176,40,10,64,80,'Normopeso',NULL,'2017-12-20'),('031','bbb01','211',156,45,8,60,80,'Normopeso',NULL,'2017-12-20'),('032','ccc01','212',167,33,9,56,80,'Sovrappeso','Lieve','2017-12-20'),('033','ddd01','213',167,56,8,55,80,'Sovrappeso','Lieve','2017-12-20'),('034','eee01','214',176,45,12,65,80,'Normopeso',NULL,'2017-12-20'),('035','fff01','215',181,65,17,76,80,'Sovrappeso','Moderato','2017-12-20'),('036','ggg01','216',176,45,16,70,80,'Sovrappeso','Lieve','2017-12-20'),('037','mmm01','217',165,44,16,55,80,'Normopeso',NULL,'2017-12-20'),('038','ttt01','218',159,34,15,49,80,'Sottopeso','Lieve','2017-12-20'),('039','mmm01','219',160,34,22,52,80,'Normopeso',NULL,'2017-12-20');
/*!40000 ALTER TABLE `InformazioniFisichePassate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Integratore`
--

DROP TABLE IF EXISTS `Integratore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Integratore` (
  `Nome` varchar(45) NOT NULL,
  `Dosaggio` varchar(10) NOT NULL,
  `Prezzo` float NOT NULL,
  `Num_Pezzi` int(11) NOT NULL,
  `Sostanza` varchar(45) NOT NULL,
  PRIMARY KEY (`Nome`,`Dosaggio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Integratore`
--

LOCK TABLES `Integratore` WRITE;
/*!40000 ALTER TABLE `Integratore` DISABLE KEYS */;
INSERT INTO `Integratore` VALUES ('Energia Rapida +','25 ml',14.4,10,'Glucidi'),('Energy Gold','35 g',48,30,'Carboidrati'),('FL 100','200 mg',39,180,'Zeolite clinoptilolite'),('HTP','400 mg',43.9,100,'Proteine'),('Maltoshot','30 ml',57.6,40,'Carboidrati sequenziali'),('PRE GARA ENDURANCE','19 g',20,20,'Carboidrati complessi'),('Ramtech','10.5 g',24,20,'Amminoacidi ramificati'),('Recupero Extreme','50 g',19.2,7,'Glutammina'),('SportNuts','30 g',36,30,'Frutta secca'),('Super Dextrin','700 g',19.9,1,'Carboidrati speciali');
/*!40000 ALTER TABLE `Integratore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Interessi`
--

DROP TABLE IF EXISTS `Interessi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Interessi` (
  `Nome` varchar(45) NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Interessi`
--

LOCK TABLES `Interessi` WRITE;
/*!40000 ALTER TABLE `Interessi` DISABLE KEYS */;
INSERT INTO `Interessi` VALUES ('Atletica'),('Boxe'),('Calcio'),('ciao'),('Danza'),('Nuoto'),('Nuoto sincronizzato'),('Pallamano'),('Pallanuoto'),('Pallavolo'),('Scherma'),('Taekwondo'),('Tennis'),('Tuffi'),('Workout'),('Zumba');
/*!40000 ALTER TABLE `Interessi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Magazzino`
--

DROP TABLE IF EXISTS `Magazzino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Magazzino` (
  `Prodotto` varchar(45) NOT NULL,
  `Dosaggio` varchar(45) NOT NULL,
  `Scadenza` date NOT NULL,
  `Centro` int(11) NOT NULL,
  `Ordine` varchar(10) NOT NULL,
  `Quantita` int(11) NOT NULL,
  `Prezzo` float NOT NULL,
  `Sconto` int(11) DEFAULT NULL,
  PRIMARY KEY (`Prodotto`,`Dosaggio`,`Scadenza`,`Centro`),
  KEY `fk_18_idx` (`Centro`),
  CONSTRAINT `fk_18` FOREIGN KEY (`Centro`) REFERENCES `Centro` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Magazzino`
--

LOCK TABLES `Magazzino` WRITE;
/*!40000 ALTER TABLE `Magazzino` DISABLE KEYS */;
INSERT INTO `Magazzino` VALUES ('Energia Rapida +','25 ml','2018-08-12',3,'ordine03',200,18,NULL),('Energia Rapida +','25 ml','2018-10-02',5,'ordine05',200,18,NULL),('Energia Rapida +','25 ml','2018-10-08',1,'ordine01',100,18,NULL),('Energy Gold','35 g','2018-08-01',3,'ordine03',100,60,NULL),('Energy Gold','35 g','2018-10-01',10,'ordine11',150,60,NULL),('FL 100','200 mg','2018-07-15',6,'ordine06',150,49,NULL),('FL 100','200 mg','2018-09-10',4,'ordine04',100,49,NULL),('FL 100','200 mg','2018-09-15',2,'ordine02',80,49,NULL),('FL 100','200 mg','2018-10-10',10,'ordine11',150,49,NULL),('PRE GARA ENDURANCE','19 g','2018-09-07',2,'ordine02',200,25,NULL),('PRE GARA ENDURANCE','19 g','2018-09-15',4,'ordine04',500,25,NULL),('PRE GARA ENDURANCE','19 g','2018-10-15',5,'ordine05',150,25,NULL);
/*!40000 ALTER TABLE `Magazzino` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MonitoraggioEsercizio`
--

DROP TABLE IF EXISTS `MonitoraggioEsercizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MonitoraggioEsercizio` (
  `Istante_Inizio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Esercizio` varchar(45) NOT NULL,
  `GiornoAllenamento` int(11) NOT NULL,
  `SchedaAssociata` varchar(10) NOT NULL,
  `Centro` int(11) NOT NULL,
  `Ripetizioni` int(11) NOT NULL,
  `Serie` int(11) NOT NULL,
  `Durata` int(11) NOT NULL,
  `Info_Durata` varchar(5) NOT NULL,
  `Dispendio` int(11) NOT NULL,
  `Recupero` int(11) DEFAULT NULL,
  `Attrezzatura` varchar(45) DEFAULT NULL,
  `Regolazione` varchar(45) DEFAULT NULL,
  `Intensita` int(11) DEFAULT NULL,
  PRIMARY KEY (`Istante_Inizio`,`Esercizio`,`GiornoAllenamento`,`SchedaAssociata`),
  KEY `fk_14_idx` (`Esercizio`),
  KEY `fk_15_idx` (`GiornoAllenamento`),
  KEY `fk_16_idx` (`SchedaAssociata`),
  CONSTRAINT `fk_15` FOREIGN KEY (`GiornoAllenamento`) REFERENCES `Esercizio` (`GiornoAllenamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_16` FOREIGN KEY (`SchedaAssociata`) REFERENCES `Esercizio` (`SchedaAssociata`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MonitoraggioEsercizio`
--

LOCK TABLES `MonitoraggioEsercizio` WRITE;
/*!40000 ALTER TABLE `MonitoraggioEsercizio` DISABLE KEYS */;
INSERT INTO `MonitoraggioEsercizio` VALUES ('2017-08-01 17:35:00','Corsa',1,'303',1,1,1,10,'min',450,NULL,'Tapis Roulant','Velocita',7),('2018-04-14 09:35:00','Corsa',1,'309',1,1,1,8,'min',400,NULL,'Tapis Roulant','Velocita',6),('2018-04-14 09:50:00','Plank',1,'309',1,1,2,20,'sec',600,NULL,'Tappetino',NULL,NULL),('2018-04-14 11:05:00','Corsa',1,'309',1,1,1,15,'min',550,NULL,'Tapis Roulant','Velocita',7),('2018-04-16 17:35:00','Corsa',1,'301',1,1,1,20,'min',600,NULL,'Tapis Roulant','Velocita',8),('2018-04-16 18:00:00','Plank',1,'301',1,1,3,30,'sec',300,15,'Tappetino',NULL,NULL),('2018-04-18 17:35:00','Corsa',2,'301',1,1,1,20,'min',600,NULL,'Tapis Roulant','Velocita',8),('2018-04-18 18:00:00','Piegamenti sulle braccia',2,'301',1,20,3,30,'sec',350,15,'Tappetino',NULL,NULL),('2018-04-19 17:35:00','Salto della corda',3,'301',1,1,3,10,'min',300,60,'Corda',NULL,NULL),('2018-04-20 10:35:00','Cyclette',1,'304',1,1,3,10,'min',350,60,'Cyclette','Marcia',4),('2018-04-20 17:35:00','Cyclette',4,'301',1,1,3,20,'min',350,60,'Cyclette','Marcia',4);
/*!40000 ALTER TABLE `MonitoraggioEsercizio` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER InserisciPerformance
AFTER INSERT ON MonitoraggioEsercizio
FOR EACH ROW
BEGIN

	DECLARE _esercizio FLOAT;
    DECLARE _monitoraggio FLOAT;
    DECLARE percentuale INT;
    
    
    -- calcolo una media tra i parametri dell'esercizio svolto tenendo conto della loro importanza, cioè si sommano i valori di ogni parametro moltiplicati
    -- per la relativa importanza e si divide il tutto per la somma delle importanze
    
    SELECT ( (Ripetizioni*10) + (Serie*10) + (Durata*6) + (IF(Recupero <> NULL, Recupero * 7, 0)) + (IF(Regolazione <> NULL, Intensita * 7, 0)) )/
					(10 + 10 + 6 + (IF(Recupero <> NULL, 7, 0)) + (IF(Regolazione <> NULL, 7, 0)) ) INTO _monitoraggio
    FROM MonitoraggioEsercizio
    WHERE	Istante_Inizio = NEW.Istante_Inizio AND
					GiornoAllenamento = NEW.GiornoAllenamento AND
					SchedaAssociata = NEW.SchedaAssociata AND
                    Esercizio = NEW.Esercizio;


    -- calcolo una media tra i parametri dell'esercizio che avrebbe dovuto svolgere tenendo conto della loro importanza,
    -- cioè si sommano i valori di ogni parametro moltiplicati per la relativa importanza e si divide il tutto per la somma delle importanze

	SELECT ( (Ripetizioni*10) + (Serie*10) + (Durata*6) + (IF(Recupero <> NULL, Recupero * 7, 0)) + (IF(Regolazione <> NULL, Intensita * 7, 0)) )/
					(10 + 10 + 6 + (IF(Recupero <> NULL, 7, 0)) + (IF(Regolazione <> NULL, 7, 0)) ) INTO _esercizio
    FROM Esercizio
    WHERE	GiornoAllenamento = NEW.GiornoAllenamento AND
					SchedaAssociata = NEW.SchedaAssociata AND
                    Nome = NEW.Esercizio;
                    
                    
                    
    -- calcolo la percentuale di fedeltà dell'esercizio rapportando la media dell'esercizio svolto con la media dell'esercizio
    -- indicato dalla scheda di allenamento
    
	SET percentuale = (_monitoraggio*100)/_esercizio;
    
    
    -- Inserisco nella tabella "Performance" i dati relativi all'esercizio e la percentuale di fedeltà
    
    INSERT INTO Performance
    VALUES (NEW.Istante_Inizio, NEW.Esercizio, NEW.GiornoAllenamento, NEW.SchedaAssociata, percentuale);
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Ordine`
--

DROP TABLE IF EXISTS `Ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ordine` (
  `Codice` varchar(10) NOT NULL,
  `Centro` int(11) DEFAULT NULL,
  `Evasione` datetime DEFAULT NULL,
  `Stato` varchar(45) NOT NULL,
  `Cod_Interno` varchar(45) DEFAULT NULL,
  `Cod_Esterno` varchar(45) DEFAULT NULL,
  `ConsegnaPreferita` date DEFAULT NULL,
  `DataConsegna` date DEFAULT NULL,
  `TempoPagamento` int(11) NOT NULL,
  `Fornitore` int(11) NOT NULL,
  `IndirizzoFornitore` varchar(45) NOT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ordine`
--

LOCK TABLES `Ordine` WRITE;
/*!40000 ALTER TABLE `Ordine` DISABLE KEYS */;
INSERT INTO `Ordine` VALUES ('ordine01',1,'2018-04-16 00:00:00','Evaso','DFHGHJN','CCCFKWJV','2018-04-18',NULL,90,5501,'Via Rustichello Da Pisa 87, Roma'),('ordine02',2,'2018-03-25 00:00:00','Consegnato','FGXFGFG','CJDJVEUDD','2018-04-03','2018-04-03',90,5502,'Via San Marco 45, Latina'),('ordine03',3,'2018-02-23 00:00:00','Consegnato','DHGFGBG','CJDJVUXXX','2018-03-05','2018-03-05',90,5503,'Via Bonanno Pisano 67, Cagliari'),('ordine04',4,'2018-03-15 00:00:00','Consegnato','DFGHHFF','DCDOFAAA','2018-03-22','2018-03-22',60,5504,'Via Repubblica 43, Cuneo'),('ordine05',5,'2018-04-13 00:00:00','Evaso','FRJGHEDF','ZXFUOEHF','2018-04-10',NULL,30,5505,'Via Mazzini 65, Napoli'),('ordine06',6,'2018-01-15 00:00:00','Consegnato','SGHAETH','DJFHUEFH','2018-01-25','2018-01-22',90,5506,'Via Italia 121, Torino'),('ordine07',7,'2018-01-30 00:00:00','Consegnato','HTRHYSHG','VDJHFUED','2018-02-05','2018-02-04',90,5507,'Via Piemonte 45, Bergamo'),('ordine08',8,'2018-01-27 00:00:00','Consegnato','STHHTDZ','VDJKHUF','2018-02-10','2018-02-10',90,5508,'Via Dante 34, Milano'),('ordine09',9,'2018-03-03 00:00:00','Consegnato','JSDUHFU','DCJFHVC','2018-03-18','2018-03-16',90,5509,'Via dei Mille 14, Pisa'),('ordine10',10,'2018-03-05 00:00:00','Consegnato','SDFIUFIER','SDFIUCB','2018-03-20','2018-03-18',60,5510,'Via San Basilio 76, Catania'),('ordine11',10,'2018-04-20 00:00:00','Evaso','KWFHRUUF','FHWIUEDHV','2018-04-26',NULL,30,5505,'Via Mazzini 65, Napoli'),('ordine12',4,NULL,'Incompleto',NULL,NULL,NULL,NULL,0,5505,'Via Mazzini 65, Napoli');
/*!40000 ALTER TABLE `Ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Performance`
--

DROP TABLE IF EXISTS `Performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Performance` (
  `Istante_Inizio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Esercizio` varchar(45) NOT NULL,
  `GiornoAllenamento` int(11) NOT NULL,
  `SchedaAssociata` varchar(10) NOT NULL,
  `Fedelta` int(11) NOT NULL,
  PRIMARY KEY (`Istante_Inizio`,`Esercizio`,`GiornoAllenamento`,`SchedaAssociata`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Performance`
--

LOCK TABLES `Performance` WRITE;
/*!40000 ALTER TABLE `Performance` DISABLE KEYS */;
INSERT INTO `Performance` VALUES ('2017-08-01 17:35:00','Corsa',1,'303',73),('2018-04-14 09:35:00','Corsa',1,'309',62),('2018-04-14 09:50:00','Plank',1,'309',68),('2018-04-14 11:05:00','Corsa',1,'309',100),('2018-04-16 17:35:00','Corsa',1,'301',127),('2018-04-16 18:00:00','Plank',1,'301',100),('2018-04-18 17:35:00','Corsa',2,'301',127),('2018-04-18 18:00:00','Piegamenti sulle braccia',2,'301',114),('2018-04-19 17:35:00','Salto della corda',3,'301',100),('2018-04-20 10:35:00','Cyclette',1,'304',91),('2018-04-20 17:35:00','Cyclette',4,'301',123);
/*!40000 ALTER TABLE `Performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Piscina`
--

DROP TABLE IF EXISTS `Piscina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Piscina` (
  `Nome` varchar(45) NOT NULL,
  `Centro` int(11) NOT NULL,
  `Tipologia` varchar(45) NOT NULL,
  `Tariffa` float NOT NULL,
  PRIMARY KEY (`Nome`,`Centro`),
  KEY `fk_9_idx` (`Centro`),
  CONSTRAINT `fk_9` FOREIGN KEY (`Centro`) REFERENCES `Centro` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Piscina`
--

LOCK TABLES `Piscina` WRITE;
/*!40000 ALTER TABLE `Piscina` DISABLE KEYS */;
INSERT INTO `Piscina` VALUES ('piscina1',2,'Interna',5.5),('piscina2',1,'Interna',6),('piscina3',3,'Esterna',5.5),('piscina4',8,'Interna',7),('piscina5',9,'Esterna',7),('piscina6',5,'Interna',5),('piscina7',7,'Interna',5.5);
/*!40000 ALTER TABLE `Piscina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PiscinaCorso`
--

DROP TABLE IF EXISTS `PiscinaCorso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PiscinaCorso` (
  `Disciplina` varchar(45) NOT NULL,
  `Livello` varchar(45) NOT NULL,
  `Inizio` date NOT NULL,
  `Giorno` varchar(10) NOT NULL,
  `Orario_Inizio` time NOT NULL,
  `CentroCorso` int(11) NOT NULL,
  `Piscina` varchar(45) NOT NULL,
  `CentroPiscina` int(11) NOT NULL,
  PRIMARY KEY (`Disciplina`,`Livello`,`Inizio`,`Giorno`,`Orario_Inizio`,`Piscina`,`CentroPiscina`,`CentroCorso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PiscinaCorso`
--

LOCK TABLES `PiscinaCorso` WRITE;
/*!40000 ALTER TABLE `PiscinaCorso` DISABLE KEYS */;
INSERT INTO `PiscinaCorso` VALUES ('Nuoto','Intermedio','2017-10-10','Lunedi','08:00:00',1,'piscina2',1),('Nuoto','Intermedio','2017-10-10','Mercoledi','08:00:00',1,'piscina2',1),('Nuoto','Intermedio','2017-10-10','Venerdi','08:00:00',1,'piscina2',1),('Nuoto sincronizzato','Avanzato','2017-11-24','Lunedi','20:00:00',1,'piscina2',1),('Nuoto sincronizzato','Avanzato','2017-11-24','Mercoledi','20:00:00',1,'piscina2',1),('Nuoto sincronizzato','Avanzato','2017-11-24','Venerdi','20:00:00',1,'piscina2',1),('Tuffi','Intermedio','2018-01-30','Lunedi','19:00:00',1,'piscina2',1),('Tuffi','Intermedio','2018-01-30','Mercoledi','19:00:00',1,'piscina2',1),('Tuffi','Intermedio','2018-01-30','Venerdi','19:00:00',1,'piscina2',1);
/*!40000 ALTER TABLE `PiscinaCorso` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ControlloPiscine
BEFORE INSERT ON PiscinaCorso
FOR EACH ROW
BEGIN

	DECLARE ora_fine INT;
    DECLARE test INT DEFAULT 0;
    
    SET ora_fine = (	SELECT HOUR(Orario_Fine)
								FROM Calendario
                                WHERE	Giorno = NEW.Giorno AND
												Orario_Inizio = NEW.Orario_Inizio AND
                                                Corso = NEW.Disciplina AND
                                                Livello = NEW.Livello AND
												DataInizio = NEW.Inizio
								);

	SELECT IF(ora_fine BETWEEN HOUR(Orario_inizio) AND HOUR(Orario_Fine),1, 0) INTO test
    FROM PiscinaCorso NATURAL JOIN Calendario
    WHERE	Piscina = NEW.Piscina AND
					Giorno = NEW.Giorno;
                    
	IF (test = 1) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Piscina occupata in questa fascia oraria!';
	END IF;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Post`
--

DROP TABLE IF EXISTS `Post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Post` (
  `Account` varchar(15) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Testo` text,
  `Link` text,
  `AreaForum` varchar(15) NOT NULL,
  PRIMARY KEY (`Account`,`TimeStamp`),
  CONSTRAINT `fk_4` FOREIGN KEY (`Account`) REFERENCES `Account` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Post`
--

LOCK TABLES `Post` WRITE;
/*!40000 ALTER TABLE `Post` DISABLE KEYS */;
INSERT INTO `Post` VALUES ('anty','2017-04-10 09:37:29','Good Job!',NULL,'Allenamento'),('anty','2017-05-10 09:39:09','Che fatica',NULL,'Allenamento'),('anty','2017-06-01 09:40:49','Sto migliorando!',NULL,'Allenamento'),('anty','2018-04-11 13:18:54','Come Bolt',NULL,'Sfida'),('claudio','2018-01-10 10:45:01','Bella partita',NULL,'Svago'),('claudio','2018-04-11 13:18:54','Provate a battermi',NULL,'Sfida'),('dario','2018-03-10 10:47:18','Sto migliorando!',NULL,'Allenamento'),('eleonora','2018-02-10 11:03:03','uff',NULL,'Allenamento'),('francy','2018-04-10 10:05:16','Da provare','https://www.youtube.com/watch?v=qWy_aOlB45Y','Svago'),('gio','2018-04-10 10:06:13','Just do it',NULL,'Allenamento'),('linda','2017-12-10 11:06:38','Non ce la faccio',NULL,'Allenamento'),('linda','2018-04-11 13:20:46','Vedrai',NULL,'Sfida'),('mary','2018-04-10 10:07:35','Carichi per la partita di domani',NULL,'Svago'),('mary','2018-04-11 13:18:54','Provate questo!',NULL,'Sfida'),('star','2018-04-10 10:07:57','Wow',NULL,'Allenamento'),('tasso','2018-04-10 10:08:30','Ho perso due chili!',NULL,'Allenamento');
/*!40000 ALTER TABLE `Post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PostSfide`
--

DROP TABLE IF EXISTS `PostSfide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PostSfide` (
  `Proponente` varchar(15) NOT NULL,
  `DataLancio` date NOT NULL,
  `AutorePost` varchar(15) NOT NULL,
  `DataPost` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Proponente`,`DataLancio`,`AutorePost`,`DataPost`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PostSfide`
--

LOCK TABLES `PostSfide` WRITE;
/*!40000 ALTER TABLE `PostSfide` DISABLE KEYS */;
INSERT INTO `PostSfide` VALUES ('anty','2018-04-18','anty','2018-04-11 13:18:54'),('claudio','2017-08-11','claudio','2018-04-11 13:18:54'),('mary','2017-12-20','linda','2018-04-11 13:20:46'),('mary','2017-12-20','mary','2018-04-11 13:26:04');
/*!40000 ALTER TABLE `PostSfide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Preferenze`
--

DROP TABLE IF EXISTS `Preferenze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Preferenze` (
  `Account` varchar(15) NOT NULL,
  `Interesse` varchar(45) NOT NULL,
  PRIMARY KEY (`Account`,`Interesse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Preferenze`
--

LOCK TABLES `Preferenze` WRITE;
/*!40000 ALTER TABLE `Preferenze` DISABLE KEYS */;
INSERT INTO `Preferenze` VALUES ('anty','Danza'),('anty','Pallanuoto'),('anty','Pallavolo'),('anty','Taekwondo'),('claudio','Nuoto'),('claudio','Pallanuoto'),('claudio','Scherma'),('claudio','Taekwondo'),('dario','Pallamano'),('dario','Pallanuoto'),('dario','Pallavolo'),('dario','Taekwondo'),('eleonora','Calcio'),('eleonora','Tennis'),('francy','Pallavolo'),('francy','Tennis'),('francy','Tuffi'),('gio','Atletica'),('gio','Nuoto'),('gio','Nuoto sincronizzato'),('mary','Atletica'),('mary','Pallavolo'),('mary','Tuffi'),('poppy','Atletica'),('poppy','Boxe'),('star','Calcio'),('star','Pallavolo'),('star','Tennis'),('star','Zumba'),('tasso','Workout');
/*!40000 ALTER TABLE `Preferenze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prodotti`
--

DROP TABLE IF EXISTS `Prodotti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prodotti` (
  `Ordine` varchar(10) NOT NULL,
  `Integratore` varchar(45) NOT NULL,
  `Dosaggio` varchar(10) NOT NULL,
  `Quantita` int(11) NOT NULL,
  `Scadenza` date NOT NULL,
  PRIMARY KEY (`Ordine`,`Integratore`,`Dosaggio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prodotti`
--

LOCK TABLES `Prodotti` WRITE;
/*!40000 ALTER TABLE `Prodotti` DISABLE KEYS */;
INSERT INTO `Prodotti` VALUES ('ordine01','Energia Rapida +','25 ml',100,'2018-10-08'),('ordine01','Energy Gold','35 g',50,'2018-10-10'),('ordine02','FL 100','200 mg',80,'2018-09-15'),('ordine02','PRE GARA ENDURANCE','19 g',200,'2018-09-07'),('ordine03','Energia Rapida +','25 ml',200,'2018-08-12'),('ordine03','Energy Gold','35 g',100,'2018-08-01'),('ordine04','FL 100','200 mg',100,'2018-09-10'),('ordine04','PRE GARA ENDURANCE','19 g',500,'2018-09-15'),('ordine05','Energia Rapida +','25 ml',200,'2018-10-02'),('ordine05','PRE GARA ENDURANCE','19 g',150,'2018-10-15'),('ordine06','Energy Gold','35 g',150,'2018-07-12'),('ordine06','FL 100','200 mg',150,'2018-07-15'),('ordine11','Energy Gold','35 g',150,'2018-10-01'),('ordine11','FL 100','200 mg',150,'2018-10-10'),('ordine12','Energia Rapida +','25 ml',100,'2019-01-08'),('ordine12','FL 100','200 mg',80,'2018-12-15'),('ordine12','PRE GARA ENDURANCE','19 g',500,'2018-11-15');
/*!40000 ALTER TABLE `Prodotti` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ProdottiScaduti
BEFORE INSERT ON Prodotti
FOR EACH ROW
BEGIN 

	IF ( NEW.Scadenza <= CURRENT_DATE ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERRORE: Ordine di prodotti già scaduti!';
	END IF;
 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PropostaAlimentare`
--

DROP TABLE IF EXISTS `PropostaAlimentare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PropostaAlimentare` (
  `Proponente` varchar(15) NOT NULL,
  `DataLancio` date NOT NULL,
  `SchedaAlimentazione` varchar(10) NOT NULL,
  PRIMARY KEY (`Proponente`,`DataLancio`,`SchedaAlimentazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PropostaAlimentare`
--

LOCK TABLES `PropostaAlimentare` WRITE;
/*!40000 ALTER TABLE `PropostaAlimentare` DISABLE KEYS */;
INSERT INTO `PropostaAlimentare` VALUES ('anty','2018-04-18','401'),('claudio','2017-08-11','407'),('francy','2018-04-21','403');
/*!40000 ALTER TABLE `PropostaAlimentare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PropostaFisica`
--

DROP TABLE IF EXISTS `PropostaFisica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PropostaFisica` (
  `Proponente` varchar(15) NOT NULL,
  `DataLancio` date NOT NULL,
  `GiornoAllenamento` varchar(10) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `SchedaAssociata` varchar(10) NOT NULL,
  PRIMARY KEY (`Proponente`,`DataLancio`,`GiornoAllenamento`,`Nome`,`SchedaAssociata`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PropostaFisica`
--

LOCK TABLES `PropostaFisica` WRITE;
/*!40000 ALTER TABLE `PropostaFisica` DISABLE KEYS */;
INSERT INTO `PropostaFisica` VALUES ('anty','2018-04-18','1','Corsa','303'),('claudio','2017-08-11','3','Corsa','302'),('francy','2018-04-21','4','Plank','304'),('linda','2017-11-20','3','Salto della corda','305'),('mary','2017-12-20','2','Piegamenti sulle braccia','306');
/*!40000 ALTER TABLE `PropostaFisica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rata`
--

DROP TABLE IF EXISTS `Rata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rata` (
  `Mensilita` varchar(10) NOT NULL,
  `Contratto` int(11) NOT NULL,
  `Importo` float NOT NULL,
  `Stato` varchar(45) NOT NULL,
  `Scadenza` date NOT NULL,
  `DataPagamento` date DEFAULT NULL,
  PRIMARY KEY (`Mensilita`,`Contratto`),
  KEY `fk_7_idx` (`Contratto`),
  CONSTRAINT `fk_7` FOREIGN KEY (`Contratto`) REFERENCES `Contratto` (`Cod_Contratto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rata`
--

LOCK TABLES `Rata` WRITE;
/*!40000 ALTER TABLE `Rata` DISABLE KEYS */;
INSERT INTO `Rata` VALUES ('Aprile',103,38.5,'In attesa di pagamento','2018-04-30',NULL),('Aprile',106,55,'In attesa di pagamento','2018-04-30',NULL),('Febbraio',101,33,'Pagato','2018-02-28','2018-02-22'),('Gennaio',101,33,'Pagato','2018-01-31','2018-01-21'),('Maggio',104,47.6,'In attesa di pagamento','2018-05-30',NULL),('Maggio',107,55,'In attesa di pagamento','2018-05-30',NULL),('Marzo',102,22,'Pagato','2018-03-30','2018-03-10'),('Ottobre',110,22,'Scaduto','2017-10-30',NULL),('Settembre',110,22,'Pagato','2017-09-30','2017-09-27');
/*!40000 ALTER TABLE `Rata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RegistroDipendenti`
--

DROP TABLE IF EXISTS `RegistroDipendenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RegistroDipendenti` (
  `Centro` int(11) NOT NULL,
  `Dipendente` varchar(16) NOT NULL,
  `Lavoro` varchar(45) NOT NULL,
  `Responsabile` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`Centro`,`Dipendente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RegistroDipendenti`
--

LOCK TABLES `RegistroDipendenti` WRITE;
/*!40000 ALTER TABLE `RegistroDipendenti` DISABLE KEYS */;
INSERT INTO `RegistroDipendenti` VALUES (1,'aaa02','Direttore',NULL),(1,'bbb02','Tutor','aaa02'),(1,'ccc02','Tutor','bbb02'),(2,'ddd02','Direttore',NULL),(2,'ggg02','Medico','ddd02'),(2,'rrr02','Medico','ggg02'),(3,'bbb02','Consulente','vvv02'),(3,'vvv02','Direttore',NULL),(4,'aaa02','Direttore',NULL),(5,'bbb02','Direttore',NULL),(6,'ccc02','Direttore',NULL),(7,'ddd02','Direttore',NULL),(8,'eee02','Direttore',NULL),(9,'fff02','Direttore',NULL),(10,'ggg02','Direttore',NULL);
/*!40000 ALTER TABLE `RegistroDipendenti` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER DirettoreCentro
BEFORE INSERT ON RegistroDipendenti
FOR EACH ROW
BEGIN
	
    IF (NEW.Lavoro = 'Direttore' AND EXISTS
    
		(	SELECT *
			FROM	RegistroDipendenti RD
			WHERE	RD.Centro = NEW.Centro AND
							RD.Lavoro = 'Direttore' 
		)) THEN 
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'ERRORE: è gia presente un direttore per questo centro!';
	END IF;
																			
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ResponsabileDipendente
BEFORE INSERT ON RegistroDipendenti
FOR EACH ROW
BEGIN

	DECLARE lavoro VARCHAR(45);
	SET lavoro = ( SELECT RD.Lavoro
						FROM	RegistroDipendenti RD
						WHERE	RD.Dipendente = NEW.Responsabile AND
										RD.Centro = NEW.Centro
						);
                        
	IF (lavoro <> NEW.Lavoro AND lavoro <> 'Direttore') THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: il responsabile non può svolgere lo stesso lavoro del dipendente!';
	END IF;
    
    IF (NEW.Lavoro <> 'Direttore' AND NEW.Responsabile = NULL) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: ogni dipendente deve avere un responsabile!';
	END IF;


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Regolazione`
--

DROP TABLE IF EXISTS `Regolazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Regolazione` (
  `Attrezzatura` varchar(45) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Intensita` int(11) NOT NULL,
  PRIMARY KEY (`Attrezzatura`,`Nome`,`Intensita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Regolazione`
--

LOCK TABLES `Regolazione` WRITE;
/*!40000 ALTER TABLE `Regolazione` DISABLE KEYS */;
INSERT INTO `Regolazione` VALUES ('Adductor Machine','Peso',20),('Adductor Machine','Peso',40),('Climbmill','Velocita',5),('Climbmill','Velocita',10),('Cyclette','Marcia',2),('Cyclette','Marcia',4),('Cyclette','Marcia',6),('Deltoid Machine','Peso ',20),('Deltoid Machine','Peso',30),('Deltoid Machine','Peso',40),('Pressa','Peso',30),('Pressa','Peso',40),('Pressa','Peso',50),('Squat Rack','Peso',10),('Squat Rack','Peso',15),('Tapis Roulant','Inclinazione',3),('Tapis Roulant','Inclinazione',5),('Tapis Roulant','Velocita',6),('Tapis Roulant','Velocita',8),('Tapis Roulant','Velocita ',10);
/*!40000 ALTER TABLE `Regolazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Richiesta`
--

DROP TABLE IF EXISTS `Richiesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Richiesta` (
  `Richiedente` varchar(15) NOT NULL,
  `Ricevente` varchar(15) NOT NULL,
  `Stato` varchar(45) NOT NULL,
  PRIMARY KEY (`Richiedente`,`Ricevente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Richiesta`
--

LOCK TABLES `Richiesta` WRITE;
/*!40000 ALTER TABLE `Richiesta` DISABLE KEYS */;
INSERT INTO `Richiesta` VALUES ('anty','claudio','Accettata'),('anty','star','Rifiutata'),('claudio','anty','Accettata'),('claudio','star','In Attesa'),('dario','anty','Accettata'),('dario','gio','Rifiutata'),('eleonora','francy','Accettata'),('eleonora','gio','Accettata'),('francy','eleonora','Accettata'),('francy','mary','Accettata'),('gio','poppy','Accettata'),('gio','tasso','Accettata'),('mary','anty','Accettata'),('mary','star','Rifiutata'),('poppy','eleonora','In Attesa'),('poppy','francy','Accettata'),('star','dario','Accettata'),('star','eleonora','Accettata'),('tasso','claudio','Rifiutata'),('tasso','dario','Accettata');
/*!40000 ALTER TABLE `Richiesta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER NuovaRichiesta
BEFORE INSERT ON Richiesta
FOR EACH ROW
BEGIN

 IF(NEW.Stato <> 'In Attesa') THEN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'ERRORE: La richiesta di amicizia deve essere inserita come In Attesa!!';
 END IF;
 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER SuggerimentiCerchia
AFTER UPDATE ON Richiesta
FOR EACH ROW
BEGIN


	DECLARE _cerchia VARCHAR(45) DEFAULT NULL;
	DECLARE _amico VARCHAR(45) DEFAULT NULL;
    DECLARE finito INT DEFAULT 0;

    DECLARE cursore1 CURSOR FOR
    SELECT	C.Nome, NEW.Ricevente
	FROM	Cerchia C INNER JOIN Preferenze P ON C.Nome = P.Interesse
	WHERE	C.Account = NEW.Richiedente AND P.Account = NEW.Ricevente;
    
    DECLARE cursore2 CURSOR FOR
    SELECT	C.Nome, NEW.Richiedente
	FROM	Cerchia C INNER JOIN Preferenze P ON C.Nome = P.Interesse
	WHERE	C.Account = NEW.Ricevente AND P.Account = NEW.Richiedente;
    
    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finito = 1;

    
	IF (NEW.Stato = 'Accettata') THEN
    
	BEGIN
    
		OPEN cursore1;
        
        loop1: LOOP
        
			FETCH cursore1 INTO _cerchia, _amico;
            
            IF finito = 1 THEN
				LEAVE loop1;
			END IF;
    
			
			
				INSERT INTO AmiciCerchia
				VALUES (_cerchia, NEW.Richiedente, _amico, 'Suggerito');
        
			
		
        END LOOP;
        
        CLOSE cursore1;
    
		SET _cerchia = NULL;
		SET _amico = NULL;
		SET finito = 0;
    
		OPEN cursore2;
        
        loop2: LOOP
        
			FETCH cursore2 INTO _cerchia, _amico;
            
            IF finito = 1 THEN
				LEAVE loop2;
			END IF;
    
			
		
				INSERT INTO AmiciCerchia
				VALUES (_cerchia, NEW.Ricevente, _amico, 'Suggerito');
        
			
		
        END LOOP;
        
	END;
        
	
    END IF;
    

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Risposta`
--

DROP TABLE IF EXISTS `Risposta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Risposta` (
  `AutorePost` varchar(15) NOT NULL,
  `DataPost` date NOT NULL,
  `AutoreRisposta` varchar(15) NOT NULL,
  `Testo` text,
  `Voto` tinyint(4) NOT NULL,
  PRIMARY KEY (`AutorePost`,`DataPost`,`AutoreRisposta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Risposta`
--

LOCK TABLES `Risposta` WRITE;
/*!40000 ALTER TABLE `Risposta` DISABLE KEYS */;
INSERT INTO `Risposta` VALUES ('anty','2017-04-10','claudio','Hai ragione',5),('anty','2017-05-10','eleonora','Tieni duro',5),('anty','2017-05-10','mary','Non mollare',5),('anty','2017-06-01','tasso','Bravissimo',5),('claudio','2018-01-10','anty','Ben detto',5),('claudio','2018-01-10','star','Insomma',3),('dario','2018-03-10','francy','Non abbastanza',4),('dario','2018-03-10','linda',NULL,5),('eleonora','2018-02-10','francy','Forza!',4),('eleonora','2018-02-10','gio','Non ti impegni abbastanza!',3),('francy','2018-04-10','claudio','Wow',5),('gio','2018-02-10','anty','Non mollare',4),('tasso','2018-04-10','eleonra','Complimenti!!',4);
/*!40000 ALTER TABLE `Risposta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AggiornaCredibilita
AFTER INSERT ON Risposta
FOR EACH ROW
BEGIN

	DECLARE NumeroPost INT DEFAULT 0;
    DECLARE Valutazione INT DEFAULT 0;
    
    SELECT SUM(Voto), COUNT(*) INTO Valutazione, NumeroPost
    FROM Risposta
	WHERE AutorePost = NEW.AutorePost;

	UPDATE Account
    SET	Credibilita = Valutazione/NumeroPost
    WHERE	Username = NEW.AutorePost;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `SalaCorso`
--

DROP TABLE IF EXISTS `SalaCorso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SalaCorso` (
  `Disciplina` varchar(45) NOT NULL,
  `Livello` varchar(45) NOT NULL,
  `Inizio` date NOT NULL,
  `Giorno` varchar(10) NOT NULL,
  `Orario_Inizio` time NOT NULL,
  `CentroCorso` int(11) NOT NULL,
  `Sala` varchar(45) NOT NULL,
  `CentroSala` int(11) NOT NULL,
  PRIMARY KEY (`Disciplina`,`Livello`,`Inizio`,`Giorno`,`Orario_Inizio`,`CentroCorso`,`Sala`,`CentroSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SalaCorso`
--

LOCK TABLES `SalaCorso` WRITE;
/*!40000 ALTER TABLE `SalaCorso` DISABLE KEYS */;
INSERT INTO `SalaCorso` VALUES ('Boxe','Avanzato','2018-02-05','Lunedi','18:00:00',4,'sala4',4),('Boxe','Avanzato','2018-02-05','Mercoledi','18:00:00',4,'sala4',4),('Boxe','Avanzato','2018-02-05','Venerdi','18:00:00',4,'sala4',4),('Boxe','Principiante','2018-01-20','Giovedi','17:00:00',4,'sala8',4),('Boxe','Principiante','2018-01-20','Martedi','17:00:00',4,'sala4',4),('Pallavolo','Intermedio','2018-05-11','Giovedi','19:00:00',10,'sala5',10),('Pallavolo','Intermedio','2018-05-11','Lunedi','19:00:00',10,'sala5',10),('Taekwondo','Avanzato','2018-01-07','Lunedi','19:00:00',1,'sala1',1),('Taekwondo','Avanzato','2018-01-07','Mercoledi','19:00:00',1,'sala1',1),('Taekwondo','Avanzato','2018-01-07','Venerdi','19:00:00',1,'sala1',1),('Taekwondo','Principiante','2017-10-10','Giovedi','17:00:00',1,'sala1',1),('Taekwondo','Principiante','2017-10-10','Martedi','17:00:00',1,'sala1',1),('Tennis','Avanzato','2017-08-21','Lunedi','20:00:00',6,'sala9',6),('Tennis','Avanzato','2017-08-21','Mercoledi','20:00:00',6,'sala9',6),('Tennis','Avanzato','2017-08-21','Venerdi','20:00:00',6,'sala9',6),('Zumba','Avanzato','2017-04-04','Martedi','14:00:00',2,'sala7',3);
/*!40000 ALTER TABLE `SalaCorso` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ControlloSale 
BEFORE INSERT ON SalaCorso
FOR EACH ROW
BEGIN

	DECLARE ora_fine INT;
    DECLARE test INT DEFAULT 0;
    
    SET ora_fine = (	SELECT HOUR(Orario_Fine)
								FROM Calendario
                                WHERE	Giorno = NEW.Giorno AND
												Orario_Inizio = NEW.Orario_Inizio AND
                                                Corso = NEW.Disciplina AND
                                                Livello = NEW.Livello AND
												DataInizio = NEW.Inizio
								);

	SELECT IF(ora_fine BETWEEN HOUR(Orario_inizio) AND HOUR(Orario_Fine),1, 0) INTO test
    FROM SalaCorso NATURAL JOIN Calendario
    WHERE	Sala = NEW.Sala AND
					Giorno = NEW.Giorno;
                    
	IF (test = 1) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Sala occupata in questa fascia oraria!';
	END IF;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `SalaFitness`
--

DROP TABLE IF EXISTS `SalaFitness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SalaFitness` (
  `Nome` varchar(45) NOT NULL,
  `Centro` int(11) NOT NULL,
  `Qualita` varchar(45) NOT NULL,
  `Tipologia` varchar(45) NOT NULL,
  `Responsabile` varchar(16) NOT NULL,
  PRIMARY KEY (`Nome`,`Centro`),
  KEY `fk_8_idx` (`Centro`),
  CONSTRAINT `fk_8` FOREIGN KEY (`Centro`) REFERENCES `Centro` (`Codice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SalaFitness`
--

LOCK TABLES `SalaFitness` WRITE;
/*!40000 ALTER TABLE `SalaFitness` DISABLE KEYS */;
INSERT INTO `SalaFitness` VALUES ('sala1',1,'Silver','Cardio','ccc02'),('sala10',9,'Gold','Potenziamento','ddd02'),('sala2',1,'Platinum','Potenziamento','bbb02'),('sala3',2,'Silver','Cardio','ddd02'),('sala4',4,'Gold','Stretching','rrr02'),('sala5',10,'Platinum','Relax','aaa02'),('sala6',2,'Silver','Corso','aaa02'),('sala7',3,'Gold','Corso','fff02'),('sala8',4,'Platinum','Cardio','ggg02'),('sala9',6,'Gold','Potenziamento','ccc02');
/*!40000 ALTER TABLE `SalaFitness` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SchedaAlimentazione`
--

DROP TABLE IF EXISTS `SchedaAlimentazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SchedaAlimentazione` (
  `Codice` varchar(10) NOT NULL,
  `InformazioniFisiche` varchar(10) NOT NULL,
  `Contratto` int(11) NOT NULL,
  `Obiettivo` varchar(45) NOT NULL,
  `Num_Pasti` int(11) NOT NULL,
  `Info_Pasti` text NOT NULL,
  `Fabbisogno` int(11) NOT NULL,
  `Inizio` date NOT NULL,
  `Fine` date NOT NULL,
  `Medico` varchar(16) NOT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SchedaAlimentazione`
--

LOCK TABLES `SchedaAlimentazione` WRITE;
/*!40000 ALTER TABLE `SchedaAlimentazione` DISABLE KEYS */;
INSERT INTO `SchedaAlimentazione` VALUES ('401','020',101,'Dimagrimento',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1000,'2018-02-25','2018-03-25','aaa02'),('402','021',102,'Aumento peso',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',2000,'2018-02-25','2018-03-25','ggg02'),('403','022',103,'Aumento peso',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1800,'2018-02-25','2018-03-25','ggg02'),('404','023',104,'Dimagrimento',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1000,'2018-02-25','2018-03-25','rrr02'),('405','024',105,'Mantenimeto',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1500,'2018-02-25','2018-03-25','aaa02'),('406','025',106,'Mantenimento',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1500,'2018-02-25','2018-03-25','aaa02'),('407','026',107,'Dimagrimnto',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1000,'2018-02-25','2018-03-25','rrr02'),('408','027',108,'Dimagrimento',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1000,'2018-02-25','2018-03-25','ggg02'),('409','028',109,'Aumento peso',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',2000,'2018-02-25','2018-03-25','ggg02'),('410','029',110,'Aumento peso',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',2000,'2018-02-25','2018-03-25','aaa02');
/*!40000 ALTER TABLE `SchedaAlimentazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SchedaAllenamento`
--

DROP TABLE IF EXISTS `SchedaAllenamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SchedaAllenamento` (
  `Codice` varchar(10) NOT NULL,
  `Contratto` varchar(45) NOT NULL,
  `Inizio` date NOT NULL,
  `Fine` date NOT NULL,
  `Allenamenti` int(11) NOT NULL,
  `Tutor` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SchedaAllenamento`
--

LOCK TABLES `SchedaAllenamento` WRITE;
/*!40000 ALTER TABLE `SchedaAllenamento` DISABLE KEYS */;
INSERT INTO `SchedaAllenamento` VALUES ('301','101','2018-03-15','2018-04-30',3,NULL),('302','102','2018-03-15','2018-04-30',2,'bbb02'),('303','103','2018-03-15','2018-04-30',4,NULL),('304','104','2018-03-15','2018-04-30',4,'ddd02'),('305','105','2018-03-15','2018-04-30',3,'eee02'),('306','106','2018-03-15','2018-04-30',3,NULL),('307','107','2018-03-15','2018-04-30',3,'rrr02'),('308','108','2018-03-15','2018-04-30',2,NULL),('309','109','2018-03-15','2018-04-30',4,NULL),('310','110','2018-03-15','2018-04-30',3,'vvv02');
/*!40000 ALTER TABLE `SchedaAllenamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SchedeAlPassate`
--

DROP TABLE IF EXISTS `SchedeAlPassate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SchedeAlPassate` (
  `Codice` varchar(10) NOT NULL,
  `InformazioniFIsiche` varchar(10) NOT NULL,
  `Contratto` int(11) NOT NULL,
  `Obiettivo` varchar(45) NOT NULL,
  `Num_Pasti` int(11) NOT NULL,
  `Info_Pasti` text NOT NULL,
  `Fabbisogno` int(11) NOT NULL,
  `Inizio` date NOT NULL,
  `Fine` date NOT NULL,
  `Medico` varchar(16) NOT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SchedeAlPassate`
--

LOCK TABLES `SchedeAlPassate` WRITE;
/*!40000 ALTER TABLE `SchedeAlPassate` DISABLE KEYS */;
INSERT INTO `SchedeAlPassate` VALUES ('411','050',201,'Dimagrimento',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1000,'2017-02-25','2017-03-25','aaa02'),('412','051',202,'Aumento peso',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',2000,'2017-02-25','2017-03-25','ggg02'),('413','052',203,'Aumento peso',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1800,'2017-02-25','2017-03-25','ggg02'),('414','053',204,'Dimagrimento',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1000,'2017-02-25','2017-03-25','rrr02'),('415','054',205,'Mantenimeto',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1500,'2017-02-25','2017-03-25','aaa02'),('416','055',206,'Mantenimento',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1500,'2017-02-25','2017-03-25','aaa02'),('417','056',207,'Dimagrimnto',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1000,'2017-02-25','2017-03-25','rrr02'),('418','057',208,'Dimagrimento',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',1000,'2017-02-25','2017-03-25','ggg02'),('419','058',209,'Aumento peso',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',2000,'2017-02-25','2017-03-25','ggg02'),('420','059',210,'Aumento peso',4,'Colazione\nThè g 200\nFette Biscottate g 10\nZucchero g 10\n\nSpuntino\nFrutta Fresca g 200\n\nPranzo\nPasta o Riso g 50\nVerdura g 200\nPane g 25\nOlio g 5\n\nSpuntino\nFrutta Fresca g 200\n\nCena\nSecondo \nVedere \"Secondi\"\nVerdura g 200\nPane g 25\nOlio g 5',2000,'2017-02-25','2017-03-25','aaa02');
/*!40000 ALTER TABLE `SchedeAlPassate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SchedeAllPassate`
--

DROP TABLE IF EXISTS `SchedeAllPassate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SchedeAllPassate` (
  `Codice` varchar(10) NOT NULL,
  `Contratto` varchar(45) NOT NULL,
  `Inizio` date NOT NULL,
  `Fine` date NOT NULL,
  `Allenamenti` int(11) NOT NULL,
  `Tutor` varchar(16) NOT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SchedeAllPassate`
--

LOCK TABLES `SchedeAllPassate` WRITE;
/*!40000 ALTER TABLE `SchedeAllPassate` DISABLE KEYS */;
INSERT INTO `SchedeAllPassate` VALUES ('401','201','2017-03-15','2017-04-30',3,'aaa02'),('402','202','2017-03-15','2017-04-30',2,'bbb02'),('403','203','2017-03-15','2017-04-30',4,'ccc02'),('404','204','2017-03-15','2017-04-30',4,'ddd02'),('405','205','2017-03-15','2017-04-30',3,'eee02'),('406','206','2017-03-15','2017-04-30',3,'fff02'),('407','207','2017-03-15','2017-04-30',3,'rrr02'),('408','208','2017-03-15','2017-04-30',2,'aaa02'),('409','209','2017-03-15','2017-04-30',4,'bbb02'),('410','210','2017-03-15','2017-04-30',3,'vvv02');
/*!40000 ALTER TABLE `SchedeAllPassate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sfida`
--

DROP TABLE IF EXISTS `Sfida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sfida` (
  `Proponente` varchar(15) NOT NULL,
  `Data_Lancio` date NOT NULL,
  `Scopo` varchar(45) NOT NULL,
  `Data_Inizio` date NOT NULL,
  `DataFine` date DEFAULT NULL,
  `Scadenza` date NOT NULL,
  `Vincitore` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Proponente`,`Data_Lancio`),
  CONSTRAINT `fk_5` FOREIGN KEY (`Proponente`) REFERENCES `Account` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sfida`
--

LOCK TABLES `Sfida` WRITE;
/*!40000 ALTER TABLE `Sfida` DISABLE KEYS */;
INSERT INTO `Sfida` VALUES ('anty','2018-04-18','100 metri in 13 secondi','2018-04-20',NULL,'2018-07-20',NULL),('claudio','2017-08-11','50 piegamenti sulle braccia','2017-08-15','2017-09-01','2017-09-15','tasso'),('francy','2018-04-21','100 salti di corda in un minuto','2018-04-23',NULL,'2018-05-23',NULL),('linda','2017-11-20','120 secondi Plank','2018-01-30','2018-02-20','2018-02-28','anty'),('linda','2018-04-17','120 squat','2018-04-18',NULL,'2018-05-05',NULL),('mary','2017-12-20','Non ingrassare durante le vacanze natalizie','2017-12-22','2018-01-07','2018-01-07','gio');
/*!40000 ALTER TABLE `Sfida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Spogliatoio`
--

DROP TABLE IF EXISTS `Spogliatoio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Spogliatoio` (
  `ID` varchar(45) NOT NULL,
  `Centro` int(11) NOT NULL,
  `Capienza` varchar(45) NOT NULL,
  `Posizione` varchar(10) NOT NULL,
  `PostiDisponibili` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Spogliatoio`
--

LOCK TABLES `Spogliatoio` WRITE;
/*!40000 ALTER TABLE `Spogliatoio` DISABLE KEYS */;
INSERT INTO `Spogliatoio` VALUES ('D_001_01',1,'120','Interno',120),('D_001_02',1,'120','Esterno',120),('D_002_01',2,'120','Interno',120),('D_002_02',2,'120','Esterno',120),('D_003_01',3,'120','Interno',120),('D_004_01',4,'120','Interno',120),('D_005_01',5,'120','Interno',120),('U_001_01',1,'120','Interno',120),('U_001_02',1,'120','Esterno',120),('U_003_01',3,'120','Esterno',120),('U_004_01',4,'120','Interno',120),('U_005_01',5,'120','Interno',120);
/*!40000 ALTER TABLE `Spogliatoio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TurnazionePersonale`
--

DROP TABLE IF EXISTS `TurnazionePersonale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TurnazionePersonale` (
  `Dipendente` varchar(16) NOT NULL,
  `Data` date NOT NULL,
  `Inizio` time NOT NULL,
  `Fine` time NOT NULL,
  `Centro` int(11) NOT NULL,
  PRIMARY KEY (`Dipendente`,`Data`,`Inizio`),
  CONSTRAINT `fk_6` FOREIGN KEY (`Dipendente`) REFERENCES `Dipendente` (`CodFiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TurnazionePersonale`
--

LOCK TABLES `TurnazionePersonale` WRITE;
/*!40000 ALTER TABLE `TurnazionePersonale` DISABLE KEYS */;
INSERT INTO `TurnazionePersonale` VALUES ('aaa02','2017-08-02','08:00:00','13:00:00',1),('ccc02','2017-12-12','18:00:00','20:00:00',3),('ddd02','2018-01-01','19:00:00','22:00:00',4),('fff02','2018-04-01','12:00:00','18:00:00',6),('rrr02','2018-02-02','10:00:00','18:00:00',5);
/*!40000 ALTER TABLE `TurnazionePersonale` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER OrarioLavoro
BEFORE INSERT ON TurnazionePersonale
FOR EACH ROW
BEGIN

	IF (	(MINUTE(NEW.Inizio) <> 0 ) OR
			(SECOND(NEW.Inizio) <> 0 ) OR
            (MINUTE(NEW.Fine) <> 0 ) OR
			(SECOND(NEW.Fine) <> 0)
		)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Formato orario non adeguato';
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ControlloLavoro
BEFORE INSERT ON TurnazionePersonale
FOR EACH ROW
BEGIN
	
    DECLARE ore TIME DEFAULT '00:00:00';
    DECLARE ore_tot INT DEFAULT 0;
    DECLARE finito INT DEFAULT 0;
    
    DECLARE cursore CURSOR FOR
    SELECT TIMEDIFF(Fine, Inizio)
    FROM TurnazionePersonale
    WHERE	Dipendente = NEW.Dipendente AND
					Data = NEW.Data;
   
   DECLARE CONTINUE HANDLER
   FOR NOT FOUND SET finito = 1;
   
   OPEN cursore;
   
	copia: LOOP
   
		FETCH cursore INTO ore;
    
		IF Finito = 1 THEN
			LEAVE copia;
		END IF;
		
		SET ore_tot = ore_tot + HOUR(ore);
    
	END LOOP;

	IF (ore_tot + HOUR((TIMEDIFF(NEW.Fine, NEW.Inizio) ) ) > 8) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: un dipendente non può lavorare più di 8 ore al giorno';
	END IF;


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER LuogoLavoro
BEFORE INSERT ON TurnazionePersonale
FOR EACH ROW
BEGIN

	IF EXISTS (	SELECT *
						FROM TurnazionePersonale T
						WHERE	T.Dipendente = NEW.Dipendente AND
										T.Data = NEW.Data AND
                                        T.Centro <> NEW.Centro
						) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: il dipendente non può lavorare in due diversi centri lo stesso giorno';
	END IF;					

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Vendite`
--

DROP TABLE IF EXISTS `Vendite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vendite` (
  `Cliente` varchar(16) NOT NULL,
  `Prodotto` varchar(45) NOT NULL,
  `Dosaggio` varchar(45) NOT NULL,
  `Scadenza` date NOT NULL,
  `Centro` int(11) NOT NULL,
  `Quantita` int(11) NOT NULL,
  `Data` datetime NOT NULL,
  PRIMARY KEY (`Cliente`,`Prodotto`,`Dosaggio`,`Scadenza`,`Centro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vendite`
--

LOCK TABLES `Vendite` WRITE;
/*!40000 ALTER TABLE `Vendite` DISABLE KEYS */;
INSERT INTO `Vendite` VALUES ('aaa01','Energia Rapida +','25 ml','2018-10-08',1,2,'2018-04-07 00:00:00'),('aaa01','FL 100','200 mg','2018-09-15',2,1,'2018-03-11 00:00:00'),('bbb01','Energy Gold','35 g','2018-10-01',10,1,'2018-04-12 00:00:00'),('bbb01','PRE GARA ENDURANCE','19 g','2018-09-15',4,2,'2018-04-21 00:00:00'),('ccc01','Energia Rapida +','25 ml','2018-10-08',1,2,'2018-04-05 00:00:00'),('ccc01','FL 100','200 mg','2018-09-15',2,1,'2018-03-12 00:00:00'),('ddd01','Energy Gold','35 g','2018-10-01',10,1,'2018-03-28 00:00:00'),('ddd01','PRE GARA ENDURANCE','19 g','2018-09-15',4,2,'2018-04-18 00:00:00'),('fff01','Energia Rapida +','25 ml','2018-10-08',1,2,'2018-04-09 00:00:00'),('fff01','FL 100','200 mg','2018-09-15',2,1,'2018-03-14 00:00:00'),('ggg01','Energy Gold','35 g','2018-10-01',10,1,'2018-03-21 00:00:00'),('ggg01','PRE GARA ENDURANCE','19 g','2018-09-15',4,2,'2018-03-26 00:00:00');
/*!40000 ALTER TABLE `Vendite` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ProdottoNonDisponibile
BEFORE INSERT ON Vendite
FOR EACH ROW
BEGIN
	DECLARE NumProdotti INT DEFAULT 0;
	SET NumProdotti = (	SELECT M.Quantita
										FROM Magazzino M INNER JOIN Ordine O 
													ON M.Ordine = O.Codice
										WHERE	M.Prodotto = NEW.Prodotto AND
														M.Scadenza = NEW.Scadenza AND
														M.Dosaggio = NEW.Dosaggio AND
														M.Centro = NEW.Centro AND
														O.Stato = 'Consegnato'
									);
	IF(NumProdotti < NEW.Quantita OR NOT EXISTS(	SELECT *
																						FROM Magazzino M
																						WHERE	M.Prodotto = NEW.Prodotto AND
																										M.Scadenza = NEW.Scadenza AND
                                                                                                        M.Centro = NEW.Centro
																						)) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Prodotto NON disponibile';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER VenditaProdotto
AFTER INSERT ON Vendite
FOR EACH ROW
BEGIN
	UPDATE Magazzino
    SET Quantita = Quantita - NEW.Quantita
    WHERE	Prodotto = NEW.Prodotto AND
					Scadenza = NEW.Scadenza AND
					Centro = NEW.Centro AND
					Dosaggio = NEW.Dosaggio;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `ingressipercliente`
--

DROP TABLE IF EXISTS `ingressipercliente`;
/*!50001 DROP VIEW IF EXISTS `ingressipercliente`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ingressipercliente` AS SELECT 
 1 AS `Cliente`,
 1 AS `IngressiSale`,
 1 AS `IngressiPiscineInt`,
 1 AS `IngressiPiscineEst`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ingressipiscineest`
--

DROP TABLE IF EXISTS `ingressipiscineest`;
/*!50001 DROP VIEW IF EXISTS `ingressipiscineest`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ingressipiscineest` AS SELECT 
 1 AS `Cliente`,
 1 AS `NumeroIngressi`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ingressipiscineint`
--

DROP TABLE IF EXISTS `ingressipiscineint`;
/*!50001 DROP VIEW IF EXISTS `ingressipiscineint`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ingressipiscineint` AS SELECT 
 1 AS `Cliente`,
 1 AS `NumeroIngressi`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `partecipanticorso`
--

DROP TABLE IF EXISTS `partecipanticorso`;
/*!50001 DROP VIEW IF EXISTS `partecipanticorso`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `partecipanticorso` AS SELECT 
 1 AS `Centro`,
 1 AS `Disciplina`,
 1 AS `Livello`,
 1 AS `Inizio`,
 1 AS `Partecipanti`,
 1 AS `PercentualePartecipanti`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `utilizzi`
--

DROP TABLE IF EXISTS `utilizzi`;
/*!50001 DROP VIEW IF EXISTS `utilizzi`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `utilizzi` AS SELECT 
 1 AS `Centro`,
 1 AS `DAY(M.Istante_Inizio)`,
 1 AS `Attrezzatura`,
 1 AS `NumeroUtilizzi`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `utilizzimese`
--

DROP TABLE IF EXISTS `utilizzimese`;
/*!50001 DROP VIEW IF EXISTS `utilizzimese`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `utilizzimese` AS SELECT 
 1 AS `Centro`,
 1 AS `DAY(M.Istante_Inizio)`,
 1 AS `Attrezzatura`,
 1 AS `NumeroUtilizzi`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'fitness'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `Op1` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `Op1` ON SCHEDULE EVERY 2 WEEK STARTS '2018-05-01 00:00:01' ON COMPLETION NOT PRESERVE ENABLE DO SELECT D.CodFiscale AS Cliente, D.Nome, D.Cognome, D.Sesso, D.DataNascita, C.Codice, C.Indirizzo, C.Citta
 FROM RegistroDipendenti RD INNER JOIN Dipendente D
   ON RD.Dipendente = D.CodFiscale
   INNER JOIN Centro C ON RD.Centro = C.Codice
 GROUP BY D.CodFiscale, RD.Centro
 HAVING D.DataNascita + INTERVAL 35 YEAR > CURRENT_DATE() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'fitness'
--
/*!50003 DROP PROCEDURE IF EXISTS `AnalisiAttrezzature` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AnalisiAttrezzature`(IN _centro INT)
BEGIN

	-- Considerando il centro a cui sono interessata, proietto il numero medio di utilizzi di ogni attrezzatura nel mese corrente e 
    -- il numero di esemplari di tale attrezzatura in quel centro. 
    -- Si ipotizza che se un'attrezzatura viene utilizzata più di 10 volte in un giorno possa essere necessario l'acquisto di nuovi esemplari.

	SELECT	D.Centro, D.Attrezzatura, D.UtilizziMedi, D2.AttrezzaturePresenti,
					IF (D.UtilizziMedi > AttrezzaturePresenti * 10, 'Necessario acquisto di nuovi macchinari',
						'Dimensionamento macchinario adeguato agli utilizzi') AS Messaggio
	FROM	(	SELECT U.Centro, U.Attrezzatura, AVG(U.NumeroUtilizzi) AS UtilizziMedi
					FROM UtilizziMese U
					GROUP BY U.Centro, U.Attrezzatura
				) AS D
				
					NATURAL JOIN
                
				(	SELECT S.Centro, A.Nome AS Attrezzatura, COUNT(*) AS AttrezzaturePresenti
					FROM Attrezzatura A INNER JOIN SalaFitness S ON A.Sala = S.Nome
					GROUP BY S.Centro, A.Nome
				) AS D2
	WHERE D.Centro = _centro;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AnalisiCorsi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AnalisiCorsi`(IN _centro INT(11))
BEGIN

	-- Mostra i corsi scarsamente frequentati (cioè partecipazione inferiore al 60%) del centro a
    -- cui sono interessata

	SELECT P.Disciplina, P.Livello, P.PercentualePartecipanti
	FROM PartecipantiCorso P
	WHERE	P.PercentualePartecipanti < 60 AND
					P.Centro = _centro
	ORDER BY P.PercentualePartecipanti;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `calcola` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcola`()
BEGIN

    DECLARE monitoraggio FLOAT DEFAULT 0;
    DECLARE Esercizio_ FLOAT DEFAULT 0;
    DECLARE percentuale FLOAT DEFAULT 0;
    
    DECLARE inizio TIMESTAMP;
    DECLARE esercizio VARCHAR (45);
    DECLARE giorno INT;
    DECLARE scheda VARCHAR(10);
    DECLARE finito INT DEFAULT 0;
    
    DECLARE cursore1 CURSOR FOR
	SELECT ( (Ripetizioni*10) + (Serie*10) + (Durata*6) + (IF(Recupero <> NULL, Recupero * 7, 0)) + (IF(Regolazione <> NULL, Intensita * 7, 0)) )/
					(10 + 10 + 6 + (IF(Recupero <> NULL, 7, 0)) + (IF(Regolazione <> NULL, 7, 0)) ), Istante_inizio, Esercizio, GiornoAllenamento, SchedaAssociata
    FROM MonitoraggioEsercizio;
                    
	DECLARE cursore2 CURSOR FOR
	SELECT ( (Ripetizioni*10) + (Serie*10) + (Durata*6) + (IF(Recupero <> NULL, Recupero * 7, 0)) + (IF(Regolazione <> NULL, Intensita * 7, 0)) )/
					(10 + 10 + 6 + (IF(Recupero <> NULL, 7, 0)) + (IF(Regolazione <> NULL, 7, 0)) )
    FROM Esercizio
    WHERE	Nome = esercizio AND
					GiornoAllenamento = giorno AND
                    SchedaAssociata = scheda;
    
    DECLARE CONTINUE HANDLER 
    FOR NOT FOUND SET finito = 1;
    
    OPEN cursore1;
    OPEN cursore2;
    
    ciclo: LOOP
    
		FETCH cursore1 INTO monitoraggio, inizio, esercizio, giorno, scheda;
        FETCH cursore2 INTO Esercizio_;
        
        IF finito = 1 THEN
			LEAVE ciclo;
		END IF;
        
        SET percentuale = (monitoraggio*100)/Esercizio_;
    
		INSERT INTO Performance
        VALUES (inizio, esercizio, giorno, scheda, percentuale);
    
    END LOOP;
    
    CLOSE cursore1;
    CLOSE cursore2;	
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalcolaPromozione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalcolaPromozione`( IN _cliente VARCHAR(16) )
BEGIN

	DECLARE Interne INT;
    DECLARE Esterne INT;
    DECLARE Sale INT;

	-- Per ogni cliente verifico se sono stati effettuati più ingressi da quelli specificati dal proprio contratto, in modo da rendere possibile la creazione di pacchetti
	-- promozionali su misura per tale cliente

	SELECT	IF(IC.IngressiPiscineInt - CC.PiscineInt > 0, IC.IngressiPiscineInt - CC.PiscineInt, NULL) AS IngressiPiscineIntOltreSoglia,
					IF(IC.IngressiPiscineEst - CC.PiscineEst > 0, IC.IngressiPiscineEst - CC.PiscineEst, NULL) AS IngressiPiscineEstOltreSoglia,
					IF(IC.IngressiSale - (CC.Ingressi_max*4) > 0, IC.IngressiSale - (CC.Ingressi_max*4), NULL) AS IngressiSaleOltreSoglia
                    INTO Interne, Esterne, Sale
	FROM Contratto C INNER JOIN CaratteristicheContratto CC ON C.Cod_Contratto = CC.Contratto
				NATURAL JOIN IngressiPerCliente IC
	WHERE C.Cliente = _cliente;
    
    
    -- Confeziono pacchetti promozionali standard a seconda del numero di ingressi fatti oltre la soglia 
    -- massima dettata dai contratti
    
    DROP TABLE IF EXISTS Promozione;
    CREATE TEMPORARY TABLE Promozione (
		Luogo VARCHAR (45),
        Num_Ingressi INT, 
        Sconto VARCHAR(10),
        PRIMARY KEY (Luogo)
	);
    
    IF (Interne > 0 AND Interne <= 5) THEN
		INSERT INTO Promozione
        VALUES ('Piscine interne', 5, '10%');
	END IF;
	IF (Interne > 5 AND Interne <= 10) THEN
		INSERT INTO Promozione
        VALUES ('Piscine interne', 10, '15%');
	END IF;
	IF (Interne > 10) THEN
		INSERT INTO Promozione
        VALUES ('Piscine interne', 15, '20%');
	END IF;
    
    
    IF (Esterne > 0 AND Esterne <= 5) THEN
		INSERT INTO Promozione
        VALUES ('Piscine Esterne', 5, '10%');
	END IF;
	IF (Esterne> 5 AND Esterne <= 10) THEN
		INSERT INTO Promozione
        VALUES ('Piscine esterne', 10, '15%');
	END IF;
	IF (Esterne > 10) THEN
		INSERT INTO Promozione
        VALUES ('Piscine esterne', 15, '20%');
	END IF;
    
    
    IF (Sale > 0 AND Sale <= 5) THEN
		INSERT INTO Promozione
        VALUES ('Sale', 5, '10%');
	END IF;
	IF (Sale> 5 AND Sale <= 10) THEN
		INSERT INTO Promozione
        VALUES ('Sale', 10, '15%');
	END IF;
	IF (Sale > 10) THEN
		INSERT INTO Promozione
        VALUES ('Sale', 15, '20%');
	END IF;
    
    
    SELECT *
    FROM Promozione;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ciao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ciao`()
BEGIN 


-- Per ogni cliente verifico se sono stati effettuati più ingressi da quelli specificati dal proprio contratto, in modo da rendere possibile la creazione di pacchetti
-- promozionali su misura per tale cliente

SELECT	Cliente, IF(IC.IngressiPiscineInt - CC.PiscineInt > 0, IC.IngressiPiscineInt - CC.PiscineInt, NULL) AS IngressiPiscineIntOltreSoglia,
				IF(IC.IngressiPiscineEst - CC.PiscineEst > 0, IC.IngressiPiscineEst - CC.PiscineEst, NULL) AS IngressiPiscineEstOltreSoglia,
                IF(IC.IngressiSale - (CC.Ingressi_max*4) > 0, IC.IngressiSale - (CC.Ingressi_max*4), NULL) AS IngressiSaleOltreSoglia
FROM Contratto C INNER JOIN CaratteristicheContratto CC ON C.Cod_Contratto = CC.Contratto
			NATURAL JOIN IngressiPerCliente IC;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `op1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `op1`()
BEGIN
	SELECT D.CodFiscale AS Dipendente, D.Nome, D.Cognome, D.Sesso, D.DataNascita, C.Codice, C.Indirizzo, C.Citta
	FROM RegistroDipendenti RD INNER JOIN Dipendente D
				ON RD.Dipendente = D.CodFiscale
				INNER JOIN Centro C ON RD.Centro = C.Codice
	GROUP BY D.CodFiscale, RD.Centro
	HAVING D.DataNascita + INTERVAL 35 YEAR > CURRENT_DATE();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `op2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `op2`()
BEGIN
	SELECT C.CodFiscale, C.Nome, C.Cognome, C.Datanascita
	FROM Accesso A INNER JOIN Cliente C
			ON A.Cliente = C.CodFiscale
	WHERE A.Data BETWEEN (CURRENT_DATE() - INTERVAL 6 DAY) AND CURRENT_DATE()
	GROUP BY C.CodFiscale, C.Nome, C.Cognome, C.DataNascita
    HAVING COUNT(*) >= 4;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `op3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `op3`()
BEGIN

	SELECT A.Nome AS Attrezzatura, R.Nome AS Regolazione, E.Nome AS Esercizio
	FROM Attrezzatura A LEFT OUTER JOIN Regolazione R 
				ON A.Nome = R.Attrezzatura 
				INNER JOIN Esercizio E ON A.Nome = E.Attrezzatura
	GROUP BY A.Nome, E.Nome, R.Nome;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `op4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `op4`()
BEGIN

	SELECT I.Nome, I.Dosaggio, O.Centro
	FROM Integratore I LEFT OUTER JOIN Prodotti P ON (I.Nome = P.Integratore AND I.Dosaggio = P.Dosaggio)
				INNER JOIN Ordine O ON P.Ordine = O.Codice
	GROUP BY I.Nome, I.Dosaggio, O.Centro
	HAVING SUM(P.Quantita) > ALL (	SELECT SUM(P2.Quantita)
															FROM	Prodotti P2 INNER JOIN Ordine O2 ON P2.Ordine = O2.Codice
															WHERE	P2.Integratore = I.Nome AND
																			P2.Dosaggio = I.Dosaggio AND
																			O2.Centro <> O.Centro
															GROUP BY O2.Centro
															);
                                                            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `op5` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `op5`()
BEGIN

	SELECT S.Proponente, S.Scopo
	FROM Account A INNER JOIN Sfida S 
				ON S.Proponente = A.Username
	WHERE	A.Credibilita = 5 AND
					-- S.Data_Lancio BETWEEN (CURRENT_DATE() - INTERVAL 6 DAY) AND CURRENT_DATE() ;
                    S.data_lancio = '2018-04-18';
                    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PerfomanceSportiva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PerfomanceSportiva`( IN _scheda INT)
BEGIN

	SELECT *
    FROM MonitoraggioEsercizio
    WHERE SchedaAssociata = _scheda;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PerformanceSportiva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PerformanceSportiva`( IN _scheda INT)
BEGIN


	-- mostro, per ogni esercizio della scheda di allenamento, se deve essere potenziato (fedeltà media maggiore del 100%) o 
    -- alleggerito (fedeltà media minore del 100%) e anche la percentuale di modifica dello stesso (differenza, in modulo, tra 100 e la fedeltà dell’esercizio).

	SELECT 	SchedaAssociata, Esercizio, GiornoAllenamento, 
					IF(AVG(Fedelta)-100 >=0, 'Potenziamento','Allegerimento') AS Cambiamento, ABS(AVG(Fedelta)-100) AS PercentualeCambiamento
    FROM Performance
    WHERE SchedaAssociata = _scheda
    GROUP BY GiornoAllenamento, SchedaAssociata, Esercizio;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReportPromozioni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReportPromozioni`()
BEGIN


	SELECT	D.Rank, D.Centro, D.Prodotto, D.Dosaggio, D.Scadenza,
					IF (	D.Scadenza BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 2 MONTH,
							'40%',
                            IF (	D.Scadenza BETWEEN CURRENT_DATE + INTERVAL 2 MONTH AND CURRENT_DATE + INTERVAL 4 MONTH,
									'30%',
									'20%'
									)
						) AS ScontoConsigliato
	FROM (
					SELECT	IF (	@centro = M.Centro,
											IF(@datas = M.Scadenza,
												@rank := @rank,
												@rank := @rank + 1 + LEAST(0, @datas := M.Scadenza)),
											@rank := 1 + LEAST(0, @centro := M.Centro) + LEAST(0, @datas := M.Scadenza)
										) AS Rank, 
									M.Centro,
									M.Prodotto,
									M.Dosaggio,
									M.Scadenza
					FROM	Magazzino M,
								(SELECT (@rank := 0)) AS Cod,
								(SELECT (@centro:=0))AS CC
					ORDER BY M.Centro, M.Scadenza
					) AS D
	WHERE D.Scadenza < CURRENT_DATE + INTERVAL 6 MONTH;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RotazioneMagazzino` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RotazioneMagazzino`()
BEGIN


	SELECT	D.Rank, D.Centro, D.Prodotto, D.Dosaggio, D.Scadenza,
					IF (	D.Scadenza BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 2 MONTH,
							'40%',
                            IF (	D.Scadenza BETWEEN CURRENT_DATE + INTERVAL 2 MONTH AND CURRENT_DATE + INTERVAL 4 MONTH,
									'30%',
									'20%'
									)
						) AS ScontoConsigliato
	FROM (
					SELECT	IF (	@centro = M.Centro,
											IF(@datas = M.Scadenza,
												@rank := @rank,
												@rank := @rank + 1 + LEAST(0, @datas := M.Scadenza)),
											@rank := 1 + LEAST(0, @centro := M.Centro) + LEAST(0, @datas := M.Scadenza)
										) AS Rank, 
									M.Centro,
									M.Prodotto,
									M.Dosaggio,
									M.Scadenza
					FROM	Magazzino M,
								(SELECT (@rank := 0)) AS Cod,
								(SELECT (@centro:=0))AS CC
					ORDER BY M.Centro, M.Scadenza
					) AS D
	WHERE D.Scadenza < CURRENT_DATE + INTERVAL 6 MONTH;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `ingressipercliente`
--

/*!50001 DROP VIEW IF EXISTS `ingressipercliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ingressipercliente` AS select `A`.`Cliente` AS `Cliente`,count(0) AS `IngressiSale`,`pi`.`NumeroIngressi` AS `IngressiPiscineInt`,`pe`.`NumeroIngressi` AS `IngressiPiscineEst` from ((`accesso` `A` left join `ingressipiscineint` `PI` on((`A`.`Cliente` = `pi`.`Cliente`))) left join `ingressipiscineest` `PE` on((`A`.`Cliente` = `pe`.`Cliente`))) where ((year(`A`.`Data`) = year(curdate())) and (month(`A`.`Data`) = month(curdate()))) group by `A`.`Cliente` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ingressipiscineest`
--

/*!50001 DROP VIEW IF EXISTS `ingressipiscineest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ingressipiscineest` AS select `accesso`.`Cliente` AS `Cliente`,count(0) AS `NumeroIngressi` from `accesso` where ((year(`accesso`.`Data`) = year(curdate())) and (month(`accesso`.`Data`) = month(curdate()))) group by `accesso`.`Cliente`,`accesso`.`PiscinaEst` having (`accesso`.`PiscinaEst` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ingressipiscineint`
--

/*!50001 DROP VIEW IF EXISTS `ingressipiscineint`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ingressipiscineint` AS select `accesso`.`Cliente` AS `Cliente`,count(0) AS `NumeroIngressi` from `accesso` where ((year(`accesso`.`Data`) = year(curdate())) and (month(`accesso`.`Data`) = month(curdate()))) group by `accesso`.`Cliente`,`accesso`.`PiscinaInt` having (`accesso`.`PiscinaInt` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `partecipanticorso`
--

/*!50001 DROP VIEW IF EXISTS `partecipanticorso`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `partecipanticorso` AS select `C`.`Centro` AS `Centro`,`C`.`Disciplina` AS `Disciplina`,`C`.`Livello` AS `Livello`,`C`.`Inizio` AS `Inizio`,count(distinct `A`.`Cliente`) AS `Partecipanti`,((count(distinct `A`.`Cliente`) * 100) / `C`.`Max_Iscritti`) AS `PercentualePartecipanti` from (`corso` `C` join `attivita` `A` on(((`C`.`Disciplina` = `A`.`Corso`) and (`C`.`Livello` = `A`.`Livello`) and (`C`.`Inizio` = `A`.`DataInizio`)))) group by `C`.`Centro`,`C`.`Disciplina`,`C`.`Livello`,`C`.`Inizio` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `utilizzi`
--

/*!50001 DROP VIEW IF EXISTS `utilizzi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `utilizzi` AS select `M`.`Centro` AS `Centro`,dayofmonth(`M`.`Istante_Inizio`) AS `DAY(M.Istante_Inizio)`,`M`.`Attrezzatura` AS `Attrezzatura`,count(0) AS `NumeroUtilizzi` from `monitoraggioesercizio` `M` where ((month(`M`.`Istante_Inizio`) = month(curdate())) and (year(`M`.`Istante_Inizio`) = year(curdate())) and (`M`.`Attrezzatura` is not null)) group by dayofmonth(`M`.`Istante_Inizio`),`M`.`Centro`,`M`.`Attrezzatura` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `utilizzimese`
--

/*!50001 DROP VIEW IF EXISTS `utilizzimese`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `utilizzimese` AS select `M`.`Centro` AS `Centro`,dayofmonth(`M`.`Istante_Inizio`) AS `DAY(M.Istante_Inizio)`,`M`.`Attrezzatura` AS `Attrezzatura`,count(0) AS `NumeroUtilizzi` from `monitoraggioesercizio` `M` where ((month(`M`.`Istante_Inizio`) = month(curdate())) and (year(`M`.`Istante_Inizio`) = year(curdate())) and (`M`.`Attrezzatura` is not null)) group by dayofmonth(`M`.`Istante_Inizio`),`M`.`Centro`,`M`.`Attrezzatura` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-18 16:58:17
