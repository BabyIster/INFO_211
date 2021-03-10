-- Titre :             Création base cabinet recrutement version élèves.sql
-- Version :           1.0
-- Date création :     28 juin 2011
-- Date modification : 26 janvier 2021
-- Auteur :            Florian GUILLOT & Matthieu LE JEUNE
-- Description :       Script de création de la base de données pour le SI "gestion de cabinet de
--                     recrutement"
--                     Note : script pour PostgreSQL
--                     Ebauche du script : ne contient pour le moment que la table "entreprise".

-- +----------------------------------------------------------------------------------------------+
-- | Suppression des tables                                                                       |
-- +----------------------------------------------------------------------------------------------+

drop table if exists "message_offre_emploi" CASCADE;
drop table if exists "message_candidature" CASCADE;
drop table if exists "index_activite_candidature" CASCADE;
drop table if exists "index_activite" CASCADE;
drop table if exists "candidature" CASCADE;
drop table if exists "offre_emploi" CASCADE;
drop table if exists "entreprise" CASCADE;
drop table if exists "secteur_activite" CASCADE;
drop table if exists "qualification" CASCADE;

-- +----------------------------------------------------------------------------------------------+
-- | Création des tables                                                                          |
-- +----------------------------------------------------------------------------------------------+

create table entreprise
(
  id              serial primary key,
  nom             varchar(50) not null,
  descriptif      text,
  adresse_postale varchar(30) -- Pour simplifier, adresse_postale = ville.
);

create table qualification
(
  id			serial primary key,
  intitule			varchar(50) not null
);

create table offre_emploi
(
  id              serial primary key,
  titre           varchar(50) not null,
  descriptif      text,
  profil_recherche		text,
  date_depot		date,
  id_qualification 		integer references qualification(id),
  id_entreprise   integer references entreprise(id)
);

create table candidature
(
  id              serial primary key,
  prenom		varchar(50) not null,
  nom			varchar(50) not null,
  date_naissance	date,
  adresse_postale		varchar(30),
  adresse_email			varchar(50),
  cv				text,
  date_depot			date,
  id_qualification 	integer references qualification(id)
);


create table message_offre_emploi
(
  id              serial primary key,
  date_envoi          date,
  corps_message     text,
  id_offre_emploi		integer references offre_emploi(id),
  id_candidature		integer references candidature(id)
);

 create table message_candidature
(
  id              serial primary key,
  date_envoi           date,
  corps_message     text,
  id_offre_emploi		integer references offre_emploi(id),
  id_candidature		integer references candidature(id)
);


create table secteur_activite
(
  id			serial primary key,
  intitule			varchar(50) not null
);

create table index_activite
(
  id_activite integer NOT NULL,
  id_offre_emploi integer NOT NULL,
  primary key (id_activite,id_offre_emploi),
  foreign key (id_offre_emploi) references offre_emploi(id),
  foreign key (id_activite) references secteur_activite(id)
);

 create table index_activite_candidature
(
  id_activite integer NOT NULL,
  id_candidature integer NOT NULL,
  primary key (id_activite,id_candidature),
  foreign key (id_candidature) references candidature(id),
  foreign key (id_activite) references secteur_activite(id)
);

-- +----------------------------------------------------------------------------------------------+
-- | Insertion de quelques données de pour les tests                                              |
-- +----------------------------------------------------------------------------------------------+

-- Insertion des entreprises

insert into entreprise values (nextval('entreprise_id_seq'),'IMT Atlantique','IMT Atlantique est une grande école pionnière en formation, en recherche et en entrepreneuriat et en tout plein de choses...','Plouzané');
insert into entreprise values (nextval('entreprise_id_seq'),'SQL inc','Entreprise spécialisé dans la mise en place de bdd','Plouzané');
insert into entreprise values (nextval('entreprise_id_seq'),'Ifremer','Entreprise de pêche','Brest');
insert into entreprise values (nextval('entreprise_id_seq'),'EDF','Entreprise de fabrication de tazer','Brest');
insert into entreprise values (nextval('entreprise_id_seq'),'Brasserie and co','Entreprise de fabrication de bière','Tregana');

-- Insertion qualification

insert into qualification values (nextval('qualification_id_seq'),'BAC');
insert into qualification values (nextval('qualification_id_seq'),'CAP/BEP');
insert into qualification values (nextval('qualification_id_seq'),'Bac+3');
insert into qualification values (nextval('qualification_id_seq'),'Bac+5');
insert into qualification values (nextval('qualification_id_seq'),'Doctorat');

