-- I created this file for your convenience. I found the provided Excel sample data have a lot of specific requirement regarding the creation of the tables.
-- I modified some of them so they fit our tables
-- Anton

USE MovinOn_TeamNo;

-- Positions

INSERT INTO positions (PositionID, Title)
VALUES
(1, 'Manager'),
(2, 'Assistant Manager'),
(3, 'Clerk'),
(4, 'Sales Representative'),
(5, 'Warehouse Worker'),
(6, 'Mover'),
(7, 'Dispatcher');

-- Warehouses

INSERT INTO warehouses (WarehouseID, Address, City, State, ZIP, Phone, ClimateControl, SecurityGate)
VALUES
('WA-1', '100 Main Street', 'Seattle', 'WA', '98101', '206-555-1111', 1, 1),
('OR-1', '200 Oak Avenue', 'Portland', 'OR', '97204', '503-555-2222', 1, 1),
('WY-1', '300 Pine Road', 'Jackson Hole', 'WY', '83001', '307-555-3333', 0, 1);

-- Customers

INSERT INTO customers (CustID, CompanyName, ContactFirst, ContactLast, Address, City, State, ZIP, Phone, Balance)
VALUES
(1, 'Piazza Real Estate', 'Terry', 'Ramadani', '1897 Gary Ave', 'Spokane', 'WA', '99204', '(509) 324-8213', 0),
(2, 'McDonald Construction', 'Terese', 'Spredemann', '5976 14th Ave NW', 'Portland', 'OR', '97233', '(503) 798-5646', 0),
(3, 'Douglas Law Firm', 'Susan', 'Suarez', '375 56th St', 'Spokane', 'WA', '99245', '(509) 857-2465', 0),
(4, NULL, 'Felicia', 'Pursifull', '61 Virginian Ln', 'Jackson Hole', 'WY', '83001', '(307) 224-9633', 0),
(5, NULL, 'Rebecca', 'Leighty', '1803 Nora Ave W', 'Spokane', 'WA', '99202', '(509) 546-3133', 0),
(6, 'Woodman Furniture', 'Jeff', 'Booker', '156 Fourth St SW', 'Seattle', 'WA', '98145', '(206) 354-6785', 0),
(7, NULL, 'Zarra', 'Thomas', '9390 Marilu Rd', 'Jackson Hole', 'WY', '83001', '(307) 555-6547', 0),
(8, NULL, 'Deidre', 'Haferson', '201 North River Dr W', 'Spokane', 'WA', '99201', '(509) 648-3132', 0),
(9, 'Limited Partners', 'Yeon', 'Wung', '14588 25th St NW', 'Spokane', 'WA', '99203', '(509) 487-3574', 0),
(10, 'Brody & Karnall, PC', 'Darla', 'Barbar', '6755 Forestview Dr W', 'Portland', 'OR', '97215', '(503) 546-5465', 0),
(11, NULL, 'Brandy', 'Jonaitis', '955 Simon Ln', 'Jackson Hole', 'WY', '83003', '(307) 541-2216', 0),
(12, 'Partners in Health', 'Josephine', 'Miazga', '6133 Highland Park', 'Spokane', 'WA', '99203', '(509) 324-6542', 0),
(13, 'County Booksellers', 'Roselina', 'Smith', '655 Ponderosa Dr', 'Jackson Hole', 'WY', '83005', '(307) 685-3211', 0),
(14, NULL, 'Mary', 'Pyo', '8534 Klondike Lane NW', 'Seattle', 'WA', '98152', '(206) 345-7122', 0),
(15, 'Jenkins Publishing Company', 'Teresa', 'Scott', '604 Sound Ave W', 'Spokane', 'WA', '99209', '(509) 374-2154', 0),
(16, NULL, 'Walter', 'Garth', '78 Beloit Ave', 'Spokane', 'WA', '99210', '(509) 324-9213', 0),
(17, 'Physical Therapy Group', 'Martha', 'Fordahl', '11040 Dayton Pike', 'Jackson Hole', 'WY', '83002', '(307) 551-2341', 0),
(18, 'County Hospital', 'Angela', 'Areba', '6308 24th Ave NW', 'Seattle', 'WA', '98001', '(206) 574-2111', 0),
(19, NULL, 'Melissa', 'Doezal', '15607 Timberwood Ct N', 'Spokane', 'WA', '99205', '(509) 232-4682', 0),
(20, 'Ruby Booksellers', 'Nora', 'Rittmeyer', '3122 Mountain View Rd', 'Seattle', 'WA', '98102', '(206) 334-6564', 0),
(21, NULL, 'Paul', 'Rabideaux', '10024 Colfax Rd N', 'Spokane', 'WA', '99203', '(509) 432-3546', 0),
(22, 'Hannah''s Antiques', 'Marcia', 'Harrison', '14228 S US Highway 191', 'Jackson Hole', 'WY', '83001', '(307) 541-2231', 0),
(23, 'Buck''s Bikes', 'Melinda', 'Harper', '5259 Mithun Pl NE', 'Seattle', 'WA', '98012', '(206) 467-8885', 0),
(24, NULL, 'Robert', 'Soorbine', '2467 Fifth St', 'Spokane', 'WA', '99204', '(509) 352-5635', 0),
(25, NULL, 'Andrea', 'Franklin', '8978 Fullerton Rd', 'Jackson Hole', 'WY', '83001', '(307) 841-2300', 0),
(26, NULL, 'Judy', 'Boehme', '5690 Riceville Rd', 'Portland', 'OR', '97201', '(503) 465-7955', 0),
(27, 'Houseman Realtors', 'Angela', 'Sokovich', '638 25th Ave E', 'Spokane', 'WA', '99216', '(509) 642-1115', 0),
(28, NULL, 'Scott', 'Cooperstein', '523 Mansfield Ave W', 'Spokane', 'WA', '99262', '(509) 365-4683', 0),
(29, NULL, 'Laura', 'Young', '2925 N Aspen Wood Ln', 'Jackson Hole', 'WY', '83004', '(307) 542-1346', 0),
(30, NULL, 'Dora', 'Castillo', '6308 24th Ave NW', 'Seattle', 'WA', '98016', '(206) 345-1145', 0),
(31, 'Johnson Fleet Service', 'Sherry', 'Carter', '806 Powderhorn Ln', 'Jackson Hole', 'WY', '83005', '(307) 547-1321', 0),
(32, 'Boat Storage Systems', 'Oswald', 'Coates', '620 Olympic Pl W', 'Seattle', 'WA', '98048', '(206) 452-1352', 0),
(33, NULL, 'Jerry', 'Murillo', '4789 E. G Street', 'Jackson Hole', 'WY', '83002', '(307) 249-5555', 0),
(34, NULL, 'Garth', 'Ferraro', '5314 Sunset Hwy W', 'Spokane', 'WA', '99201', '(509) 345-1247', 0),
(35, 'Vanway Accounting', 'Charlene', 'Leong', '2172 Corner Creek Ln', 'Jackson Hole', 'WY', '83001', '(307) 274-9233', 0),
(36, NULL, 'Rinn', 'Rucker', '7420 Rambling Rd', 'Portland', 'OR', '97212', '(503) 541-3338', 0),
(37, NULL, 'Irene', 'Stakline', '7200 Riverbrook Lane', 'Spokane', 'WA', '99215', '(509) 654-1246', 0),
(38, 'Squeaky Clean Carwash', 'Rosa', 'Fernando', '923 Mountain Pass', 'Jackson Hole', 'WY', '83001', '(307) 951-1124', 0);

