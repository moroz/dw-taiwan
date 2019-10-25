create temporary table nz_names (name text, email text);
copy nz_names from '/Users/karol/mahamudra/nz-name-email.csv' csv delimiter ';';
create temporary table nz_ids as
select distinct s.id from (
	select g.id, (trim(first_name) || ' ' || trim(last_name)) "name", trim(g.email) email from guests g
) s, nz_names nz where lower(s.name) = lower(nz.name) or lower(s.email) = lower(trim(nz.email)) order by 1;

copy (
  select row_number() over () "#", ss.* from (
select case
       when n.continent_id in (1, 4)
         or r.continent_id in (1, 4)
         then '✓'
       end "Asia/Australia",
       case when ni.id is not null then '✓' end "Glentui",
       (g.first_name || ' ' || g.last_name)::citext "Name",
       case when n.id = r.id then n."name"
       else r."name" || ' (' || n."name" || ')'
           end "Living in/From",
       g.city "City",
       null as "Your remarks"
  from guests g
         join countries n on g.nationality_id = n.id
         join countries r on g.residence_id = r.id
         left join nz_ids ni on ni.id = g.id
 order by 2, 1, 3) ss) to '/Users/karol/Desktop/20191025_Taipei_guests.csv' csv header;
