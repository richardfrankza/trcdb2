-- This script recreates some missing data and makes some minor edits so that referential integrity can be re-established. 

-- NB: run this script ONCE only. It is NOT idempotent. If it gets messed up, you will have to recreate the trcdbr_raw schema.

-- Run this as 'psql -h [hostname] -d trcdbr -U trcdbr_raw --echo-all --file=fix_data_trcdbr_raw.sql'

-- Fix a Source document with a null Interviewee by creating a default Person record
insert into "dbo_PERSONS" ("PERSON_ID", "LAST_NAME") values ((select max("PERSON_ID")+1 from "dbo_PERSONS"), 'KZN/HG/152/EM');
update "dbo_SOURCES" set "INTERVIEWEE" = (select max("PERSON_ID") from "dbo_PERSONS") where "REF_NO" = 'KZN/HG/152/EM';

-- Fix up two Places with missing closing brackets in the Description
update "dbo_PLACES" set "DESCRIPTION" = 'South Paarl (Paarl, Western Cape)' where "CODE" = 'SOUTHPAARL';
update "dbo_PLACES" set "DESCRIPTION" = 'Marianhill (Durban, Kwazulu/Natal)' where "CODE" = 'MARIANHILL';
