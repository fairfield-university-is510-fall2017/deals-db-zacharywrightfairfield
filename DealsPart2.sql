# Zachary Wright 11/4/2017 My purpose of doing this was to do part 2: Selecting Queries
# Indicate that we are using the deals database
USE deals;  

# Execute a test query  
SELECT *
FROM Companies
WHERE CompanyName like "%Inc.";

# Select companies sorted by CompanyName
SELECT *
FROM Companies
ORDER BY CompanyID;

# Select Deal Parts with dollar values
SELECT DealName, PartNumber, DollarValue
FROM Deals, DealParts
WHERE DEALS.DealID = DealParts.DealID;

# Select Deal Parts with dollar values using a join
SELECT DealName, PartNumber, DollarValue
FROM Deals join DealParts on (Deals.DealID=DealParts.DealID);

# Show each company involved in each deal
SELECT DealName, RoleCode, CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
	JOIN DEALS ON (Players.DealID = DEALS.DEALID)
ORDER BY DEALNAME;

# Create a view that matches companies to deals
DROP VIEW IF EXISTS `CompanyDeals`;
CREATE View CompanyDeals AS
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
	JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;

# A test of the CompanyDeals view
SELECT * FROM CompanyDeals;

# 9 Create a view named DealValues that lists the DealID, total dollar value and number of parts for each deal.
DROP VIEW IF EXISTS `DEALVALUES`;
CREATE VIEW DealValues AS
SELECT DEALS.DEALID, SUM(DollarValue) AS TotDollarValue, COUNT(PartNumber) AS NumParts
FROM Deals JOIN DealParts ON (DEALS.DealID = DEALPARTS.DealID)
GROUP BY DEALS.DealID
ORDER BY DEALS.DealID;

SELECT * FROM DealValues;
# 10 Create a view named DealSummary that lists the DealID, DealName, number of players, total dollar value, and number of parts for each deal.
DROP VIEW IF EXISTS `DealSummary`;
CREATE VIEW DealSummary AS 
SELECT DEALS.DealID, DealName, COUNT(PlayerID) AS NumPlayers, TotDollarValue, NumParts
FROM DEALS JOIN DealValues ON (DEALS.DealID = DealValues.DealID)
			JOIN Players ON (DEALS.DealID = Players.DealID)
GROUP BY DEALS.DealID;

# 11 Create a view called DealsByType that lists TypeCode, number of deals, and total value of deals for each deal type.
DROP VIEW IF EXISTS `DealsByType`;
CREATE VIEW DealsByType AS
SELECT DealTypes.TypeCode, COUNT(Deals.DealID) AS NumDeals, SUM(DealParts.DollarValue) AS TotDollarValue
FROM DealTypes 
	JOIN Deals ON (DealTypes.DealID = Deals.DealID) 
	JOIN DealParts ON (DealParts.DealID = Deals.DealID)
GROUP BY DealTypes.TypeCode;

# 12 Create a view called DealPlayers that lists the CompanyID, Name, and Role Code for each deal. Sort the players by the RoleSortOrder.
DROP VIEW IF EXISTS `DealPlayers`;
CREATE VIEW DealPlayers AS
SELECT DealID, CompanyID, CompanyName, RoleCode
FROM Players 
	JOIN Deals USING (DealID) 
    JOIN COMPANIES USING (CompanyID)
    JOIN ROLECODES USING (RoleCode)
ORDER BY RoleSortOrder;

# 13 Create a view called DealsByFirm that lists the FirmID, Name, number of deals, and total value of deals for each firm.
DROP VIEW IF EXISTS `DealsByFirm`;
CREATE VIEW DealsByFirm AS 
SELECT FirmID, `Name` AS FirmName, COUNT(Players.DealID) AS NumDeals, SUM(TotDollarValue) AS TotValue
FROM FIRMS
	JOIN PLAYERSUPPORTS USING (FirmID)
	JOIN Players USING (PlayerID)
    JOIN DealValues USING (DealID)
GROUP BY FirmID, `Name`;