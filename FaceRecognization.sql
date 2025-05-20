-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 20, 2025 at 04:21 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `FaceRecognization`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `adminId` varchar(50) NOT NULL,
  `accessLevel` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AlignedFace`
--

CREATE TABLE `AlignedFace` (
  `alignedId` varchar(50) NOT NULL,
  `sourceImageId` varchar(50) DEFAULT NULL,
  `data` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `DetectionLog`
--

CREATE TABLE `DetectionLog` (
  `logId` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `resultId` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `DetectionResult`
--

CREATE TABLE `DetectionResult` (
  `resultId` varchar(50) NOT NULL,
  `imageId` varchar(50) DEFAULT NULL,
  `isFake` tinyint(1) DEFAULT NULL,
  `confidence` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `FaceImage`
--

CREATE TABLE `FaceImage` (
  `imageId` varchar(50) NOT NULL,
  `userId` varchar(50) DEFAULT NULL,
  `uploadTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `imageData` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StudentModel`
--

CREATE TABLE `StudentModel` (
  `modelName` varchar(100) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `weights` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TeacherModel`
--

CREATE TABLE `TeacherModel` (
  `modelName` varchar(100) NOT NULL,
  `accuracy` float DEFAULT NULL,
  `trainingSet` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TrainingController`
--

CREATE TABLE `TrainingController` (
  `controllerId` int(11) NOT NULL,
  `adminId` varchar(50) DEFAULT NULL,
  `teacherModelName` varchar(100) DEFAULT NULL,
  `studentModelName` varchar(100) DEFAULT NULL,
  `trainingData` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `userId` varchar(50) NOT NULL,
  `username` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`adminId`);

--
-- Indexes for table `AlignedFace`
--
ALTER TABLE `AlignedFace`
  ADD PRIMARY KEY (`alignedId`),
  ADD KEY `sourceImageId` (`sourceImageId`);

--
-- Indexes for table `DetectionLog`
--
ALTER TABLE `DetectionLog`
  ADD PRIMARY KEY (`logId`),
  ADD KEY `resultId` (`resultId`);

--
-- Indexes for table `DetectionResult`
--
ALTER TABLE `DetectionResult`
  ADD PRIMARY KEY (`resultId`),
  ADD KEY `imageId` (`imageId`);

--
-- Indexes for table `FaceImage`
--
ALTER TABLE `FaceImage`
  ADD PRIMARY KEY (`imageId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `StudentModel`
--
ALTER TABLE `StudentModel`
  ADD PRIMARY KEY (`modelName`);

--
-- Indexes for table `TeacherModel`
--
ALTER TABLE `TeacherModel`
  ADD PRIMARY KEY (`modelName`);

--
-- Indexes for table `TrainingController`
--
ALTER TABLE `TrainingController`
  ADD PRIMARY KEY (`controllerId`),
  ADD KEY `adminId` (`adminId`),
  ADD KEY `teacherModelName` (`teacherModelName`),
  ADD KEY `studentModelName` (`studentModelName`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `TrainingController`
--
ALTER TABLE `TrainingController`
  MODIFY `controllerId` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `AlignedFace`
--
ALTER TABLE `AlignedFace`
  ADD CONSTRAINT `alignedface_ibfk_1` FOREIGN KEY (`sourceImageId`) REFERENCES `FaceImage` (`imageId`);

--
-- Constraints for table `DetectionLog`
--
ALTER TABLE `DetectionLog`
  ADD CONSTRAINT `detectionlog_ibfk_1` FOREIGN KEY (`resultId`) REFERENCES `DetectionResult` (`resultId`);

--
-- Constraints for table `DetectionResult`
--
ALTER TABLE `DetectionResult`
  ADD CONSTRAINT `detectionresult_ibfk_1` FOREIGN KEY (`imageId`) REFERENCES `FaceImage` (`imageId`);

--
-- Constraints for table `FaceImage`
--
ALTER TABLE `FaceImage`
  ADD CONSTRAINT `faceimage_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`);

--
-- Constraints for table `TrainingController`
--
ALTER TABLE `TrainingController`
  ADD CONSTRAINT `trainingcontroller_ibfk_1` FOREIGN KEY (`adminId`) REFERENCES `Admin` (`adminId`),
  ADD CONSTRAINT `trainingcontroller_ibfk_2` FOREIGN KEY (`teacherModelName`) REFERENCES `TeacherModel` (`modelName`),
  ADD CONSTRAINT `trainingcontroller_ibfk_3` FOREIGN KEY (`studentModelName`) REFERENCES `StudentModel` (`modelName`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
