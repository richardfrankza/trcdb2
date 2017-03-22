-- Role: trcdbr_raw
-- Run this as 'psql -h [hostname] -U postgres --echo-all --file=create_roles_trcdbr.sql'

-- DROP ROLE trcdbr_raw;
-- DROP ROLE trcdbr_prod;

CREATE ROLE trcdbr_raw 
  LOGIN
  PASSWORD 'trcdbr_raw'
  NOSUPERUSER 
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

COMMENT ON ROLE trcdbr_raw
  IS 'Owner of raw redacted TRC data.';

CREATE ROLE trcdbr_prod
  LOGIN
  PASSWORD 'trcdbr_prod'
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;

COMMENT ON ROLE trcdbr_prod
  IS 'Production user of redacted TRC data.';

