delete from victims where person in (
select person from victims
except select id from persons where id < 1200 and id in (
select pr.id from documents dc, persons pr where person = pr.id
union select pr.id from victims vc, persons pr where vc.person = pr.id
union select pr.id from perpetrators pp, persons pr where pp.person = pr.id
union select pr.id from witnesses wt, persons pr where wt.person = pr.id
));

delete from perpetrators where person in (
select person from perpetrators
except select id from persons where id < 1200 and id in (
select pr.id from documents dc, persons pr where person = pr.id
union select pr.id from victims vc, persons pr where vc.person = pr.id
union select pr.id from perpetrators pp, persons pr where pp.person = pr.id
union select pr.id from witnesses wt, persons pr where wt.person = pr.id
));

delete from witnesses where person in (
select person from witnesses
except select id from persons where id < 1200 and id in (
select pr.id from documents dc, persons pr where person = pr.id
union select pr.id from victims vc, persons pr where vc.person = pr.id
union select pr.id from perpetrators pp, persons pr where pp.person = pr.id
union select pr.id from witnesses wt, persons pr where wt.person = pr.id
));

delete from findings where person in (
select person from findings
except select id from persons where id < 1200 and id in (
select pr.id from documents dc, persons pr where person = pr.id
union select pr.id from victims vc, persons pr where vc.person = pr.id
union select pr.id from perpetrators pp, persons pr where pp.person = pr.id
union select pr.id from witnesses wt, persons pr where wt.person = pr.id
));

delete from relationships where person in (
select person from relationships
except select id from persons where id < 1200 and id in (
select pr.id from documents dc, persons pr where person = pr.id
union select pr.id from victims vc, persons pr where vc.person = pr.id
union select pr.id from perpetrators pp, persons pr where pp.person = pr.id
union select pr.id from witnesses wt, persons pr where wt.person = pr.id
));

delete from aliases where person in (
select pr.id from persons pr
except (select person from documents
union select person from victims
union select act from perpetrators
union select act from witnesses));

delete from acts where id in (select id from acts except (select act from victims union select act from perpetrators union select act from witnesses));

delete from documents where id in (select id from documents except select document from acts);

delete from persons where id in (select id from persons except (
select person from documents
union select person from victims
union select person from perpetrators
union select person from witnesses
union select person from aliases
union select person from relationships
union select person from findings
union select related_person from relationships
));
