
--
-- Database: `ngo`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--
-- Create the database
CREATE DATABASE ngo;

-- Use the newly created database
USE ngo;

-- Now you can proceed with creating tables



CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `phone` bigint(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `admin_login`
--

CREATE TABLE `admin_login` (
  `login_id` int(11) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(25) NOT NULL,
  `admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `cname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `donor`
--

CREATE TABLE `donor` (
  `donor_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `phone` bigint(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `donor_login`
--

CREATE TABLE `donor_login` (
  `username` varchar(255) NOT NULL,
  `login_id` int(11) NOT NULL,
  `password` varchar(25) NOT NULL,
  `donor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `Item_id` int(11) NOT NULL,
  `item` varchar(255) NOT NULL,
  `donor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ngo_account`
--

CREATE TABLE `ngo_account` (
  `id` int(11) NOT NULL,
  `bank` varchar(255) NOT NULL,
  `ifsc_code` varchar(255) NOT NULL,
  `acount` text NOT NULL,
  `donor_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `donationS` bigint(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `ngo_account`
--
DELIMITER $$
CREATE TRIGGER `transaction` AFTER UPDATE ON `ngo_account` FOR EACH ROW INSERT into transaction(donor_id,tdate,amount) VALUES(new.donor_id,NOW(),(new.donationS-old.donationS))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE `task` (
  `task_id` int(11) NOT NULL,
  `task` varchar(255) NOT NULL,
  `volunteer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) NOT NULL,
  `donor_id` int(11) DEFAULT NULL,
  `tdate` datetime DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `volunteer`
--

CREATE TABLE `volunteer` (
  `volunteer_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `intrests` varchar(255) DEFAULT NULL,
  `dob` date NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `phone` bigint(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `volunteer_login`
--

CREATE TABLE `volunteer_login` (
  `login_id` int(11) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(25) DEFAULT NULL,
  `volunteer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `admin_login`
--
ALTER TABLE `admin_login`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`);

--
-- Indexes for table `donor`
--
ALTER TABLE `donor`
  ADD PRIMARY KEY (`donor_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `donor_login`
--
ALTER TABLE `donor_login`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `donor_id` (`donor_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`Item_id`),
  ADD KEY `donor_id` (`donor_id`);

--
-- Indexes for table `ngo_account`
--
ALTER TABLE `ngo_account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `donor_id` (`donor_id`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`task_id`),
  ADD KEY `volunteer_id` (`volunteer_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `donor_id` (`donor_id`);

--
-- Indexes for table `volunteer`
--
ALTER TABLE `volunteer`
  ADD PRIMARY KEY (`volunteer_id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `volunteer_login`
--
ALTER TABLE `volunteer_login`
  ADD PRIMARY KEY (`login_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `volunteer_id` (`volunteer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_login`
--
ALTER TABLE `admin_login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `donor`
--
ALTER TABLE `donor`
  MODIFY `donor_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `donor_login`
--
ALTER TABLE `donor_login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `Item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ngo_account`
--
ALTER TABLE `ngo_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `task`
--
ALTER TABLE `task`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `volunteer`
--
ALTER TABLE `volunteer`
  MODIFY `volunteer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `volunteer_login`
--
ALTER TABLE `volunteer_login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `admin_login`
--
ALTER TABLE `admin_login`
  ADD CONSTRAINT `admin_login_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `donor`
--
ALTER TABLE `donor`
  ADD CONSTRAINT `donor_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `donor_login`
--
ALTER TABLE `donor_login`
  ADD CONSTRAINT `donor_login_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ngo_account`
--
ALTER TABLE `ngo_account`
  ADD CONSTRAINT `ngo_account_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  ADD CONSTRAINT `ngo_account_ibfk_2` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `task_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteer` (`volunteer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`);

--
-- Constraints for table `volunteer`
--
ALTER TABLE `volunteer`
  ADD CONSTRAINT `volunteer_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `volunteer_login`
--
ALTER TABLE `volunteer_login`
  ADD CONSTRAINT `volunteer_login_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteer` (`volunteer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

-- Insert a city (required for foreign key constraints)
INSERT INTO city (cname) VALUES ('New York');

-- Insert an admin
INSERT INTO admin (name, email, city_id, phone) 
VALUES ('John Admin', 'john@admin.com', 1, 1234567890);

INSERT INTO admin_login (username, password, admin_id)
VALUES ('admin', 'adminpass', 1);

-- Insert a donor
INSERT INTO donor (email, address, city_id, phone, name)
VALUES ('jane@donor.com', '123 Main St', 1, 9876543210, 'Jane Donor');

INSERT INTO donor_login (username, password, donor_id)
VALUES ('janedonor', 'donorpass', 1);

-- Insert a volunteer
INSERT INTO volunteer (name, email, intrests, dob, city_id, phone)
VALUES ('Bob Volunteer', 'bob@volunteer.com', 'Education', '1990-01-01', 1, 5551234567);

INSERT INTO volunteer_login (username, password, volunteer_id)
VALUES ('bobvolunteer', 'volunteerpass', 1);

-- Insert 20 cities from British Columbia, Canada
INSERT INTO city (cname) VALUES
('Vancouver'),
('Victoria'),
('Kelowna'),
('Nanaimo'),
('Kamloops'),
('Prince George'),
('Abbotsford'),
('Chilliwack'),
('Vernon'),
('Penticton'),
('Burnaby'),
('Surrey'),
('Richmond'),
('Langley'),
('Coquitlam'),
('Maple Ridge'),
('New Westminster'),
('North Vancouver'),
('Port Moody'),
('Whistler');

