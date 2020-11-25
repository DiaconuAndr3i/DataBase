drop table sediu cascade constraints;
drop table persoana_fizica cascade constraints;
drop table persoana_juridica cascade constraints;
drop table contributie cascade constraints;
drop table tip cascade constraints;
drop table declaratie cascade constraints;
drop table adresa cascade constraints;



create table sediu(
id_sediu    number(4) primary key,
denumire    varchar2(100) not null,
oras        varchar2(40) not null,
strada      varchar2(40) not null,
cod_postal  varchar2(10) not null
);


create table adresa(
id_adresa   number(4) primary key,
oras        varchar2(30) not null,
strada      varchar2(30) not null,
cod_postal  varchar2(10) not null
);


create table persoana_fizica(
cnp       number(20) primary key,
id_sediu  number(4) references sediu(id_sediu) not null,
nume      varchar2(30) not null,
prenume   varchar2(30) not null,
telefon   varchar2(10) not null,
id_adresa number(4) references adresa(id_adresa) not null
);


create table persoana_juridica(
cif               number(20) primary key,
nr_inmatriculare  varchar2(50) not null,
id_sediu          number(4) references sediu(id_sediu) not null,
denumire_firma    varchar2(100) not null,
telefon           varchar2(10) not null,
id_adresa         number(4) references adresa(id_adresa) not null
);


create table contributie(
id_contributie       number(4) primary key,
id_contribuabil_fiz  number(20) references persoana_fizica(cnp),
id_contribuabil_jr   number(20) references persoana_juridica(cif),
denumire_contributie varchar2(100),
data_achitare        date not null,
data_limita          date not null,
valoare              number(10) not null,
penalizare           number(10)
);


create table tip(
id_tip         number(4) primary key,
tip_declaratie varchar2(100) not null
);


create table declaratie(
id_declaratie       number(4) primary key,
id_tip              number(4) references tip(id_tip) not null,
id_contribuabil_fiz number(20) references persoana_fizica(cnp),
id_contribuabil_jr  number(20) references persoana_juridica(cif),
data_declaratie     date not null,
data_limita         date not null,
penalizare          number(10)
);

alter table contributie
add constraint valoare_cont check(valoare >= 0);


insert into sediu
values(1, 'Directia Generala Control Venituri Persoane Fizice', 'Bucuresti (sector 2)', 'Alee Cumidava', '022942');

insert into sediu
values(2, 'Administratia Judeteana a Finantelor Publice', 'Brasov', 'Bd. Mihail Kogalniceanu', '500090');

insert into sediu
values(3, 'Administratia Generala Regionala a Finantelor Publice', 'Cluj-Napoca', 'Dimitrie Cantemir', '410519');

insert into sediu
values(4, 'Administratia Judeteana a Finantelor Publice', 'Salaj', 'Iuliu Maniu', '450016');

insert into sediu
values(5, 'Administratia Judeteana a Finantelor Publice', 'Craiova', 'Mitropolit Firmilian', '200761');

insert into sediu
values(6, 'Serviciul Fiscal Municipal', 'Caracal', 'Toma Rusca', '235200');

insert into sediu
values(7, 'Administratia Judeteana a Finantelor Publice', 'Braila', 'Delfinului', '810210');

insert into sediu
values(8, 'Administratia Sectorului 1 a Finantelor Publice', 'Bucuresti (sector 1)', 'Soseaua Bucuresti-Ploiesti', '013682');

insert into sediu
values(9, 'Directia Regionala a Finantelor Publice', 'Ploiesti', 'Aurel Vlaicu', '100023');

insert into sediu
values(10, 'Serviciu Fiscal Municipal', 'Barlad', '1 Decembrie', '731182');

insert into adresa
values(1, 'Bucuresti', 'Gemeni', '013682');

insert into adresa
values(2, 'Bucuresti', 'Calea Floreasca', '013682');

insert into adresa
values(3, 'Cluj-Napoca', 'Constantin Brancoveanu', '423518');

insert into adresa
values(4, 'Brasov', 'Nicolae Balcescu', '500090');

insert into adresa
values(5, 'Craiova', 'Primaverii 31', '200761');

insert into adresa
values(6, 'Craiova', 'Crinului 12', '200861');

insert into adresa
values(7,'Cluj-Napoca', 'Livezii 18', '410529');

insert into adresa
values(8,'Ploiesti', 'Alexandru Vlahuta', '110023');

insert into adresa
values(9,'Barlad', 'Paloda', '731183');

insert into adresa
values(10,'Bucuresti', 'Mihai Viteazul 48', '013682');

insert into adresa
values(11,'Bucuresti', 'Democratiei 4', '013685');

insert into adresa
values(12,'Bucuresti', 'Pietei 99', '014582');