-- Vehicles

INSERT INTO vehicles (VehicleID, LicensePlateNum, Axle, Color)
VALUES
('TRK-001', 'JFG899', 4, 'Green'),
('TRK-002', 'KKL900', 4, 'Blue'),
('TRK-003', 'YTT899', 1, 'Blue'),
('TRK-004', 'RYH900', 1, 'Red'),
('TRK-005', 'MLK441', 4, 'Blue'),
('TRK-006', 'LNS550', 2, 'Red'),
('TRK-007', 'KRN001', 2, 'Blue'),
('TRK-008', 'KVV879', 4, 'Red'),
('TRK-009', 'XXV898', 4, 'Green'),
('TRK-010', 'LLO689', 4, 'Blue'),
('TRK-011', 'LMN899', 4, 'White'),
('VAN-001', 'KVJ555', 2, 'White'),
('VAN-002', 'UJK444', 2, 'White'),
('VAN-003', 'JKL133', 2, 'White'),
('VAN-004', 'VNN890', 2, 'White'),
('VAN-005', 'JKL898', 2, 'White'),
('VAN-009', 'RLL909', 2, 'White');

-- Drivers

INSERT INTO drivers (DriverID, DriverFirst, DriverLast, SSN, DOB, StartDate, EndDate, Address, City, State, ZIP, Phone, Cell, MileageRate, Review, DrivingRecord)
VALUES
(1, 'Jerry', 'Lo', '124002465', '1986-09-12', '2014-01-22', '2014-06-15', '600 East 22nd Street', 'Jackson Hole', 'WY', '83001', '3076435512', '3075745444', 0.35, NULL, 'A'),
(2, 'John', 'Samson', '725461340', '1984-12-16', '2015-11-22', NULL, '9708 Manchaca Road', 'Spokane', 'WA', '99213', '5095422212', '5095741115', 0.3, '2015-05-20', 'A'),
(3, 'Virginia', 'Spichalla', '728224333', '1986-10-24', '2014-10-21', NULL, '2120 53rd Street SW', 'Seattle', 'WA', '98102', '2067415132', '2064571544', 0.35, '2014-08-16', 'B'),
(4, 'Jonathan', 'Nabinger', '901543211', '1995-02-14', '2013-09-12', NULL, '11215 87th Avenue NE', 'Seattle', 'WA', '98103', '2065431542', '2064852461', 0.35, '2013-01-05', 'C'),
(7, 'Byron', 'Snowden', '321560000', '1993-08-14', '2008-06-14', NULL, '300 Promontory Drive', 'Portland', 'OR', '97204', '5034514541', '5034875544', 0.35, '2008-06-15', 'C'),
(8, 'Cindy', 'Solquim', '915424687', '1985-10-06', '2006-03-14', NULL, '755 Cherry Valley Drive', 'Jackson Hole', 'WY', '83002', '3075712241', '3078974541', 0.4, '2007-10-01', 'A'),
(9, 'Manuel', 'Able', '987352000', '1995-11-24', '2011-04-05', NULL, '3010 W Anderson Lane', 'Portland', 'OR', '97201', '5032121574', '5034571544', 0.4, '2012-11-01', 'B'),
(10, 'Jackie', 'Condon', '953102431', '1996-07-30', '2009-10-15', NULL, '620 East Empire Street', 'Spokane', 'WA', '99216', '5097415741', '5097842456', 0.45, '2009-02-15', 'A'),
(11, 'Ned', 'Vandre', '908754641', '1997-04-05', '2016-09-10', '2017-03-22', '10611 Freidrich Lane SW', 'Seattle', 'WA', '98116', '2062487468', '2068745441', 0.45, '2016-10-29', 'A'),
(12, 'Nathan', 'Lindsey', '983567899', '1996-12-31', '2016-02-24', NULL, '861 Loop 337 E', 'Portland', 'OR', '97207', '5034571541', '5037877771', 0.5, '2016-03-01', 'A'),
(13, 'John', 'O''Reilly', '724135755', '1984-07-04', '2015-01-29', NULL, '2520 Longview Drive E', 'Seattle', 'WA', '98127', '2065741241', '2063127489', 0.5, '2015-03-15', 'A'),
(14, 'Charles', 'Mahata', '000267544', '1991-03-01', '2012-01-29', NULL, '101 Shady Lane', 'Jackson Hole', 'WY', '83004', '3079856455', '3078973544', 0.5, '2012-11-15', 'A'),
(15, 'Victor', 'Strong', '721246721', '1992-04-24', '2014-08-14', NULL, '5421 Bee Cave Road', 'Spokane', 'WA', '99216', '5096451354', '5095473123', 0.4, '2014-10-15', 'A'),
(16, 'Robert', 'Avalon', '704246572', '1984-04-10', '2014-10-29', NULL, '35741 Steck Avenue #498', 'Seattle', 'WA', '98108', '2064783457', '2064354132', 0.35, '2014-10-15', 'B'),
(17, 'Abbie', 'Reingold', '724354544', '1987-06-21', '2013-11-24', '2013-02-02', '623 South Hampton Way', 'Portland', 'OR', '97204', '5035497241', '5063789855', 0.3, '2013-12-10', 'D'),
(18, 'Luke', 'Smith', '701234900', '1987-09-28', '2010-06-14', NULL, '1322 Buckeye Trail NW', 'Portland', 'OR', '97207', '5035716575', '5039785432', 0.4, '2010-06-15', 'C'),
(19, 'Alberto', 'Nicholson', '703264978', '1989-05-30', '2014-12-23', NULL, '707 W 21st Street #68', 'Portland', 'OR', '97215', '5035853589', '5037897124', 0.35, '2014-01-15', 'A'),
(20, 'Roy', 'Nesson', '705364444', '1989-12-12', '2014-02-03', NULL, '105 Gattis School Road', 'Seattle', 'WA', '99217', '2064873245', '2067741445', 0.45, '2014-09-10', 'B'),
(21, 'Turner', 'Donaldson', '812450000', '1988-10-14', '2015-06-30', NULL, '277 Woodway Drive', 'Jackson Hole', 'WY', '83010', '3075713575', '3078645732', 0.4, '2015-09-01', 'B'),
(22, 'Dawson', 'Minton', '709531277', '1987-06-20', '2015-07-15', NULL, '780 North Loop #298', 'Seattle', 'WA', '99217', '2068745765', '2067843541', 0.35, '2015-01-04', 'A');

