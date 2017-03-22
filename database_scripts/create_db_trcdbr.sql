-- Run this as 'psql -h [hostname] -U postgres --echo-all --file=create_db_trcdbr.sql'

-- Database: trcdbr

-- DROP DATABASE trcdbr;

CREATE DATABASE trcdbr
  WITH OWNER = postgres
	TABLESPACE = go_data
	TEMPLATE = template0
	ENCODING = 'UTF8'
	LC_COLLATE = 'en_ZA.UTF-8'
	LC_CTYPE = 'en_ZA.UTF-8'
	CONNECTION LIMIT = -1;

COMMENT ON DATABASE trcdbr
  IS 'Database of redacted TRC data';