insert into adresa
values(13,'Bucuresti', 'Liveni 39', '017682');

insert into adresa
values(14,'Ploiesti', 'Lupeni 165', '113682');

insert into adresa
values(15,'Braila', '1 Decembrie 1918', '813452');

insert into adresa
values(16,'Salaj', 'Gheorghe Doja 159', '434480');

insert into adresa
values(17,'Brasov', '13 Decembrie', '513682');

insert into adresa
values(18,'Brasov', 'Dimitrie Anghel 21', '513652');

insert into adresa
values(19,'Craiova', 'Riului 429', '211112');

insert into adresa
values(20,'Craiova', 'Fratii Buzesti 39', '297200');

insert into persoana_juridica
values(23464239, 'J08/663/2008', 2, 'FEJER TOP SRL', '0756364784', 4);

insert into persoana_juridica
values(20742810, 'J40/1180/2007', 8, '	AZUR PROFESSIONAL CONSULT SRL','0725638940', 2);

insert into persoana_juridica
values(2835636, 'J40/24578/1992', 1, 'PRO TV SRL', '0250673905', 10);

insert into persoana_juridica
values(13949059, 'J12/837/2001', 3, 'SALOTI SRL', '0250673905', 3);

insert into persoana_juridica
values(20818331, 'J40/1592/2007', 8, 'SMARTON SRL', '0764563000', 1);

insert into persoana_juridica
values(18896214, 'J12/2607/2006', 3, 'TIPO OFFSET SRL', '0923563894', 7);

insert into persoana_juridica
values(15320143, 'J16/444/2003', 5, 'MISO SRL', '0745875030', 5);

insert into persoana_juridica
values(17399489, 'J16/666/2005', 5, 'BELLA DESIGN SRL', '0734675987', 6);

insert into persoana_juridica
values(14585843, 'J29/370/2002', 9, 'CATERCARM SRL', '0734674570', 8);

insert into persoana_juridica
values(6692717, 'J37/1100/1994', 10, 'SILVESROM SRL', '0234647876', 9);

insert into persoana_fizica
values(2526374892047,7,'Bicu','Aida','0765473894',15);

insert into persoana_fizica
values(2536474792081,4,'Cobzaru','Alina','0773490274',16);

insert into persoana_fizica
values(1745382947260,1,'Popescu','Sorin','0245739861',13);

insert into persoana_fizica
values(1526374892047,2,'Costea','Marian','0738452905',18);

insert into persoana_fizica
values(7263845104620,8,'Darie','Emanuel','0765473894',12);

insert into persoana_fizica
values(9253810462451,1,'Covaci','Hermina','0765778249',11);

insert into persoana_fizica
values(7341111185002,9,'Florea','Ionel','0345284517',14);

insert into persoana_fizica
values(1234567847916,2,'Lascu','Mihaela','0765123456',17);

insert into persoana_fizica
values(5152537489201,5,'Mihai','Catalin','0673527946',19);

insert into persoana_fizica
values(1213413245678,5,'Rab','Laura','0542743945',20);

insert into contributie
values(1,2526374892047,null,'Impozit locuinta',TO_DATE('01-02-2015','dd-mm-yyyy'),TO_DATE('01-06-2015','dd-mm-yyyy'),3000,null);

insert into contributie
values(2,null,2835636,'Radiere a societatii',TO_DATE('02-12-2014','dd-mm-yyyy'),TO_DATE('15-11-2014','dd-mm-yyyy'),1500000,30000);

insert into contributie
values(3,null,14585843,'Impozit sediu',TO_DATE('22-06-2018','dd-mm-yyyy'),TO_DATE('21-06-2018','dd-mm-yyyy'),50000,1000);

insert into contributie
values(4,null,2835636,'Impozit sediu',TO_DATE('01-02-2020','dd-mm-yyyy'),TO_DATE('01-03-2020','dd-mm-yyyy'),200000,null);

insert into contributie
values(5,1526374892047,null,'Amenda incalcarea legislatiei',TO_DATE('01-02-2019','dd-mm-yyyy'),TO_DATE('01-04-2019','dd-mm-yyyy'),10000,null);

insert into contributie
values(6,9253810462451,null,'Despagubiri',TO_DATE('01-02-2010','dd-mm-yyyy'),TO_DATE('03-11-2009','dd-mm-yyyy'),30000,5000);

insert into contributie
values(7,1526374892047,null,'Impozit automobil',TO_DATE('29-03-2020','dd-mm-yyyy'),TO_DATE('01-04-2020','dd-mm-yyyy'),2000,null);

insert into contributie
values(8,null,6692717,'Impozit sediu',TO_DATE('10-11-2019','dd-mm-yyyy'),TO_DATE('10-12-2019','dd-mm-yyyy'),8000,null);

