-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2024 at 03:23 AM
-- Wersja serwera: 10.4.28-MariaDB
-- Wersja PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `przychodznia`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `choroby`
--

CREATE TABLE `choroby` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lekarz`
--

CREATE TABLE `lekarz` (
  `id` int(11) NOT NULL,
  `imie` varchar(30) DEFAULT NULL,
  `nazwisko` varchar(30) DEFAULT NULL,
  `wiek` int(10) DEFAULT NULL,
  `haslo` varchar(30) DEFAULT NULL,
  `mail` varchar(30) DEFAULT NULL,
  `id_recepty` int(11) DEFAULT NULL,
  `id_leki` int(11) DEFAULT NULL,
  `id_wizyt` int(11) DEFAULT NULL,
  `id_pacjent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `leki`
--

CREATE TABLE `leki` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(30) DEFAULT NULL,
  `opis` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pacjent`
--

CREATE TABLE `pacjent` (
  `pesel` int(11) NOT NULL,
  `imie` varchar(30) DEFAULT NULL,
  `nazwisko` varchar(30) DEFAULT NULL,
  `wiek` int(10) DEFAULT NULL,
  `haslo` varchar(30) DEFAULT NULL,
  `mail` varchar(30) DEFAULT NULL,
  `plec` enum('M','K','inne','') NOT NULL,
  `id_recepty` int(11) DEFAULT NULL,
  `id_leki` int(11) DEFAULT NULL,
  `id_wizyt` int(11) DEFAULT NULL,
  `id_choroby` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pacjent`
--

INSERT INTO `pacjent` (`pesel`, `imie`, `nazwisko`, `wiek`, `haslo`, `mail`, `plec`, `id_recepty`, `id_leki`, `id_wizyt`, `id_choroby`) VALUES
(2147483647, 'e', 'e', 55, '$2y$10$ZSArWqdPt/St7WVsAvOi8uI', 'eeeee@eeee.eesese', 'M', NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pacjent_choroba`
--

CREATE TABLE `pacjent_choroba` (
  `id` int(11) NOT NULL,
  `id_pacjenta` int(11) NOT NULL,
  `id_choroby` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pacjent_leki`
--

CREATE TABLE `pacjent_leki` (
  `id` int(11) NOT NULL,
  `id_pacjenta` int(11) NOT NULL,
  `id_leku` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pacjent_recepty`
--

CREATE TABLE `pacjent_recepty` (
  `id` int(11) NOT NULL,
  `id_pacjenta` int(11) NOT NULL,
  `id_recepty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `recepty`
--

CREATE TABLE `recepty` (
  `id` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `id_leku` int(11) DEFAULT NULL,
  `id_pacjenta` int(11) DEFAULT NULL,
  `id_lekarza` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `recepty_leki`
--

CREATE TABLE `recepty_leki` (
  `id` int(11) NOT NULL,
  `id_recepty` int(11) NOT NULL,
  `id_leku` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wizyty`
--

CREATE TABLE `wizyty` (
  `id` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `id_pacjenta` int(11) DEFAULT NULL,
  `id_lekarza` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `choroby`
--
ALTER TABLE `choroby`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `lekarz`
--
ALTER TABLE `lekarz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_wizyt` (`id_wizyt`);

--
-- Indeksy dla tabeli `leki`
--
ALTER TABLE `leki`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `pacjent`
--
ALTER TABLE `pacjent`
  ADD PRIMARY KEY (`pesel`),
  ADD KEY `id_recepty` (`id_recepty`),
  ADD KEY `id_choroby` (`id_choroby`),
  ADD KEY `id_leki` (`id_leki`),
  ADD KEY `id_wizyt` (`id_wizyt`);

--
-- Indeksy dla tabeli `pacjent_choroba`
--
ALTER TABLE `pacjent_choroba`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pacjenta` (`id_pacjenta`),
  ADD KEY `id_choroby` (`id_choroby`);

--
-- Indeksy dla tabeli `pacjent_leki`
--
ALTER TABLE `pacjent_leki`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pacjenta` (`id_pacjenta`),
  ADD KEY `id_leku` (`id_leku`);

--
-- Indeksy dla tabeli `pacjent_recepty`
--
ALTER TABLE `pacjent_recepty`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pacjenta` (`id_pacjenta`),
  ADD KEY `id_recepty` (`id_recepty`);

--
-- Indeksy dla tabeli `recepty`
--
ALTER TABLE `recepty`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `recepty_leki`
--
ALTER TABLE `recepty_leki`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_recepty` (`id_recepty`),
  ADD KEY `id_leku` (`id_leku`);

--
-- Indeksy dla tabeli `wizyty`
--
ALTER TABLE `wizyty`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pacjent_choroba`
--
ALTER TABLE `pacjent_choroba`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pacjent_leki`
--
ALTER TABLE `pacjent_leki`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pacjent_recepty`
--
ALTER TABLE `pacjent_recepty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recepty_leki`
--
ALTER TABLE `recepty_leki`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lekarz`
--
ALTER TABLE `lekarz`
  ADD CONSTRAINT `lekarz_ibfk_1` FOREIGN KEY (`id_wizyt`) REFERENCES `wizyty` (`id`);

--
-- Constraints for table `pacjent`
--
ALTER TABLE `pacjent`
  ADD CONSTRAINT `pacjent_ibfk_1` FOREIGN KEY (`id_wizyt`) REFERENCES `wizyty` (`id`);

--
-- Constraints for table `pacjent_choroba`
--
ALTER TABLE `pacjent_choroba`
  ADD CONSTRAINT `pacjent_choroba_ibfk_1` FOREIGN KEY (`id_pacjenta`) REFERENCES `pacjent` (`pesel`) ON DELETE CASCADE,
  ADD CONSTRAINT `pacjent_choroba_ibfk_2` FOREIGN KEY (`id_choroby`) REFERENCES `choroby` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pacjent_leki`
--
ALTER TABLE `pacjent_leki`
  ADD CONSTRAINT `pacjent_leki_ibfk_1` FOREIGN KEY (`id_pacjenta`) REFERENCES `pacjent` (`pesel`) ON DELETE CASCADE,
  ADD CONSTRAINT `pacjent_leki_ibfk_2` FOREIGN KEY (`id_leku`) REFERENCES `leki` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pacjent_recepty`
--
ALTER TABLE `pacjent_recepty`
  ADD CONSTRAINT `pacjent_recepty_ibfk_1` FOREIGN KEY (`id_pacjenta`) REFERENCES `pacjent` (`pesel`) ON DELETE CASCADE,
  ADD CONSTRAINT `pacjent_recepty_ibfk_2` FOREIGN KEY (`id_recepty`) REFERENCES `recepty` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recepty_leki`
--
ALTER TABLE `recepty_leki`
  ADD CONSTRAINT `recepty_leki_ibfk_1` FOREIGN KEY (`id_recepty`) REFERENCES `recepty` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recepty_leki_ibfk_2` FOREIGN KEY (`id_leku`) REFERENCES `leki` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
