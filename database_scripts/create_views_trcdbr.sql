-- Create views needed for JSON API

-- Run this as 'psql -h [hostname] -d trcdbr -U [schema_owner] --echo-all --file=create_views_trcdbr.sql'

-- List the findings made about TRC victims
create or replace view victims_and_finding (person_oid, last_name, first_names, victim_finding, date_of_finding, summary_of_finding)
as select pr.id, pr.last_name, pr.first_names, vf.description, fd.date_of_finding, summary_of_finding
from findings fd
left join persons pr on pr.id = fd.person
left join victim_findings vf on vf.id = fd.victim_finding
;
comment on view victims_and_finding is 'List of victims with the TRC finding whether the person suffered a gross violation of human rights or not.';

-- Amnesty applications
create or replace view amnesty_applications (reference_no, person_oid, last_name, first_names, amnesty_finding, summary, notes, prison, prison_number, date_of_document, place, office, language, protocol_type, document_status)
as select
dc.reference_no, pr.id, pr.last_name, pr.first_names, af.description, dc.summary, dc.notes, pr.prison, pr.prison_number, dc.date_of_document, pl.name, fo.description, lg.description, pt.description, ds.description
from documents dc
left join persons pr on pr.id = dc.person
left outer join amnesty_findings af on af.id = dc.amnesty_finding
left outer join places pl on pl.id = dc.place
left outer join offices fo on fo.id = dc.office
left outer join languages lg on lg.id = dc.language
left outer join protocol_types pt on pt.id = dc.protocol_type
left outer join document_statuses ds on ds.id = dc.document_status
where dc.document_type = 'A'
;
comment on view amnesty_applications is 'List of Amnesty Applications, with Amnesty Finding.';

-- HRV Statements
create or replace view violation_statements (reference_no, person_oid, last_name, first_names, summary, notes, date_of_document, place, office, language, protocol_type, document_status)
as select
dc.reference_no, pr.id, pr.last_name, pr.first_names, dc.summary, dc.notes, dc.date_of_document, pl.name, fo.description, lg.description, pt.description, ds.description
from documents dc
left join persons pr on pr.id = dc.person
left outer join places pl on pl.id = dc.place
left outer join offices fo on fo.id = dc.office
left outer join languages lg on lg.id = dc.language
left outer join protocol_types pt on pt.id = dc.protocol_type
left outer join document_statuses ds on ds.id = dc.document_status
where dc.document_type = 'H'
;
comment on view violation_statements is 'List of Statements about violations of human rights.';

-- List of victims named in a statement
create or replace view victims_and_findings (reference_no, sequence_no, person_oid, last_name, first_names, victim_finding, summary_of_finding)
as select
dc.reference_no, ac.sequence_no, pr.id, pr.last_name, pr.first_names, victim_finding, summary_of_finding
from victims vc
left join acts ac on ac.id = vc.act
left join documents dc on dc.id = vc.document
left join persons pr on pr.id = vc.person
left outer join findings fd on fd.person = vc.person
;
comment on view victims_and_findings is 'List of victims and findings, with details of the source document.';