-- Insertion des offres d'emploi

insert into offre_emploi values (nextval('offre_emploi_id_seq'),'Stage ingénieur database','Connaissance en SQL requise','Ingénieur avec dominance gestion de bdd','27/01/2021','1','2');
insert into offre_emploi values (nextval('offre_emploi_id_seq'),'Professeur','Pedagogie requise','Professeur spécialisé dans l informatique','29/01/2021','5','1');
insert into offre_emploi values (nextval('offre_emploi_id_seq'),'Pêcheur','Compétence en pêche requise','Pêcheur spécialisé dans les sous-marins','01/02/2021','1','3');
insert into offre_emploi values (nextval('offre_emploi_id_seq'),'Electricien','Compétence energie atomique requise','Ingénieur spécialisé en énergie','02/02/2021','3','4');
insert into offre_emploi values (nextval('offre_emploi_id_seq'),'Brasseur','Compétence brassage requise','Licence de brasseur spécialisé bière','05/02/2021','2','5');

-- Insertion d'une candidature

insert into candidature values (nextval('candidature_id_seq'),'Jean','Bon','17/08/1999','Plouzane','bon.jean@gmail.com','Chef de projet bdd','27/01/2021','3');
insert into candidature values (nextval('candidature_id_seq'),'Marc','Suin','17/08/1970','Brest','marc@suin.com','Professeur d info','29/01/2021','5');
insert into candidature values (nextval('candidature_id_seq'),'Sam','Fisher','17/08/1960','Brest','sam@wanadoo.com','Pecheur amateur','01/02/2021','1');
insert into candidature values (nextval('candidature_id_seq'),'Arnold','Watt','17/08/1980','Brest','watt@wanadoo.com','Pilote de projet energie','03/02/2021','3');
insert into candidature values (nextval('candidature_id_seq'),'Clément','Drunk','17/08/1990','Brest','drunk@wanadoo.com','Chef d équipe brassage','03/02/2021','2');

-- Insertion message offre d'emploi

insert into message_offre_emploi values (nextval('message_offre_emploi_id_seq'),'27/01/2020','Votre candidature nous intérésse','1','1');
insert into message_offre_emploi values (nextval('message_offre_emploi_id_seq'),'29/01/2020','Nous nous avons envoyé une convocation par mail','2','2');
insert into message_offre_emploi values (nextval('message_offre_emploi_id_seq'),'01/01/2020','Désolé nous ne prennons pas d amateur','3','3');
insert into message_offre_emploi values (nextval('message_offre_emploi_id_seq'),'04/02/2020','Pouvez-nous convenir d un entretien ?','4','4');
insert into message_offre_emploi values (nextval('message_offre_emploi_id_seq'),'06/02/2020','Rendez-vous au bar','5','5');

-- Insertion message candidature

insert into message_candidature values (nextval('message_candidature_id_seq'),'28/01/2020','Votre offre m intérésse','1','1');
insert into message_candidature values (nextval('message_candidature_id_seq'),'30/01/2020','Bien reçu','2','2');
insert into message_candidature values (nextval('message_candidature_id_seq'),'05/02/2020','Je suis disponible mardi','4','4');
insert into message_candidature values (nextval('message_candidature_id_seq'),'07/02/2020','OK','5','5');

-- Insertion secteur activité

insert into secteur_activite values (nextval('secteur_activite_id_seq'),'Informatique');
insert into secteur_activite values (nextval('secteur_activite_id_seq'),'Environnement');
insert into secteur_activite values (nextval('secteur_activite_id_seq'),'Industrie/Ingénierie/Production');
insert into secteur_activite values (nextval('secteur_activite_id_seq'),'Achats/Logistique');
insert into secteur_activite values (nextval('secteur_activite_id_seq'),'Formation/Enseignement');

-- Insertion index activite

insert into index_activite values('1','1');
insert into index_activite values('2','5');
insert into index_activite values('3','2');
insert into index_activite values('4','3');
insert into index_activite values('5','4');

-- Insertion index d'activite pour candidature

insert into index_activite_candidature values ('1','1');
insert into index_activite_candidature values ('2','5');
insert into index_activite_candidature values ('3','2');
insert into index_activite_candidature values ('4','3');
insert into index_activite_candidature values ('5','4');
