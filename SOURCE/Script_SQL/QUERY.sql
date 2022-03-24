USE YTT_NDS
go

-- TAO FUNCTION GOP GIO-NGAY-THANG-NAM DE TAO KHOA
CREATE FUNCTION f_Hour_Day_Month_Year
(@hour TINYINT,@day TINYINT,@month TINYINT,@year INTEGER)
RETURNS DateTime
AS
BEGIN

RETURN DATEADD(HOUR,@hour,DATEADD(day, @day -1, 
									  DateAdd(month, @month -1, 
										  DateAdd(Year, @year-1900, 0))))
END

-- LAY PICKUP CENCUS BLOCK VA DATETIME PICKUP
USE YTT_NDS
SELECT pickup_CensusBlock,(SELECT  dbo.f_Hour_Day_Month_Year(DATEPART(HOUR,pickup_datetime),
											DATEPART(DAY,pickup_datetime),
											DATEPART(MONTH,pickup_datetime),
											DATEPART(YEAR,pickup_datetime))) AS 'datetime'
FROM dbo.TaxiTrip_NDS GROUP BY  pickup_CensusBlock,
								DATEPART(HOUR,pickup_datetime),
								DATEPART(DAY,pickup_datetime),
								DATEPART(MONTH,pickup_datetime),
								DATEPART(YEAR,pickup_datetime)  ORDER BY pickup_CensusBlock,datetime

-- LAY DROPOFF CENCUS BLOCK VA DATETIME DROPOFF
USE YTT_NDS
INSERT INTO YTT_DDS.DBO.f_TaxiTrip(IDCensusBlock, DateTime) 
SELECT dropoff_CensusBlock,(SELECT  YTT_NDS.dbo.f_Hour_Day_Month_Year(DATEPART(HOUR,dropoff_datetime),
											DATEPART(DAY,dropoff_datetime),
											DATEPART(MONTH,dropoff_datetime),
											DATEPART(YEAR,dropoff_datetime))) AS 'datetime'
FROM YTT_NDS.dbo.TaxiTrip_NDS GROUP BY  dropoff_CensusBlock,
								DATEPART(HOUR,dropoff_datetime),
								DATEPART(DAY,dropoff_datetime),
								DATEPART(MONTH,dropoff_datetime),
								DATEPART(YEAR,dropoff_datetime)  ORDER BY dropoff_CensusBlock,datetime

-- TINH TONG SO CHUYEN PICKUP TAI CENCUSBLOCK TRONG THOI DIEM
USE YTT_NDS
SELECT pickup_CensusBlock,
		(SELECT  dbo.f_Hour_Day_Month_Year(DATEPART(HOUR,pickup_datetime),
											DATEPART(DAY,pickup_datetime),
											DATEPART(MONTH,pickup_datetime),
											DATEPART(YEAR,pickup_datetime))) AS 'datetime',
		COUNT(*) AS amountPickUp
FROM dbo.TaxiTrip_NDS GROUP BY pickup_CensusBlock, 
						DATEPART(HOUR,pickup_datetime),
						DATEPART(DAY,pickup_datetime),
						DATEPART(MONTH,pickup_datetime),
						DATEPART(YEAR,pickup_datetime)  ORDER BY amountPickUp DESC

-- TINH TONG SO CHUYEN DROPOFF TAI CENCUSBLOCK TRONG THOI DIEM
USE YTT_NDS
SELECT dropoff_CensusBlock,
		(SELECT  dbo.f_Hour_Day_Month_Year(DATEPART(HOUR,dropoff_datetime),
											DATEPART(DAY,dropoff_datetime),
											DATEPART(MONTH,dropoff_datetime),
											DATEPART(YEAR,dropoff_datetime))) AS thoiDiem,
		COUNT(*) AS amountDropoff
FROM dbo.TaxiTrip_NDS GROUP BY dropoff_CensusBlock, 
						DATEPART(HOUR,dropoff_datetime),
						DATEPART(DAY,dropoff_datetime),
						DATEPART(MONTH,dropoff_datetime),
						DATEPART(YEAR,dropoff_datetime)  ORDER BY amountDropoff DESC

