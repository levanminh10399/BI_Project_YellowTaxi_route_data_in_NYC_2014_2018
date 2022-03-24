CREATE DATABASE YTT_STAGE
GO

USE YTT_STAGE
GO
 
CREATE TABLE TAXITRIP_STAGE
(
	dropoff_datetime DATETIME null,
	dropoff_latitude FLOAT null,
	dropoff_longitude FLOAT null, 
	extra Float null,
	fare_amount Float null,
	mta_tax Float NULL,
	passenger_count Int null, 
	payment_type VARCHAR(50) null,
	pickup_datetime DATETIME null,
	pickup_latitude Varchar(50) null,
	pickup_longitude varchar(50) null,
	rate_code Int null,
	tip_amount Float null, 
	tolls_amount Float null,
	total_amount Float null,
	trip_distance Float null,
	vendor_id VARCHAR(50) null,
	[pickup_CensusBlock] VARCHAR(50) null,
	[dropoff_CensusBlock] VARCHAR(50) null,
)
CREATE TABLE CENCUSBLOCK_STAGE
(
	CTLabel varchar(10) null, 
	BoroName varchar (50) null,
	BoroCode varchar (10) null,
	CT2010 Varchar(6) null, 
	BoroCT2010 Varchar(7) null,
	CDEligibil CHAR(4) null,
	NTACode Varchar(10) null,
	NTAName Varchar(50) null,
	PUMA Varchar(10) null,
	Shape_Leng Float null, 
	Shape_Area Float null
)
