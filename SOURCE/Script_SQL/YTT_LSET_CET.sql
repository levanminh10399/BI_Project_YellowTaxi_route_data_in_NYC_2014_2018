
CREATE DATABASE YTT_LSET_CET
GO
USE YTT_LSET_CET
go

CREATE TABLE LSET_CET
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	LSET DATETIME,
	CET DATETIME
)

INSERT INTO LSET_CET(LSET) VALUES('2012-12-31')

SELECT * 
FROM LSET_CET



