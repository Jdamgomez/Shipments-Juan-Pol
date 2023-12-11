-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-12-2023 a las 22:19:41
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestor_missatgeria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `assignacions`
--

CREATE TABLE `assignacions` (
  `Missatger` varchar(9) NOT NULL,
  `Enviament` int(11) NOT NULL,
  `Data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `assignacions`
--

INSERT INTO `assignacions` (`Missatger`, `Enviament`, `Data`) VALUES
('87452367T', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrec`
--

CREATE TABLE `carrec` (
  `CodiCarrec` int(11) NOT NULL,
  `Carrec` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrec`
--

INSERT INTO `carrec` (`CodiCarrec`, `Carrec`) VALUES
(1, 'Missatger'),
(2, 'Recepcionista'),
(3, 'Responsable de logística');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creacions`
--

CREATE TABLE `creacions` (
  `Creador` varchar(9) NOT NULL,
  `Enviament` int(11) NOT NULL,
  `Data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `creacions`
--

INSERT INTO `creacions` (`Creador`, `Enviament`, `Data`) VALUES
('12437905J', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enviament`
--

CREATE TABLE `enviament` (
  `Numero Referencia` int(11) NOT NULL,
  `Categoria` enum('Particular','Corporatiu','Gubernamental') NOT NULL,
  `Direccio Remitent` varchar(100) NOT NULL,
  `Direccio Desti` varchar(100) NOT NULL,
  `Expres` enum('Si','No') NOT NULL,
  `Pes` float NOT NULL,
  `Fondaria` float NOT NULL,
  `Alçada` float NOT NULL,
  `Amplada` float NOT NULL,
  `Fragil` enum('Si','No') NOT NULL,
  `Estat` enum('Pendent d''assignar','En procés','Lliurat') NOT NULL DEFAULT 'Pendent d''assignar'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `enviament`
--

INSERT INTO `enviament` (`Numero Referencia`, `Categoria`, `Direccio Remitent`, `Direccio Desti`, `Expres`, `Pes`, `Fondaria`, `Alçada`, `Amplada`, `Fragil`, `Estat`) VALUES
(1, 'Particular', 'C/Mossen Antoni Solanas 2', 'C/Mallorca 8', 'Si', 23, 12, 67, 89, 'Si', 'Pendent d\'assignar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuari`
--

CREATE TABLE `usuari` (
  `DNI` varchar(9) NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `Cognoms` varchar(50) NOT NULL,
  `Telefon` int(11) NOT NULL,
  `Data Naixement` date NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Contrasenya` varchar(200) NOT NULL,
  `Carrec` int(11) NOT NULL,
  `Email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuari`
--

INSERT INTO `usuari` (`DNI`, `Nom`, `Cognoms`, `Telefon`, `Data Naixement`, `Username`, `Contrasenya`, `Carrec`, `Email`) VALUES
('10691256E', 'Julieta', 'Garcia Fernandez', 955788461, '1990-12-01', 'Julieta_recepcionist', 'recepcionist', 2, 'julieta@gmail.com'),
('12437905J', 'Francesc', 'Perez Martinez', 566433908, '1986-12-06', 'Francesc_admin', 'admin', 3, 'francesc@gmail.com'),
('87452367T', 'Mariano', 'Rodriguez Ramirez', 688955421, '1968-12-11', 'Mariano_messager', 'messager', 1, 'mariano@gmail.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `assignacions`
--
ALTER TABLE `assignacions`
  ADD PRIMARY KEY (`Missatger`,`Enviament`),
  ADD KEY `fk_enviament_assignacions` (`Enviament`) USING BTREE;

--
-- Indices de la tabla `carrec`
--
ALTER TABLE `carrec`
  ADD PRIMARY KEY (`CodiCarrec`);

--
-- Indices de la tabla `creacions`
--
ALTER TABLE `creacions`
  ADD PRIMARY KEY (`Creador`,`Enviament`),
  ADD KEY `fk_enviaments_creacions` (`Enviament`) USING BTREE;

--
-- Indices de la tabla `enviament`
--
ALTER TABLE `enviament`
  ADD PRIMARY KEY (`Numero Referencia`);

--
-- Indices de la tabla `usuari`
--
ALTER TABLE `usuari`
  ADD PRIMARY KEY (`DNI`),
  ADD UNIQUE KEY `UniqueUsername` (`Username`),
  ADD UNIQUE KEY `UniqueMail` (`Email`),
  ADD KEY `fk_carrec` (`Carrec`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `assignacions`
--
ALTER TABLE `assignacions`
  ADD CONSTRAINT `fk_enviament` FOREIGN KEY (`Enviament`) REFERENCES `enviament` (`Numero Referencia`),
  ADD CONSTRAINT `fk_missatger` FOREIGN KEY (`Missatger`) REFERENCES `usuari` (`DNI`);

--
-- Filtros para la tabla `creacions`
--
ALTER TABLE `creacions`
  ADD CONSTRAINT `fk_creador` FOREIGN KEY (`Creador`) REFERENCES `usuari` (`DNI`),
  ADD CONSTRAINT `fk_enviaments` FOREIGN KEY (`Enviament`) REFERENCES `enviament` (`Numero Referencia`);

--
-- Filtros para la tabla `usuari`
--
ALTER TABLE `usuari`
  ADD CONSTRAINT `fk_carrec` FOREIGN KEY (`Carrec`) REFERENCES `carrec` (`CodiCarrec`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE USER 'missatgeria_manager'@'%' IDENTIFIED BY 'admin';

GRANT USAGE ON *.* TO `missatgeria_manager`@`%`;
GRANT ALL PRIVILEGES ON `gestor_missatgeria`.* TO `missatgeria_manager`@`%` WITH GRANT OPTION;