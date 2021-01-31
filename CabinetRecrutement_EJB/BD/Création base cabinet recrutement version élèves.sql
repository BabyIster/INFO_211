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

drop table if exists "message_offre_emploi";
drop table if exists "message_candidature";
drop table if exists "index_activite_candidature";
drop table if exists "index_qualification";
drop table if exists "index_activite";
drop table if exists "candidature";
drop table if exists "offre_emploi";
drop table if exists "entreprise";
drop table if exists "secteur_activite";
drop table if exists "qualification";

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

create table offre_emploi
(
  id              serial primary key,
  titre           varchar(50) not null,
  descriptif      text,
  profil_recherche		text,
  date_depot		date,
  id_entreprise   integer references entreprise
);

create table qualification
(
  id			serial primary key,
  intitule			varchar(50) not null
);

create table candidature
(
  id              serial primary key,
  nom			varchar(50) not null,
  prenom		varchar(50) not null,
  date_naissance	date,
  adresse_postale		varchar(30),
  adresse_email			varchar(50),
  cv				text,
  date_depot			date,
  id_qualification 	integer references qualification
);


create table message_offre_emploi
(
  id              serial primary key,
  date_envoi          date,
  corps_message     text,
  id_offre_emploi		integer references offre_emploi,
  id_candidature		integer references candidature
);

 create table message_candidature
(
  id              serial primary key,
  date_envoi           date,
  corps_message     text,
  id_offre_emploi		integer references offre_emploi,
  id_candidature		integer references candidature
);


create table secteur_activite
(
  id			serial primary key,
  intitule			varchar(50) not null
);

create table index_activite
(
  id_activite			integer references secteur_activite,
  id_offre_emploi			integer references offre_emploi
);

 create table index_qualification
(
  id_qualification 		integer references qualification,
  id_offre_emploi	integer references offre_emploi
);

 create table index_activite_candidature
(
  id_activite 		integer references secteur_activite,
  id_candidature	integer references candidature
);

-- +----------------------------------------------------------------------------------------------+
-- | Insertion de quelques données de pour les tests                                              |
-- +----------------------------------------------------------------------------------------------+

-- Insertion des entreprises

insert into entreprise values (nextval('entreprise_id_seq'),'IMT Atlantique','IMT Atlantique est une grande école pionnière en formation, en recherche et en entrepreneuriat et en tout plein de choses...','Plouzané');
insert into entreprise values (nextval('entreprise_id_seq'),'SQL inc','Entreprise spécialisé dans la mise en place de bdd','Plouzané');

-- Insertion des offres d'emploi

insert into offre_emploi values (nextval('offre_emploi_id_seq'),'Stage ingénieur database','Connaissance en SQL requise','Ingénieur avec dominance gestion de bdd','27/01/2021','2');

-- Insertion qualification

insert into qualification values (nextval('qualification_id_seq'),'Ingénieur junior');

-- Insertion d'une candidature

insert into candidature values (nextval('candidature_id_seq'),'Jean','Bon','17/08/1999','Plouzane','bon.jean@gmail.com','Chef de projet bdd','27/01/2021','1');

-- Insertion message offre d'emploi

insert into message_offre_emploi values (nextval('message_offre_emploi_id_seq'),'27/01/2020','Bien reçu','1','1');

-- Insertion message candidature

insert into message_candidature values (nextval('message_candidature_id_seq'),'27/01/2020','Votre offre m intérésse','1','1');

-- Insertion secteur activité

insert into secteur_activite values (nextval('secteur_activite_id_seq'),'BDD');

-- Insertion index activite

insert into index_activite values('1','1');

-- Insertion index qualification

insert into index_qualification values ('1','1');

-- Insertion index d'activite pour candidature

insert into index_activite_candidature values ('1','1');