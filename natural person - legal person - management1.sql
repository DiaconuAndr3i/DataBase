--	1) Afisati codul si numele sediile si in cadrul acestora numele
--fiecarei persoane fizice care incepe cu 'C'.

select s.id_sediu, s.denumire, pf.nume
from sediu s join persoana_fizica pf
on s.id_sediu = pf.id_sediu
group by s.id_sediu, s.denumire, pf.nume
having lower(trim(pf.nume)) like 'c%';


--	2) Pentru fiecare sediu afisati persoana juridica iar pentru
--aceasta valoarea totala prin care a contribuit.

select s.id_sediu, pj.denumire_firma, sum(con.valoare)
from sediu s join persoana_juridica pj
on s.id_sediu = pj.id_sediu
join contributie con
on pj.cif = con.id_contribuabil_jr
group by (s.id_sediu, pj.denumire_firma);


--	3) Afisati o structura arborescenta de tipul 
--valoare - penalizare - valoare - penalizare -..., pentru a ilustra
--puterea financiara a persoanei fizice/ juridice care a contribuit
--cu cea mai mare suma de bani.

select id_contributie, denumire_contributie, level
from contributie
start with id_contributie = 
(select id_contributie from contributie 
where valoare = (select max(valoare) from contributie ))
connect by prior penalizare = valoare;


--	4) Afisati valoarea si denumirea contributiei persoanelor fizice
--in ordine descrescatoare a valorii si apoi a denumirii.

select pf.nume, pf.prenume, con.valoare, con.denumire_contributie
from persoana_fizica pf join contributie con
on pf.cnp = con.id_contribuabil_fiz
order by con.valoare, con.denumire_contributie desc;

--	5) Afisati sediile care contin cuvantul 'Fiscal' dar
--care nu au nicio persoana fizica/ juridica inregistrata.

select * from sediu
where id_sediu in
(select id_sediu
from sediu
minus
((select id_sediu from persoana_juridica)
union
(select id_sediu from persoana_fizica)))
and upper(trim(denumire)) like '%FISCAL%';

--	6) Pentru fiecare sediu localizat in Bucuresti precizati
--sectorul.

select denumire,
case 
when instr(lower(oras),1)!=0 then 'Sediul se afla in sectorul 1'
when instr(lower(oras),2)!=0 then 'Sediul se afla in sectorul 2'
when instr(lower(oras),3)!=0 then 'Sediul se afla in sectorul 3'
when instr(lower(oras),4)!=0 then 'Sediul se afla in sectorul 4'
when instr(lower(oras),5)!=0 then 'Sediul se afla in sectorul 5'
when instr(lower(oras),6)!=0 then 'Sediul se afla in sectorul 6'
else 'Sediul nu se afla in bucuresti sau nu e precizat sectorul'
end
from sediu;


--	7) Afisati adresa si numele persoanelor fizice care 
--au contribuit dupa 2015;

select ad.id_adresa, ad.oras, ad.strada, ad.cod_postal, pf.nume, pf.prenume
from adresa ad join persoana_fizica pf
on ad.id_adresa = pf.id_adresa
join contributie con
on con.id_contribuabil_fiz = 
pf.cnp
where to_char(data_achitare,'yyyy') > 2015; 


--	8) Afisati persoanele fizice/ juridice care au intarziat
--cel mai mult cu plata contributiei.

select con.id_contributie, pf.nume as nume, pf.prenume as prenume, pj.denumire_firma as "Denumire firma",
months_between(data_achitare, data_limita) as "Luni intarziere"
from contributie con left join persoana_fizica pf
on pf.cnp = con.id_contribuabil_fiz
left join persoana_juridica pj
on pj.cif = con.id_contribuabil_jr
where months_between(con.data_achitare, con.data_limita) = 
(select max(months_between(data_achitare, data_limita)) from contributie);


--	9) Afisati suma contributilor persoanelor fizice, juridice
--precum si totalul.

select 
sum(decode(id_contribuabil_fiz, null, valoare)) as "Suma persoane juridice",
sum(decode(id_contribuabil_jr, null, valoare)) as "Suma persoane fizice",
sum(valoare) as "Total"
from contributie;


--	10 ) Afisati codul persoanei fizice/ juridice care
--a depus o declaratie dar nu a platit vreo contributie.

select nvl(id_contribuabil_fiz, id_contribuabil_jr)
from declaratie
minus
select nvl(id_contribuabil_fiz, id_contribuabil_jr)
from contributie;


--	11) Afisati persoanele juridice care sunt inregistrate
--la un acelasi sediu cu cel putin o alta firma.

select pj1.denumire_firma
from persoana_juridica pj1 join persoana_juridica pj2
on nullif(pj1.id_sediu,pj2.id_sediu) is null
where pj1.cif != pj2.cif;



--	12) Afisati tipurile de declaratii care nu sunt folosite.

select t.tip_declaratie
from tip t join
(select id_tip as1
from tip
minus
select id_tip
from declaratie) asd
on t.id_tip = asd.as1;



--	13) Afisati codul persoanelor fizice/ juridice care
nu au contribuit in niciun fel.

(select cnp
from persoana_fizica
union 
select cif
from persoana_juridica)
minus
select nvl(id_contribuabil_fiz,id_contribuabil_jr)
from contributie;



--	14) Afisati media contributiilor persoanelor fizice/
--juridice precum si procentul din totalul sumelor pentru fiecare.

select 
avg(decode(id_contribuabil_fiz, null, valoare)) as "Media persoane juridice",
round(avg(decode(id_contribuabil_fiz, null, valoare))*100/sum(valoare), 2)||'%' as "Procent juridice",
avg(decode(id_contribuabil_jr, null, valoare)) as "Media persoane fizice",
round(avg(decode(id_contribuabil_jr, null, valoare))*100/sum(valoare), 2)||'%' as "Procent fizice"
from contributie;


--	15) Afisati adresa pentru fiecare persoana fizica

select pf.*, ad.*
from persoana_fizica pf join adresa ad
on ad.id_adresa = pf.id_adresa;

--	16) Afisati declaratiile care se incadreaza intr-un 
--anumit tip.

select * from tip t
inner join declaratie d 
on t.id_tip = d.id_tip;


--	17) Afisati cnp-urile persoanelor fizice care
--au depus toate declaratiile pentru plata impozitelor.

select distinct t1.cnp
from 
(select id_contribuabil_fiz cnp,
id_tip id_declaratie
from declaratie
where id_contribuabil_fiz
is not null) t1
where not exists
(select * 
from 
(select id_tip id_declaratie
from tip
where 
lower(trim(tip_declaratie))
like '%impozit%') t2
where not exists
(select *
from 
(select id_contribuabil_fiz cnp,
id_tip id_declaratie
from declaratie
where id_contribuabil_fiz
is not null) t3
where
t2.id_declaratie = t3.id_declaratie
and
t1.cnp = t3.cnp));