insert into contributie
values(9,null,15320143,'Impozit sediu',TO_DATE('11-12-2019','dd-mm-yyyy'),TO_DATE('10-12-2019','dd-mm-yyyy'),5000,300);

insert into contributie
values(10,null,15320143,'Amenda nerespectarea legislatiei comertului',TO_DATE('02-03-2020','dd-mm-yyyy'),TO_DATE('02-02-2020','dd-mm-yyyy'),15400,4000);

insert into contributie
values(11,7341111185002,null,'Amenda incalcarea legislatiei',TO_DATE('15-06-2017','dd-mm-yyyy'),TO_DATE('23-06-2017','dd-mm-yyyy'),450,null);

insert into contributie
values(12,5152537489201,null,'Impozit automobil',TO_DATE('15-07-2011','dd-mm-yyyy'),TO_DATE('16-07-2011','dd-mm-yyyy'),1000,null);

insert into contributie
values(13,null,18896214,'Impozit sediu',TO_DATE('10-10-2010','dd-mm-yyyy'),TO_DATE('11-10-2010','dd-mm-yyyy'),10000,null);

insert into contributie
values(14,2526374892047,null,'Amenda nerespectarea drepturilor clientului',TO_DATE('14-08-2016','dd-mm-yyyy'),TO_DATE('14-07-2013','dd-mm-yyyy'),100000,50000);

insert into contributie
values(15,null,20742810,'Amenda nereguli',TO_DATE('12-04-2013','dd-mm-yyyy'),TO_DATE('20-05-2013','dd-mm-yyyy'),4000,null);

insert into tip
values(1,'Impozit automobil');

insert into tip
values(2,'Impozit imobiliar');

insert into tip
values(3,'Declaratie de avere');

insert into tip
values(4,'Declaratie de radiere pentru persoane juridice');

insert into tip
values(5,'Declaratie de recuperarei a sumei in valoare de 2% din tva');

insert into tip
values(6,'Declaratie privind contributia de asigurari sociale de sanatate');

insert into tip
values(7,'Declaratie privind decontul de taxa pe valoare adaugata');

insert into tip
values(8,'Declaratie privind indreptarea erorii la solutionarea cererii');

insert into tip
values(9,'Declaratie de ajustare a pro-ratei');

insert into tip
values(10,'Declaratie informativa privind veniturile obtinute');

insert into declaratie
values(1,1,1526374892047,null,TO_DATE('29-03-2020','dd-mm-yyyy'),TO_DATE('01-04-2020','dd-mm-yyyy'),null);

insert into declaratie
values(2,4,null,15320143,TO_DATE('28-07-2019','dd-mm-yyyy'),TO_DATE('25-07-2019','dd-mm-yyyy'),250);

insert into declaratie
values(3,9,null,2835636,TO_DATE('20-01-2015','dd-mm-yyyy'),TO_DATE('30-01-2015','dd-mm-yyyy'),null);

insert into declaratie
values(4,6,null,2835636,TO_DATE('22-03-2016','dd-mm-yyyy'),TO_DATE('30-03-2016','dd-mm-yyyy'),null);

insert into declaratie
values(5,2,5152537489201,null,TO_DATE('15-07-2011','dd-mm-yyyy'),TO_DATE('16-07-2011','dd-mm-yyyy'),null);

insert into declaratie
values(6,7,null,6692717,TO_DATE('12-07-2017','dd-mm-yyyy'),TO_DATE('16-07-2017','dd-mm-yyyy'),null);

insert into declaratie
values(7,1,1234567847916,null,TO_DATE('02-08-2014','dd-mm-yyyy'),TO_DATE('02-09-2014','dd-mm-yyyy'),null);

insert into declaratie
values(8,1,7341111185002,null,TO_DATE('15-05-2017','dd-mm-yyyy'),TO_DATE('23-05-2017','dd-mm-yyyy'),null);

insert into declaratie
values(9,6,9253810462451,null,TO_DATE('15-10-2016','dd-mm-yyyy'),TO_DATE('24-10-2016','dd-mm-yyyy'),100);

insert into declaratie
values(10,7,null,14585843,TO_DATE('11-04-2016','dd-mm-yyyy'),TO_DATE('11-05-2016','dd-mm-yyyy'),null);

insert into declaratie
values(11,2,1234567847916,null,TO_DATE('20-01-2015','dd-mm-yyyy'),TO_DATE('30-01-2015','dd-mm-yyyy'),null);

insert into declaratie
values(12,2,7341111185002,null,TO_DATE('23-10-2017','dd-mm-yyyy'),TO_DATE('22-10-2017','dd-mm-yyyy'),100);

commit;
