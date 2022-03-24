create database YTT_NDS
go
use YTT_NDS
go

create table TaxiTrip_NDS(
	[DataTripID] int not null identity(1,1) primary key,
	[vendor_id] varchar(50) null,
	[passenger_count] int null,
	[rate_code] int null,
	[pickup_datetime] datetime null,
	[pickup_latitude] VARCHAR(50) null,
	[pickup_longitude] VARCHAR(50) null,
	[dropoff_datetime] datetime null,
	[dropoff_latitude] VARCHAR(50) null,
	[dropoff_longitude] VARCHAR(50) null,
	[pickup_CensusBlock] INT null,
	[dropoff_CensusBlock] INT null,
	[trip_distance] float null,
	[payment_type] varchar(50) null,
	[extra] float null,
	[fare_amount] float null,
	[mta_tax] float null,
	[tip_amount] float null,
	[tolls_amount] float null,
	[total_amount] float null,
	[CreatedDate] datetime null,
	[UpdatedDate] datetime null
)

create table CensusBlock_NDS(
	IDCensusBlock int not null identity(1,1) primary key,
	NTA INT NOT NULL,
	CensusBlockNK varchar(7) null,
	Shape_Length float null,
	Shape_Area float null,
	CreatedDate datetime null,
	UpdatedDate datetime 
)

create table NTA_NDS(
	IDNTA int not null identity(1,1) primary key,
	NTA_NK varchar(10) null,
	NTA_name varchar(50) null,
	Boro INT NOT NULL,
	CreatedDate datetime null,
	UpdatedDate datetime null
)

CREATE table Borough_NDS(
	IDBoro int not null identity(1,1) primary key,
	BoroNK varchar(10) null,
	Boro_name varchar(50) null,
	CreatedDate datetime null,
	UpdatedDate datetime null 
)

ALTER TABLE dbo.NTA_NDS
ADD CONSTRAINT F_NTA_BOR
FOREIGN KEY (Boro)
REFERENCES Borough_NDS(IDBoro)


ALTER TABLE CensusBlock_NDS
ADD CONSTRAINT F_CB_NTA
FOREIGN KEY (NTA)
REFERENCES NTA_NDS(IDNTA)
GO

ALTER TABLE dbo.TaxiTrip_NDS ADD CONSTRAINT pk_pickupCensusBlock FOREIGN KEY (pickup_CensusBlock) REFERENCES dbo.CensusBlock_NDS (IDCensusBlock)
ALTER TABLE dbo.TaxiTrip_NDS ADD CONSTRAINT pk_droffCensusBlock FOREIGN KEY (dropoff_CensusBlock) REFERENCES dbo.CensusBlock_NDS (IDCensusBlock)

go
