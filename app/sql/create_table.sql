CREATE TABLE j_onlineorder
  (id          VARCHAR2 (32) NOT NULL PRIMARY KEY,
   date_loaded TIMESTAMP (6) WITH TIME ZONE,
   oo_document VARCHAR2 (32767)
   CONSTRAINT oo_ensure_json CHECK (oo_document IS JSON));

CREATE TABLE j_onlinecustomerdata
  (id          VARCHAR2 (32) NOT NULL PRIMARY KEY,
   date_loaded TIMESTAMP (6) WITH TIME ZONE,
   oo_document VARCHAR2 (32767)
   CONSTRAINT ocd_ensure_json CHECK (oo_document IS JSON));


create table customerorder(Name varchar2(20),Phone varchar2(20),Location varchar2(20),Card varchar2(20));
Insert into customerorder values (‘John’,‘3892993328’,‘Jayanagar’,‘3278839833279238’);