-- Employees

INSERT INTO employees (EmpID, EmpFirst, EmpLast, WarehouseID, SSN, DOB, StartDate, EndDate, Address, City, State, ZIP, PositionID, Memo, Phone, Cell, Salary, HourlyRate, Review)
VALUES
(1, 'David', 'Bowers', 'WA-1', '154003785', '1985-09-12', '1998-01-22', NULL, '10124 Metropolitan Drive', 'Seattle', 'WA', '98117', 1, NULL, '2062465132', '2065754321', 72000.00, NULL, NULL),
(2, 'Robert', 'Iko', 'WA-1', '705246513', '1994-12-16', '2006-12-15', NULL, '698 Round Mountain', 'Seattle', 'WA', '98124', 7, NULL, '2065472315', '2064875312', 59500.00, NULL, '2007-06-15'),
(3, 'Virginia', 'Sanchez', 'WA-1', '724568132', '1988-10-24', '2004-06-10', NULL, '201 River Road', 'Spokane', 'WA', '99215', 2, 'Emergency contact for alarm company', '5093451687', '5096348732', 48500.00, NULL, '2007-12-15'),
(4, 'Eric', 'Behrens', 'WY-1', '956346120', '1995-02-14', '2005-09-12', '2006-02-15', '21 Adrian Way', 'Jackson Hole', 'WY', '83005', 3, NULL, '3075461272', '3075763154', NULL, 12.50, NULL),
(7, 'Brian', 'Castillo', 'OR-1', '923546124', '1990-08-14', '2001-06-14', NULL, '52 Denton Drive #49', 'Portland', 'OR', '97205', 3, NULL, '5035742742', '5035647154', NULL, 12.75, '2008-06-14'),
(8, 'Cynthia', 'Cox', 'OR-1', '854230000', '1985-10-06', '2006-12-30', NULL, '1515 Patterson Road', 'Portland', 'OR', '97210', 2, NULL, '5032412423', '5035496113', 50000.00, NULL, '2007-06-30'),
(9, 'John', 'Maestas', 'WA-1', '487002468', '1995-11-24', '2001-11-15', NULL, '5506 Beach Street West', 'Spokane', 'WA', '99216', 4, 'Speaks fluent Spanish', '5096741543', '5093782312', 42500.00, NULL, '2007-11-01'),
(10, 'Mark', 'Cumberland', 'OR-1', '705435126', '1996-07-30', '2002-10-01', '2006-03-15', '16542 Angus Road #280', 'Portland', 'OR', '97206', 6, NULL, '5032486453', '5032786424', NULL, 12.25, NULL),
(11, 'Darnell', 'Colmenero', 'WA-1', '723549785', '1997-04-05', '2002-09-02', NULL, '6000 Balcones Drive', 'Seattle', 'WA', '98113', 3, NULL, '2063475354', '2063547215', NULL, 15.00, '2008-09-15'),
(12, 'James', 'Lu', 'WY-1', '709564321', '1999-12-31', '2005-02-24', NULL, '5003 Mallard Avenue #587', 'Jackson Hole', 'WY', '83001', 2, 'Speaks fluent Chinese', '3076784513', '3072468732', 48500.00, NULL, '2007-02-24'),
(13, 'Barry', 'Orosco', 'WA-1', '723246875', '1989-07-04', '2006-03-21', '2006-05-15', '2001 Kenosha Pass', 'Spokane', 'WA', '99216', 5, NULL, '5093451357', '5093575166', NULL, 9.75, NULL),
(14, 'Richard', 'Hargadon', 'WA-1', '984651372', '1991-03-01', '2006-07-15', NULL, '901 Great Oaks Cove', 'Seattle', 'WA', '98154', 6, NULL, '2063547987', '2063541287', NULL, 10.50, '2007-08-15'),
(15, 'John', 'Nader', 'WY-1', '905346755', '1992-04-24', '2001-08-01', NULL, '321 Sturgis', 'Jackson Hole', 'WY', '83001', 3, NULL, '3075467135', '3072468731', NULL, 11.25, '2008-08-01'),
(16, 'George', 'Medrano', 'WA-1', '546570000', '1994-04-10', '2006-10-15', NULL, '3987 NW 87th Street #8', 'Seattle', 'WA', '98124', 6, NULL, '2063412024', '2063241200', NULL, 11.25, '2008-10-15'),
(17, 'Rachel', 'Goodman', 'OR-1', '978451342', '1997-06-21', '2004-11-03', NULL, '9876 Parker Street', 'Portland', 'OR', '97204', 5, 'On maternity leave through 12/2008', '5032415756', '5032175613', NULL, 12.75, '2008-01-15'),
(18, 'Shayla', 'Anderson', 'WA-1', '926543210', '1988-09-28', '2003-09-24', NULL, '4321 Barton Cliff Drive', 'Seattle', 'WA', '98124', 6, NULL, '2063214571', '2063218756', NULL, 12.50, '2008-09-15'),
(19, 'Alfonso', 'Ozmun', 'WA-1', '946532100', '1990-05-30', '2005-06-15', NULL, '510 Immanuel Avenue', 'Seattle', 'WA', '98126', 5, NULL, '2063124024', '2062497513', NULL, 12.00, '2008-02-28'),
(20, 'Sophia', 'Nunis', 'WA-1', '987451372', '1989-12-12', '2006-10-20', NULL, '5471 Wyoming Springs Way', 'Spokane', 'WA', '99214', 6, NULL, '5093478992', '5098973246', NULL, 12.00, '2008-01-15'),
(21, 'Dora', 'Nettles', 'WA-1', '723246512', '1988-10-14', '2002-10-21', NULL, '24 Frontier Trail NE', 'Seattle', 'WA', '98123', 3, NULL, '2067546512', '2065795462', NULL, 14.75, '2008-02-15'),
(22, 'Kristina', 'Romano', 'WA-1', '704513547', '1997-06-20', '2001-05-20', NULL, '8 Anderson Loop', 'Seattle', 'WA', '98113', 4, NULL, '2062449876', '2062748648', 45000.00, NULL, '2008-05-01'),
(23, 'Doug', 'Hearne', 'OR-1', '722154321', '1982-05-21', '2004-01-15', NULL, '11 Lost Pine Trail', 'Portland', 'OR', '97204', 6, NULL, '5032462465', '5037654354', NULL, 12.75, '2008-01-15'),
(24, 'Tom', 'Murphy', 'OR-1', '701543216', '1977-06-05', '2004-02-16', NULL, '4007 James White Avenue', 'Portland', 'OR', '97214', 6, NULL, '5032471355', '5037543257', NULL, 13.00, '2008-03-15'),
(25, 'Felicia', 'Castro', 'OR-1', '724216452', '1980-09-14', '2005-03-16', NULL, '611 Montclaire Street', 'Portland', 'OR', '97226', 6, NULL, '5037543871', '5034757135', NULL, 12.50, '2008-03-15'),
(26, 'Gene', 'Chiles', 'OR-1', '954321642', '1982-07-05', '2004-03-01', NULL, '2506 Ferguson Lane #411', 'Portland', 'OR', '97215', 6, NULL, '5032798246', '5032467835', NULL, 12.50, '2008-03-01'),
(27, 'Kirby', 'Meyer', 'OR-1', '984651357', '1980-11-12', '2005-05-31', NULL, '110 Ponderosa', 'Portland', 'OR', '97209', 4, NULL, '5032716579', '5032795132', 42500.00, NULL, '2007-12-15'),
(28, 'Jim', 'Bostic', 'OR-1', '454006543', '1979-12-12', '2005-07-06', NULL, '1201 Chestnut Avenue #2', 'Portland', 'OR', '97211', 6, NULL, '5032715496', '5032164573', NULL, 11.75, '2008-07-01'),
(29, 'Leland', 'McKeeman', 'WY-1', '963124672', '1978-11-01', '2004-09-25', NULL, '79513 Airport Blvd.', 'Jackson Hole', 'WY', '83005', 3, NULL, '3072462135', '3072462465', NULL, 14.50, '2008-09-01'),
(30, 'Wade', 'Ragland', 'WY-1', '706324675', '1980-03-01', '2004-09-25', NULL, '9714 Circle Drive', 'Jackson Hole', 'WY', '83005', 4, NULL, '3072749264', '3072243241', 43500.00, NULL, '2008-09-01'),
(31, 'Cynthia', 'Zucker', 'WY-1', '705315790', '1967-08-22', '2001-06-22', NULL, '304 Ridgewood Drive #1', 'Jackson Hole', 'WY', '83002', 6, NULL, '3075556432', '3072465796', NULL, 11.50, '2007-06-01'),
(32, 'Lisa', 'Virr', 'WY-1', '421001579', '1980-11-28', '2006-11-16', NULL, '10086 Wells Parkway', 'Jackson Hole', 'WY', '83010', 5, NULL, '3072746313', '3072154324', NULL, 11.50, '2007-11-15'),
(33, 'Shane', 'Pichardo', 'WY-1', '987465137', '1983-12-14', '2006-01-29', NULL, '8301 Alvin High Blvd.', 'Jackson Hole', 'WY', '83011', 6, NULL, '3075553216', '3072468763', NULL, 11.50, '2007-01-15'),
(34, 'Richard', 'Pena', 'WY-1', '716543272', '1981-02-24', '2006-04-26', NULL, '5713 Mystic Street', 'Jackson Hole', 'WY', '83012', 6, NULL, '3072456876', '3072132762', NULL, 11.75, '2007-11-25'),
(35, 'Jason', 'Collins', 'WY-1', '722165711', '1980-10-14', '2005-08-01', NULL, '10275 Sam Bass Road', 'Jackson Hole', 'WY', '83012', 6, NULL, '3072623546', '3072664533', NULL, 11.85, '2007-08-01');

