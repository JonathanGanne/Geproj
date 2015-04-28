CREATE TABLE Employes (
	idEmploye INT PRIMARY KEY,
	nom VARCHAR2(50),
	prenom VARCHAR2(50),
	competences varchar(50),
	naissance date,
	salaire DECIMAL(7,2),
	heures_contrat FLOAT
);

CREATE SEQUENCE employe_seq;
CREATE OR REPLACE TRIGGER employe_trigg
BEFORE INSERT ON Employes FOR EACH ROW
BEGIN
	SELECT employe_seq.NEXTVAL
	INTO :new.idEmploye
	FROM DUAL;
END;
/

CREATE TABLE Projets (
	idProjet INT PRIMARY KEY,
	nom VARCHAR2(150),
	objectif CLOB,
	resultat CLOB,
	responsable INT,
	budget DECIMAL(12,2),
	FOREIGN KEY (responsable) REFERENCES Employes(idEmploye)
	);

CREATE SEQUENCE projet_seq;

CREATE OR REPLACE TRIGGER projet_trigg
BEFORE INSERT ON Projets FOR EACH ROW
BEGIN
	SELECT projet_seq.NEXTVAL
	INTO :new.idProjet
	FROM DUAL;
END;
/

CREATE TABLE Lots(
	idLot INT PRIMARY KEY,
	idProjet INT,
	nom VARCHAR2(150),
	responsable INT,
	budget DECIMAL(12,2),
	FOREIGN KEY (responsable) REFERENCES Employes(idEmploye),
	FOREIGN KEY (idProjet) REFERENCES Projets(idProjet)
);

CREATE SEQUENCE lot_seq;
CREATE OR REPLACE TRIGGER lot_trigg
BEFORE INSERT ON Lots FOR EACH ROW
BEGIN
	SELECT lot_seq.NEXTVAL
	INTO :new.idLot
	FROM DUAL;
END;
/

CREATE TABLE DependancesLots (
	idLot1 INT NOT NULL,
	idLot2 INT NOT NULL,
	PRIMARY KEY (idLot1, idLot2),
	FOREIGN KEY (idLot1) REFERENCES Lots(idLot),
	FOREIGN KEY (idLot1) REFERENCES Lots(idLot)
);

CREATE OR REPLACE TRIGGER antiCycleDependancesLots
BEFORE INSERT OR UPDATE ON DependancesLots FOR EACH ROW
DECLARE
	nb number;
BEGIN
	SELECT COUNT(*) INTO nb FROM DependancesLots WHERE idLot1 = :new.idLot2 AND idLot2 = :new.idLot1;
	IF(nb > 0) THEN raise_application_error(1045,'ERREUR DE BOUCLES');
	END IF;
END;
/

CREATE TABLE SousProjets(
	idSousProjet INT PRIMARY KEY,
	idLot INT NOT NULL,
	nom VARCHAR2(150),
	objectif CLOB,
	resultat CLOB,
	responsable INT,
	budget DECIMAL(12,2),
	FOREIGN KEY (responsable) REFERENCES Employes(idEmploye),
	FOREIGN KEY (idLot) REFERENCES Lots(idLot)
);

CREATE SEQUENCE sousprojet_seq;
CREATE OR REPLACE TRIGGER sousprojet_trigg
BEFORE INSERT ON SousProjets FOR EACH ROW
BEGIN
	SELECT sousprojet_seq.NEXTVAL
	INTO :new.idSousProjet
	FROM DUAL;
END;
/

CREATE TABLE DependancesSousProjets (
	idSousProjet1 INT NOT NULL,
	idSousProjet2 INT NOT NULL,
	PRIMARY KEY (idSousProjet1, idSousProjet2),
	FOREIGN KEY (idSousProjet1) REFERENCES SousProjets(idSousProjet),
	FOREIGN KEY (idSousProjet1) REFERENCES SousProjets(idSousProjet)
);

CREATE OR REPLACE TRIGGER antiCycleDependancesSousProjet
BEFORE INSERT OR UPDATE ON DependancesSousProjets FOR EACH ROW
DECLARE
	nb number;
BEGIN
	SELECT COUNT(*) INTO nb FROM DependancesSousProjets WHERE idSousProjet1 = :new.idSousProjet2 AND idSousProjet2 = :new.idSousProjet1;
	IF(nb > 0) THEN raise_application_error(1045,'ERREUR DE BOUCLES');
	END IF;
END;
/

CREATE TABLE Taches(
	idTache INT PRIMARY KEY,
	idSousProjet INT NOT NULL,
	nom VARCHAR2(150),
	Objectif CLOB,
	Resultat CLOB,
	Charge INT, /*en heurehommes */
	dteDebSooner date,
	dteDebLater date,
	dteFinSooner date,
	dteFinLater date,
	jourhomme INT,
	responsable INT,
	FOREIGN KEY (responsable) REFERENCES Employes(idEmploye),
	FOREIGN KEY (idSousProjet) REFERENCES SousProjets(idSousProjet)
);

CREATE SEQUENCE tache_seq;
CREATE OR REPLACE TRIGGER tache_trigg
BEFORE INSERT ON Taches FOR EACH ROW
BEGIN
	SELECT tache_seq.NEXTVAL
	INTO :new.idTache
	FROM DUAL;
END;
/

CREATE TABLE DependancesTaches (
	idTache1 INT NOT NULL,
	idTache2 INT NOT NULL,
	PRIMARY KEY (idTache1, idTache2),
	FOREIGN KEY (idTache1) REFERENCES Taches(idTache),
	FOREIGN KEY (idTache1) REFERENCES Taches(idTache)
);

CREATE OR REPLACE TRIGGER antiCycleDependancesTaches
BEFORE INSERT OR UPDATE ON DependancesTaches FOR EACH ROW
DECLARE
	nb number;
BEGIN
	SELECT COUNT(*) INTO nb FROM DependancesTaches WHERE idTache1 = :new.idTache2 AND idTache2 = :new.idTache1;
	IF(nb > 0) THEN raise_application_error(1045,'ERREUR DE BOUCLES');
	END IF;
END;
/

CREATE TABLE Jalons(
	idJalon INT PRIMARY KEY,
	idTache INT NOT NULL,
	nom VARCHAR2(150),
	phase VARCHAR2(30), /*Un nom pour la période précédente*/
	accompli CHAR(1 byte) DEFAULT 0,
	FOREIGN KEY (idTache) REFERENCES Taches(idTache)
);

CREATE SEQUENCE jalon_seq;
CREATE OR REPLACE TRIGGER jalon_trigg
BEFORE INSERT ON Jalons FOR EACH ROW
BEGIN
	SELECT jalon_seq.NEXTVAL
	INTO :new.idJalon
	FROM DUAL;
END;
/

CREATE TABLE Livrables(
	idLivrable INT PRIMARY KEY,
	idJalon INT NOT NULL,
	nom VARCHAR2(150),
	document BLOB,
	FOREIGN KEY (idJalon) REFERENCES Jalons(idJalon)
);

CREATE SEQUENCE livrable_seq;
CREATE OR REPLACE TRIGGER livrable_trigg
BEFORE INSERT ON Livrables FOR EACH ROW
BEGIN
	SELECT livrable_seq.NEXTVAL
	INTO :new.idLivrable
	FROM DUAL;
END;
/

CREATE TABLE RessourcesHumaines(
	idTache INT,
	idEmploye INT,
	PRIMARY KEY (idTache, idEmploye)
);