CREATE DATABASE YTT_DDS
GO
USE YTT_DDS
GO
CREATE TABLE dimDateTime(
	[DateTime] DATETIME PRIMARY KEY,
	[Hour] AS (DATEPART(HOUR,[DateTime])),
	[Day] AS (DATEPART(DAY,[DateTime])),
	[DayOfWeek] AS (DATEPART(WEEKDAY,[DateTime])),
	[Month] AS (DATEPART(MONTH,[DateTime])),
	[Quarter] AS (DATEPART(QUARTER,[DateTime])),
	[Year] AS (DATEPART(YEAR,[DateTime])),
	Created_timestamp DATETIME,
	Updated_timestamp DATETIME,
)
GO
CREATE TABLE dimLocation(
	IDCensusBlock INT PRIMARY KEY,
	NTACode VARCHAR(10),
	NTA_name VARCHAR(50),
	BoroughCode VARCHAR(10),
	BoroughName VARCHAR(50),
	Shape_length FLOAT,
	Shape_Area FLOAT,
	create_timestamp DATETIME,
	update_timestamp DATETIME,
)

GO
CREATE TABLE f_TaxiTrip(
	IDCensusBlock INT,
	[DateTime] DATETIME,
	NumOfPickUpTrip INT,
	NumOfDropOffTrip INT,
	NumOfSuccess INT,
	NumOfFail INT,
	Total_amount FLOAT,
	Created_timestamp DATETIME,
	Update_timestamp DATETIME,
	PRIMARY KEY (IDCensusBlock,[DateTime])
)
GO
ALTER TABLE dbo.f_TaxiTrip ADD CONSTRAINT fk_cencus_f_TaxiTrip FOREIGN KEY (IDCensusBlock) REFERENCES dbo.dimLocation (IDCensusBlock);
ALTER TABLE dbo.f_TaxiTrip ADD CONSTRAINT fk_Datetime_f_TaxiTrip FOREIGN KEY ([DateTime]) REFERENCES dbo.dimDateTime ([DateTime]);