-- Job Orders

INSERT INTO joborders (JobID, CustID, MoveDate, FromAddress, FromCity, FromState, ToAddress, ToCity, ToState, DistanceEst, WeightEst, Packing, Heavy, Storage)
VALUES
(2, 1, '2016-09-05', '1789 Eighth Avenue', 'Spokane', 'WA', '7899 Grandview Apt #5', 'Pullman', 'WA', 60, 1250, 1, 1, 0),
(3, 3, '2016-09-15', '4433 Grindstaff St', 'Kennewick', 'WA', '#3 Madison Ct', 'Richmond', 'WA', 10, 2000, 0, 0, 0),
(4, 3, '2016-09-20', '9000 Greely Pkwy', 'Seattle', 'WA', '6788 Fifth Avenue', 'Tacoma', 'WA', 15, 1200, 1, 1, 0),
(5, 9, '2016-09-30', '143 Faulkner Lane', 'Bellingham', 'WA', '6788 Carson Road', 'Tacoma', 'WA', 120, 5500, 1, 1, 0),
(6, 16, '2016-10-01', '7990 Bellington Road', 'Mount Vernon', 'WA', '78661 Davidson Drive', 'Marysville', 'WA', 35, 5500, 1, 1, 0),
(7, 13, '2016-10-05', '9000 Wayside Drive', 'Casper', 'WY', '8989 Franklin Street', 'Cody', 'WY', 214, 5000, 1, 1, 0),
(8, 7, '2016-10-05', '9001 Harvard Way', 'Cheyenne', 'WY', '78 Fortner Court', 'Sheridan', 'WY', 329, 2500, 1, 1, 0),
(9, 4, '2016-10-05', '89098 Jackson Street', 'Jackson', 'WY', '2009 Kinsington Place', 'Cody', 'WY', 178, 5500, 1, 1, 0),
(10, 4, '2016-10-20', '7890 Grapevine Court', 'Riverton', 'WY', '666 Grand Pead Drive', 'Casper', 'WY', 120, 2500, 0, 1, 0),
(11, 10, '2016-10-15', '9001 Shady Lane', 'Bend', 'OR', '9000 Smith Avenue', 'Eugene', 'OR', 115, 5500, 1, 1, 0),
(12, 10, '2016-10-18', '87998 McDonald Road', 'Eugene', 'OR', '78987 Garrison Way', 'Salem', 'OR', 65, 2000, 0, 0, 0),
(13, 26, '2016-10-15', '7899 Tindell St', 'Medford', 'OR', '3422 Victory Circle', 'John Day', 'OR', 330, 6500, 1, 1, 0),
(14, 36, '2016-10-08', '8900 Washington Street', 'Astoria', 'OR', '6755 Garrison Park Road', 'Pendleton', 'OR', 300, 7000, 1, 1, 0),
(15, 18, '2016-10-16', '7890 Eighth Ave', 'Tacoma', 'WA', '89 Fifth Avenue', 'Wenatchee', 'WA', 165, 5500, 1, 1, 0),
(16, 27, '2016-10-18', '#5 Mountain View Way', 'Spokane', 'WA', '4509 El Cajon Blvd', 'Yakima', 'WA', 200, 7200, 1, 1, 1),
(17, 32, '2016-10-15', '2344 Grandview St', 'Portland', 'OR', '309 Fifth Street S', 'Bremeton', 'WA', 175, 5500, 1, 1, 1),
(18, 17, '2016-10-14', '1290 Franklin Street', 'Rock Springs', 'WY', '3409 Greelee St', 'Cheyenne', 'WY', 260, 6000, 1, 1, 1),
(19, 17, '2016-10-22', '# 3 Madison Ct', 'Rock Springs', 'WY', '2456 Faulkner Road', 'Cheyenne', 'WY', 260, 5000, 1, 1, 0),
(20, 38, '2016-10-23', '9710 Homewood Circle', 'Jackson', 'WY', '1209 Grandview Court', 'Cody', 'WY', 180, 4000, 1, 0, 1),
(21, 31, '2016-10-24', '5789 Tinsdale Rd', 'Cody', 'WY', '2509 22nd Street', 'Riverton', 'WY', 140, 5500, 1, 1, 1),
(22, 13, '2016-10-30', '5690 McDonald Pkwy', 'Jackson', 'WY', '1098 Cheryl Lane', 'Rock Springs', 'WY', 180, 4500, 1, 0, 1),
(23, 22, '2016-11-05', '1200 Greenlee Way', 'Cheyenne', 'WY', '39098 Scotland Court', 'Jackson', 'WY', 436, 2000, 1, 1, 1),
(24, 22, '2016-11-15', '12900 Misty Lane', 'Cody', 'WY', '#3 Timbercreek Lane', 'Jackson', 'WY', 178, 2500, 0, 0, 0),
(25, 2, '2016-11-15', '1200 Haven Street', 'Salem', 'OR', '10928 Garrison Rd', 'Medford', 'OR', 225, 5000, 1, 1, 0),
(26, 2, '2016-11-15', '2099 Nature Walk Rd', 'Salem', 'OR', '8378 Eighth Ave S', 'Medford', 'OR', 225, 2000, 1, 0, 0),
(27, 2, '2016-11-15', '1200 College Street', 'Salem', 'OR', '7898 Gergory Court', 'Medford', 'OR', 225, 3500, 1, 0, 0),
(28, 10, '2016-11-18', '1098 Keystone St', 'Bend', 'OR', '8798 Hannah Way', 'Eugene', 'OR', 115, 3000, 1, 1, 0),
(29, 36, '2016-11-20', '20005 Perking Rd', 'Pendleton', 'OR', '8777 Austin Lea Road', 'Bend', 'OR', 243, 2500, 1, 0, 0);