/*
SELECT IDCensusBlock, DateTime
FROM F_TAXITRIP

select count(*)
from F_TAXITRIP

truncate table f_taxitrip


SELECT *
FROM F_TAXITRIP F WHERE F.IDCensusBlock = 2

SELECT B.DateTime FROM YTT_DDS.DBO.f_TaxiTrip B
WHERE B.DateTime NOT IN (SELECT A.DateTime	FROM YTT_DDS.DBO.dimDateTime A)


SELECT * FROM YTT_STAGE.DBO.TAXITRIP_STAGE S
WHERE DATEPART(YEAR,S.dropoff_datetime) > 2015

SELECT COUNT(*) FROM YTT_DDS.DBO.dimDateTime
SELECT COUNT(*) FROM YTT_DDS.DBO.dimLocation
*/

-- TINH TONG SO CHUYEN DI THANH CONG TAI CENCUS BLOCK TRONG THOI DIEM
USE YTT_NDS
SELECT TX_NDS.dropoff_CensusBlock, (SELECT  dbo.f_Hour_Day_Month_Year(DATEPART(HOUR,TX_NDS.dropoff_datetime),
											DATEPART(DAY,TX_NDS.dropoff_datetime),
											DATEPART(MONTH,TX_NDS.dropoff_datetime),
											DATEPART(YEAR,TX_NDS.dropoff_datetime))) AS thoiDiem,
									COUNT(*) AS SUCCESS
FROM TaxiTrip_NDS TX_NDS
WHERE TX_NDS.payment_type = '1' OR TX_NDS.payment_type = '2' OR TX_NDS.payment_type = '3' 
GROUP BY TX_NDS.dropoff_CensusBlock, DATEPART(HOUR,TX_NDS.dropoff_datetime),
						DATEPART(DAY,TX_NDS.dropoff_datetime),
						DATEPART(MONTH,TX_NDS.dropoff_datetime),
						DATEPART(YEAR,TX_NDS.dropoff_datetime) ORDER BY SUCCESS DESC 

-- TINH TONG SO CHUYEN DI THAT BAI TAI CENCUS BLOCK TRONG THOI DIEM
USE YTT_NDS
SELECT TX_NDS.dropoff_CensusBlock, (SELECT  dbo.f_Hour_Day_Month_Year(DATEPART(HOUR,TX_NDS.dropoff_datetime),
											DATEPART(DAY,TX_NDS.dropoff_datetime),
											DATEPART(MONTH,TX_NDS.dropoff_datetime),
											DATEPART(YEAR,TX_NDS.dropoff_datetime))) AS thoiDiem,
									COUNT(*) AS FAIL
FROM TaxiTrip_NDS TX_NDS
WHERE TX_NDS.payment_type = '4' OR TX_NDS.payment_type = '5' OR TX_NDS.payment_type = '6' 
GROUP BY TX_NDS.dropoff_CensusBlock, DATEPART(HOUR,TX_NDS.dropoff_datetime),
						DATEPART(DAY,TX_NDS.dropoff_datetime),
						DATEPART(MONTH,TX_NDS.dropoff_datetime),
						DATEPART(YEAR,TX_NDS.dropoff_datetime) ORDER BY FAIL DESC 

-- TINH TONG DOANH THU TAI CENCUS BLOCK TRONG THOI DIEM
USE YTT_NDS
SELECT TX_NDS.dropoff_CensusBlock, (SELECT  dbo.f_Hour_Day_Month_Year(DATEPART(HOUR,TX_NDS.dropoff_datetime),
											DATEPART(DAY,TX_NDS.dropoff_datetime),
											DATEPART(MONTH,TX_NDS.dropoff_datetime),
											DATEPART(YEAR,TX_NDS.dropoff_datetime))) AS thoiDiem,
									SUM(TX_NDS.total_amount) AS TONGTIEN
FROM TaxiTrip_NDS TX_NDS
WHERE TX_NDS.payment_type = '1' OR TX_NDS.payment_type = '2' OR TX_NDS.payment_type = '3' 
GROUP BY TX_NDS.dropoff_CensusBlock, DATEPART(HOUR,TX_NDS.dropoff_datetime),
						DATEPART(DAY,TX_NDS.dropoff_datetime),
						DATEPART(MONTH,TX_NDS.dropoff_datetime),
						DATEPART(YEAR,TX_NDS.dropoff_datetime) ORDER BY TONGTIEN DESC 