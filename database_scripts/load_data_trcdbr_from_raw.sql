-- The original TRC database was a pioneer in its day and as such, the design was suboptimal:
--    mix of natural and generated keys;
--    incomplete additions to the database that were never properly implemented;
--    inconsistent naming conventions and meaningless abbreviations;
--    poor choice of table and field names;
--    use of SQL reserved words (e.g. Action);
--    incomplete normalisation.

-- This data load script rectifies these issues and brings the data model closer to the HURIDOCS model.

-- It loads the original data from the trcdbr_raw schema into the schema owned by the relevant schema_owner.
-- Run this as 'psql -h [hostname] -d trcdbr -U [schema_owner] --echo-all --file=load_data_trcdbr_from_raw.sql'

-- Drop all existing tables, cascading to other database artefacts such as sequences:
drop table witnesses cascade;
drop table perpetrators cascade;
drop table victims cascade;
drop table acts cascade;
drop table documents cascade;
drop table findings cascade;
drop table relationships cascade;
drop table aliases cascade;
drop table persons cascade;
drop table places cascade;
drop table provinces cascade;
drop table old_provinces cascade;
drop table act_types cascade;
drop table act_categories cascade;
drop table organisations cascade;
drop table organisation_types cascade;
drop table protocol_types cascade;
drop table location_types cascade;
drop table victim_types cascade;
drop table outcome_types cascade;
drop table document_statuses cascade;
drop table summary_statuses cascade;
drop table offices cascade;
drop table languages cascade;
drop table relationship_natures cascade;
drop table perpetrator_findings cascade;
drop table victim_findings cascade;
drop table amnesty_findings cascade;
drop table genders cascade;
drop table population_groups cascade;
drop table veracities cascade;
drop table time_accuracies cascade;
drop table date_accuracies cascade;

-- Create the reference data tables
-- First, the basic master data tables
create table date_accuracies (
id serial primary key,
code text unique not null,
description text);
comment on table date_accuracies is 'Indicates the accuracy of the date.';
insert into date_accuracies (code)
select distinct upper("DATE_ACCURATE_TO") from trcdbr_raw."dbo_ACTS" where "DATE_ACCURATE_TO" is not null;

create table time_accuracies (
id serial primary key,
code text unique not null,
description text);
comment on table time_accuracies is 'Indicates the accuracy of the time.';
insert into time_accuracies (code)
select distinct upper("TIME_ACCURATE_TO") from trcdbr_raw."dbo_ACTS" where "TIME_ACCURATE_TO" is not null;

create table veracities (
id serial primary key,
code text unique not null,
description text);
comment on table veracities is 'Indicates the veracity of allegations.';
insert into veracities (code)
select distinct upper("VERACITY") from trcdbr_raw."dbo_ACTS" where "VERACITY" is not null;

create table population_groups (
id serial primary key,
code text unique not null,
description text);
comment on table population_groups is 'Population group, or race, of a person.';
insert into population_groups (code)
select distinct upper("RACE") from trcdbr_raw."dbo_PERSONS" where "RACE" is not null;

create table genders (
id serial primary key,
code text unique not null,
description text);
comment on table genders is 'The gender identification of a person, such as male, female, other.';
insert into genders (code)
select distinct upper("SEX") from trcdbr_raw."dbo_PERSONS" where "SEX" is not null;

create table relationship_natures (
id serial primary key,
code text unique not null,
description text);
comment on table relationship_natures is 'The nature of the relationship between two people.';
insert into relationship_natures (code)
select distinct upper("NATURE") from trcdbr_raw."dbo_RELATIONS" where "NATURE" is not null;

create table perpetrator_findings (
id serial primary key,
code text unique not null,
description text);
comment on table perpetrator_findings is 'The finding by the TRC whether the person was a perpetrator of a gross violation of human rights or not.';
insert into perpetrator_findings (code)
select distinct upper("PERP_FINDING") from trcdbr_raw."dbo_PERPETRATORS" where "PERP_FINDING" is not null;