-- Job Details

INSERT INTO jobdetails (JobID, VehicleID, DriverID, MileageActual, WeightActual)
VALUES
(2, 'TRK-003', 4, 68, 1300),
(3, 'TRK-002', 3, 18, 2260),
(4, 'TRK-002', 3, 115, 1175),
(5, 'TRK-003', 4, 129, 5675),
(6, 'TRK-003', 4, 56, 5575),
(7, 'TRK-004', 1, 225, 5286),
(8, 'TRK-006', 1, 356, 3275),
(9, 'TRK-007', 1, 220, 6000),
(10, 'TRK-005', 2, 138, 4275),
(11, 'TRK-005', 2, 115, 4257);

-- Storage Units
INSERT INTO storageunits (UnitID, WarehouseID, UnitSize, Rent)
VALUES
(1, 'OR-1', '8 x 8', 25),
(1, 'WA-1', '12 x 12', 35),
(1, 'WY-1', '12 x 12', 45),
(2, 'OR-1', '8 x 12', 30),
(2, 'WA-1', '12 x 12', 35),
(2, 'WY-1', '12 x 12', 45),
(3, 'OR-1', '8 x 8', 25),
(3, 'WA-1', '9 x 12', 30),
(3, 'WY-1', '12 x 12', 45),
(4, 'OR-1', '8 x 12', 30),
(4, 'WA-1', '9 x 12', 30),
(4, 'WY-1', '12 x 18', 70),
(5, 'OR-1', '8 x 8', 25),
(5, 'WA-1', '12 x 12', 85),
(5, 'WY-1', '12 x 18', 70),
(6, 'OR-1', '8 x 12', 30),
(6, 'WA-1', '12 x 12', 85),
(6, 'WY-1', '12 x 12', 45),
(7, 'OR-1', '8 x 10', 25),
(7, 'WA-1', '12 x 10', 80),
(7, 'WY-1', '12 x 12', 85),
(8, 'OR-1', '15 x 15', 95),
(8, 'WA-1', '12 x 10', 80),
(8, 'WY-1', '12 x 8', 35),
(9, 'OR-1', '15 x 15', 95),
(9, 'WA-1', '18 x 18', 115),
(9, 'WY-1', '15 x 15', 95),
(10, 'OR-1', '15 x 15', 95),
(10, 'WA-1', '18 x 18', 115),
(10, 'WY-1', '18 x 18', 115),
(11, 'WY-1', '12 x 12', 45);

