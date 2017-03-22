-- Create schemas trcdbr_raw and trcdbr_prod and allow read-only access to trcdbr_raw from trcdbr_prod.
-- Run this as 'psql -h [hostname] -U postgres -d trcdbr --echo-all --file=create_schemas_trcdbr.sql'

-- DROP SCHEMA trcdbr_raw;
-- DROP SCHEMA trcdbr_prod;

CREATE SCHEMA trcdbr_raw AUTHORIZATION trcdbr_raw;
COMMENT ON SCHEMA trcdbr_raw IS 'Schema containing raw redacted TRC data.';

CREATE SCHEMA trcdbr_prod AUTHORIZATION trcdbr_prod;
COMMENT ON SCHEMA trcdbr_prod IS 'Schema containing redacted TRC data for production purposes.';