create table victim_findings (
id serial primary key,
code text unique not null,
description text);
comment on table victim_findings is 'The finding by the TRC whether the person was a victim of a gross violation of human rights or not.';
insert into victim_findings (code)
select distinct upper("VICTIM_FINDING") from trcdbr_raw."dbo_PERSONS" where "VICTIM_FINDING" is not null;

create table amnesty_findings (
id serial primary key,
code text unique not null,
description text);
comment on table amnesty_findings is 'The finding by the TRC whether amnesty should be granted or not.';
insert into amnesty_findings (code)
select distinct upper("AMNESTY_GRANTED") from trcdbr_raw."dbo_SOURCES" where "AMNESTY_GRANTED" is not null;

create table languages (
id serial primary key,
code text unique not null,
description text);
comment on table languages is 'Mother tongue languages used in the TRC processes.';
insert into languages (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_LANGS";

create table document_statuses (
id serial primary key,
code text unique not null,
description text);
comment on table document_statuses is 'Status of the document in its lifecycle.';
insert into document_statuses (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_SOURCE_STATUSES";

create table summary_statuses (
id serial primary key,
code text unique not null,
description text);
comment on table summary_statuses is 'Status of the summary of the finding.';
insert into summary_statuses (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_SUMMARY_STATUSES";

create table offices (
id serial primary key,
code text unique not null,
description text);
comment on table summary_statuses is 'Office responsible for the document.';
insert into offices (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_TRC_OFFICES";

create table outcome_types (
id serial primary key,
code text unique not null,
description text);
comment on table outcome_types is 'Types of outcome of an act of violence.';
insert into outcome_types (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_OUTCOME_TYPES";

create table victim_types (
id serial primary key,
code text unique not null,
description text);
comment on table victim_types is 'Type of victim.';
insert into victim_types (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_VICTIM_TYPES";

create table location_types (
id serial primary key,
code text unique not null,
description text);
comment on table location_types is 'Type of location where an act took place.';
insert into location_types (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_LOCATION_TYPES";

create table protocol_types (
id serial primary key,
code text unique not null,
description text);
comment on table protocol_types is 'Type of protocol used to capture the data.';
insert into protocol_types (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_PROTOCOL_TYPES";

-- Now for the more complex master data
-- Create Act Categories and Types
create table act_categories (
id serial primary key,
code text unique not null,
description text);
comment on table act_categories is 'Type of human rights violation as described in the TRC Act.';
insert into act_categories (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_ACTION_TYPES";

create table act_types (
id serial primary key,
code text not null,
description text,
act_category integer not null, -- fkey to act_categories
unique (code, act_category) -- only one act type per act category
);
comment on table act_types is 'Method of violence used in the act.';
alter table act_types add foreign key(act_category) references act_categories;
insert into act_types (code, description, act_category)
select rac."CODE", rac."DESCRIPTION", dac.id from act_categories dac, trcdbr_raw."dbo_ACTIONS" rac where rac."ACTION_TYPE" = dac.code;

-- Create Provinces and Places
create table provinces (
id serial primary key,
code text unique not null,
name text
);
comment on table provinces is 'Names of post-1994 provinces.';
insert into provinces (code, name)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_PROVINCES";

create table old_provinces (
id serial primary key,
code text unique not null,
name text
);
comment on table old_provinces is 'Names of pre-1994 provinces and bantustans.';
insert into old_provinces (code, name)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_OLD_PROVINCES";

create table places (
id serial primary key,
code text unique not null,
name text not null,
notes text,
province integer, -- fkey to provinces
old_province integer, -- fkey to old_provinces
latitude bigint,
longitude bigint
);
comment on table old_provinces is 'Standardised list of places mentioned in source documents.';
alter table places add foreign key(province) references provinces;
alter table places add foreign key(old_province) references old_provinces;
insert into places (code, name, notes, province, old_province)
select "CODE",
trim(substring("DESCRIPTION" from 1 for position('(' in "DESCRIPTION") - 1)),
trim(substring("DESCRIPTION" from position('(' in "DESCRIPTION") + 1 for position(')' in "DESCRIPTION") - position('(' in "DESCRIPTION") - 1)),
dpp.id, dop.id
from trcdbr_raw."dbo_PLACES" rp
left outer join provinces dpp on dpp.code = rp."NEW_PROVINCE"
left outer join old_provinces dop on dop.code = rp."OLD_PROVINCE";

-- Create Organisations and Organisation Types
create table organisation_types (
id serial primary key,
code text unique not null,
description text
);
comment on table organisation_types is 'Political alignment of organisations.';
insert into organisation_types (code, description)
select "CODE", "DESCRIPTION" from trcdbr_raw."dbo_ORG_TYPES";

create table organisations (
id serial primary key,
oid integer unique not null, -- system identifier used in the original data set
name text unique not null,
acronym text unique,
notes text,
parent integer, -- fkey to parent organisation
organisation_type integer -- fkey to organisation_types
);
comment on table organisations is 'Names of organisations whose members are participants in acts.';
alter table organisations add foreign key(parent) references organisations;
alter table organisations add foreign key(organisation_type) references organisation_types;
insert into organisations (oid, name, acronym, notes, organisation_type)
select "ORG_ID", rog."FULL_NAME", rog."ACRONYM", rog."GEN_COMMENT", dot.id
from trcdbr_raw."dbo_ORGANISATIONS" rog
left outer join organisation_types dot on rog."ORG_TYPE" = dot.code
;
-- Find the parent organisation from the raw data, and then find its new generated key
update organisations og set parent = (
select ppog.id
from trcdbr_raw."dbo_ORGANISATIONS" rog, trcdbr_raw."dbo_ORGANISATIONS" pog, organisations ppog
where rog."ORG_ID" = og.oid
and pog."ORG_ID" = rog."PARENT_ORG_ID"
and pog."ORG_ID" = ppog.oid);

-- Finally, the main transactional data
-- Persons
create table persons (
id serial primary key,
oid integer unique not null, -- primary key used in the original data set
title text,
first_names text,
last_name text not null,
population_group integer, -- fkey to population_groups
gender integer, -- fkey to genders
language integer, -- fkey to languages
date_of_birth date,
place_of_birth integer, -- fkey to places
marital_status text,
prison text,
prison_number text,
notes text
);
comment on table persons is 'An individual who is involved in an act, in one or other role.';
-- Add foreign key constraints
alter table persons add foreign key(population_group) references population_groups;
alter table persons add foreign key(gender) references genders;
alter table persons add foreign key(language) references languages;
alter table persons add foreign key(place_of_birth) references places;
-- Load the data, replacing the natural keys with the generated id keys
insert into persons (
oid, title, last_name, first_names, population_group, gender, language,
date_of_birth,
place_of_birth, marital_status, prison_number, prison, notes
)
select
"PERSON_ID", "TITLE", "LAST_NAME", "FIRST_NAMES", dpg.id, dg.id, dl.id,
to_date('19'||substring("DATE_OF_BIRTH" from 7 for 2)||substring("DATE_OF_BIRTH" from 1 for 2)||substring("DATE_OF_BIRTH" from 4 for 2),'YYYYMMDD'),
pl.id, "MARITAL_STATUS",
"PRISON_NO",  "PRISON",  "GEN_COMMENT"
from trcdbr_raw."dbo_PERSONS" rp
left outer join population_groups dpg on rp."RACE" = dpg.code
left outer join genders dg on rp."SEX" = dg.code
left outer join languages dl on rp."LANG" = dl.code
left outer join places pl on rp."PLACE_OF_BIRTH" = pl.code
;
-- Create aliases for people
create table aliases (
id serial primary key,
person integer not null, -- fkey to people
alias_name text not null
)
;
comment on table aliases is 'An alternative name by which a person is known.';
alter table aliases add foreign key(person) references persons;
insert into aliases (person, alias_name)
select pr.id, "NAME"
from trcdbr_raw."dbo_ALIASES" ra
left join persons pr on ra."PERSON_ID" = pr.oid
;
-- Create relationships between people
create table relationships (
id serial primary key,
person integer, -- fkey to people
relationship_nature integer, -- fkey to the nature of the relationship
related_person integer -- fkey to people
)
;
comment on table relationships is 'Relationship between two people.';
-- Fkey constraints
alter table relationships add foreign key(person) references persons;
alter table relationships add foreign key(relationship_nature) references relationship_natures;
alter table relationships add foreign key(related_person) references persons;
-- Insert the data
insert into relationships (person, relationship_nature, related_person)
select pr0.id, rn.id, pr1.id
from trcdbr_raw."dbo_RELATIONS" ra
left join persons pr0 on ra."PERSON_ID" = pr0.oid
left join relationship_natures rn on ra."NATURE" = rn.code
left join persons pr1 on ra."RELATED_PERSON_ID" = pr1.oid
;

-- Move findings from the persons table to their own table
create table findings (
id serial primary key,
person integer unique not null, -- fkey to the persons table
victim_finding integer not null, --fkey to victim_findings
date_of_finding date,
summary_status integer, -- fkey to summary_statuses
summary_of_finding text
);
comment on table relationships is 'Finding by the TRC whether the victim suffered a gross violation of human rights or not.';
-- Fkey constraints
alter table findings add foreign key(person) references persons;
alter table findings add foreign key(victim_finding) references victim_findings;
alter table findings add foreign key(summary_status) references summary_statuses;
-- Insert the data
insert into findings (person, victim_finding, date_of_finding, summary_status, summary_of_finding)
select pr.id, vf.id,
to_date('19'||substring("DATE_FINDING" from 7 for 2)||substring("DATE_FINDING" from 1 for 2)||substring("DATE_FINDING" from 4 for 2),'YYYYMMDD'),
ss.id, "FINDING_SUMMARY"
from trcdbr_raw."dbo_PERSONS" ra
left join persons pr on ra."PERSON_ID" = pr.oid
left join victim_findings vf on ra."VICTIM_FINDING" = vf.code
left outer join summary_statuses ss on ra."SUMMARY_STATUS" = ss.code
where "VICTIM_FINDING" is not null
;
-- Create Documents
-- Note that Documents is polymorphic (stores both HRV Statements as well as Amnesty Applications) hence the discriminator field 'document_type'.
create table documents (
id serial primary key,
document_type text not null, -- type of document, either 'A' or 'H'
reference_no text unique not null,
protocol_type integer not null, -- fkey to type of protocol used
date_of_document date,
place integer, -- fkey to place where the statement was taken
office integer, -- fkey of the office responsible
person integer not null, -- fkey of the person being interviewed or amnesty applicant
language integer, -- fkey of the language used
document_status integer, -- fkey to the document status
summary text,
notes text,
amnesty_finding integer -- fkey to the amnesty findings
);
comment on table documents is 'Source document: either an Amnesty Application or a Statement about Human Rights Violations.';
-- Fkey constraints
alter table documents add foreign key(protocol_type) references protocol_types;
alter table documents add foreign key(place) references places;
alter table documents add foreign key(office) references offices;
alter table documents add foreign key(person) references persons;
alter table documents add foreign key(language) references languages;
alter table documents add foreign key(document_status) references document_statuses;
alter table documents add foreign key(amnesty_finding) references amnesty_findings;
-- Insert the data
insert into documents (
document_type, reference_no, protocol_type, date_of_document, place, person, language, document_status,
summary, notes,
amnesty_finding
)
select substring("PROTOCOL_TYPE" from 1 for 1), "REF_NO", pt.id,
to_date('19'||substring("INTERVIEW_START" from 7 for 2)||substring("INTERVIEW_START" from 1 for 2)||substring("INTERVIEW_START" from 4 for 2),'YYYYMMDD'),
pl.id, pr.id, lg.id, ds.id, "GEN_COMMENT", "NOTE",
af.id
from trcdbr_raw."dbo_SOURCES" rd
left join protocol_types pt on rd."PROTOCOL_TYPE" = pt.code
left join persons pr on rd."INTERVIEWEE" = pr.oid
left outer join places pl on rd."PLACE" = pl.code
left outer join offices fo on rd."TRC_OFFICE" = fo.code
left outer join languages lg on rd."LANG" = lg.code
left outer join document_statuses ds on rd."SOURCE_STATUS" = ds.code
left outer join amnesty_findings af on rd."AMNESTY_GRANTED" = af.code
;

-- Create Acts
create table acts (
id serial primary key,
document integer not null, -- fkey to documents
reference_no text not null,
sequence_no integer not null,
act_category integer not null, -- fkey to act_categories
act_type integer not null, -- fkey to act_types
description text not null,
place integer, -- fkey to places
location_type integer, -- fkey to location_types
specific_location text,
date_of_act date,
day integer, month integer, year integer,
date_accuracy integer, -- fkey to date_accuracies
time_accuracy integer, --fkey to time_accuracies
circumstances text,
reason text,
notes text,
veracity integer, -- fkey to veracities code table
unique (reference_no, sequence_no)
);
comment on table acts is 'A single action, usually involving force, committed by an individual or group against another.';
-- Create foreign key constraints for Acts
alter table acts add foreign key(document) references documents;
alter table acts add foreign key(act_category) references act_categories;
alter table acts add foreign key(act_type) references act_types;
alter table acts add foreign key(place) references places;
alter table acts add foreign key(location_type) references location_types;
alter table acts add foreign key(date_accuracy) references date_accuracies;
alter table acts add foreign key(time_accuracy) references time_accuracies;
alter table acts add foreign key(veracity) references veracities;
-- Insert the data
insert into acts (
document, reference_no, sequence_no, act_category, act_type, description, place, location_type, specific_location,
date_of_act, day, month, year, date_accuracy, time_accuracy,
circumstances, reason, notes, veracity)
select
dc.id, "REF_NO", "ACT_SEQ", acat.id, atyp.id,"ACTION_DESCRIPTION", pl.id, lt.id, "SPECIFIC_LOCATION",
to_date('19'||substring("ACT_DATE" from 7 for 2)||substring("ACT_DATE" from 1 for 2)||substring("ACT_DATE" from 4 for 2),'YYYYMMDD'),
"DAY", "MONTH", "YEAR", dac.id, tac.id,
"CIRCUMSTANCES", "REASON", "GEN_COMMENT",
vac.id
from trcdbr_raw."dbo_ACTS" ra
left join documents dc on ra."REF_NO" = dc.reference_no
left join act_categories acat on ra."ACTION_TYPE" = acat.code
left join act_types atyp on ra."ACTION" = atyp.code and atyp.act_category = acat.id
left outer join places pl on ra."PLACE" = pl.code
left outer join location_types lt on ra."LOCATION_TYPE" = lt.code
left outer join date_accuracies dac on ra."DATE_ACCURATE_TO" = dac.code
left outer join time_accuracies tac on ra."TIME_ACCURATE_TO" = tac.code
left outer join veracities vac on ra."VERACITY" = vac.code
;

-- Create victims from victim-specific details in "dbo_ACTS"
create table victims (
id serial primary key,
document integer not null, -- fkey to documents
act integer unique not null, -- fkey to the act that the victim was involved in
person integer, -- fkey to person details
finding integer, -- fkey to findings on the person
age_of_victim integer,
victim_type integer, -- fkey to types of victims
outcome_type integer, -- fkey to outcome_types
outcome text,
organisation integer -- fkey to organisation
);
comment on table victims is 'Involvement of a person in an act as the victim.';
-- Create foreign key constraints for Victims
alter table victims add foreign key(document) references documents;
alter table victims add foreign key(act) references acts;
alter table victims add foreign key(person) references persons;
alter table victims add foreign key(finding) references findings;
alter table victims add foreign key(victim_type) references victim_types;
alter table victims add foreign key(outcome_type) references outcome_types;
alter table victims add foreign key(organisation) references organisations;
-- Insert the data
insert into victims (document, act, person, age_of_victim, victim_type, outcome_type, outcome, organisation)
select dc.id, ac.id, pr.id, "VICTIM_AGE", vt.id, ot.id, "OUTCOME", og.id
from trcdbr_raw."dbo_ACTS" ra
left join documents dc on ra."REF_NO" = dc.reference_no
left join acts ac on ra."REF_NO" = ac.reference_no and ra."ACT_SEQ" = ac.sequence_no
left outer join persons pr on ra."VICTIM" = pr.oid
left outer join victim_types vt on ra."VICTIM_TYPE" = vt.code
left outer join outcome_types ot on ra."OUTCOME_TYPE" = ot.code
left outer join organisations og on ra."VICTIM_ORG_ID" = og.oid
left outer join findings fd on pr.id = fd.person
;

-- Create perpetrators
create table perpetrators (
id serial primary key,
document integer not null, -- fkey to documents
act integer not null, -- fkey to acts
person integer, -- fkey to persons
organisation integer, -- fkey to organisations
language integer,  -- fkey to languages
notes text,
weapon text,
vehicle text,
identification_method text,
description text,
last_known_location text,
perpetrator_finding integer --fkey to perpetrator_findings
)
;
comment on table perpetrators is 'Involvement of a person as a perpetrator of the act.';
-- Fkey constraints
alter table perpetrators add foreign key(document) references documents;
alter table perpetrators add foreign key(act) references acts;
alter table perpetrators add foreign key(person) references persons;
alter table perpetrators add foreign key(language) references languages;
alter table perpetrators add foreign key(organisation) references organisations;
alter table perpetrators add foreign key(perpetrator_finding) references perpetrator_findings;
-- Insert the data
insert into perpetrators (document, act, person, organisation, language, notes,
weapon, vehicle, identification_method, description, last_known_location, perpetrator_finding)
select dc.id, ac.id, pr.id, og.id, lg.id, "GEN_COMMENT",
"WEAPON", "VEHICLE", "HOW_IDENTIFIED", "IDENTIFYING_CHARS", "LAST_SEEN",fd.id
from trcdbr_raw."dbo_PERPETRATORS" rp
left join documents dc on rp."REF_NO" = dc.reference_no
left join acts ac on rp."REF_NO" = ac.reference_no and rp."ACT_SEQ" = ac.sequence_no
left outer join persons pr on rp."PERSON_ID" = pr.oid
left outer join organisations og on rp."PERP_ORG_ID" = og.oid
left outer join languages lg on rp."LANG" = lg.code
left outer join perpetrator_findings fd on rp."PERP_FINDING" = fd.code
;

-- Create witnesses
create table witnesses (
id serial primary key,
document integer not null, -- fkey to documents
act integer not null, -- fkey to acts
person integer, -- fkey to persons
eye_witness text,
notes text
)
;
comment on table witnesses is 'Involvement of a person as a witness of the act.';
-- Fkey constraints
alter table witnesses add foreign key(document) references documents;
alter table witnesses add foreign key(act) references acts;
alter table witnesses add foreign key(person) references persons;
-- Insert the data
insert into witnesses (document, act, person, eye_witness, notes)
select dc.id, ac.id, pr.id, "EYEWITNESS", "GEN_COMMENT"
from trcdbr_raw."dbo_WITNESSES" rw
left join documents dc on rw."REF_NO" = dc.reference_no
left join acts ac on rw."REF_NO" = ac.reference_no and rw."ACT_SEQ" = ac.sequence_no
left outer join persons pr on rw."PERSON_ID" = pr.oid
;