-- Unit Rentals

INSERT INTO unitrentals (CustID, WarehouseID, UnitID, DateIn, DateOut)
VALUES
(2, 'OR-1', 4, '2016-01-04', NULL),
(2, 'OR-1', 5, '2016-01-04', NULL),
(4, 'WY-1', 3, '2016-02-15', NULL),
(6, 'WA-1', 5, '2016-01-01', NULL),
(7, 'WY-1', 6, '2016-01-15', NULL),
(7, 'WY-1', 11, '2016-01-15', NULL),
(9, 'WA-1', 10, '2016-02-15', NULL),
(10, 'OR-1', 6, '2016-02-01', NULL),
(10, 'OR-1', 7, '2016-02-01', NULL),
(10, 'OR-1', 8, '2016-02-15', NULL),
(11, 'WY-1', 2, '2016-01-15', NULL),
(12, 'WA-1', 2, '2016-02-15', NULL),
(12, 'WA-1', 6, '2016-02-01', NULL),
(13, 'WY-1', 4, '2016-02-01', NULL),
(13, 'WY-1', 5, '2016-02-01', NULL),
(14, 'WA-1', 4, '2016-02-15', NULL),
(15, 'WA-1', 3, '2016-02-20', NULL),
(17, 'WY-1', 9, '2016-02-01', NULL),
(18, 'WA-1', 7, '2016-02-01', NULL),
(20, 'WA-1', 6, '2016-01-15', NULL),
(26, 'OR-1', 2, '2016-02-01', NULL),
(27, 'WA-1', 8, '2016-02-01', NULL),
(31, 'WY-1', 8, '2016-02-20', NULL),
(32, 'WA-1', 9, '2016-01-05', NULL),
(36, 'OR-1', 10, '2016-02-15', NULL),
(38, 'WY-1', 10, '2016-01-15', NULL);

