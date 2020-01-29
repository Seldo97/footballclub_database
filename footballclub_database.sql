--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
--------------TABELE--------------
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-- 

-------TWORZENIE TABEL------


CREATE TABLE dbo.Druzyna(
	id_druzyna int NOT NULL,
	nazwa varchar(50) NOT NULL,
	druzyna_nasza bit NOT NULL,
	id_liga int NOT NULL,
	--PRIMARY KEY (id_druzyna)
	);
GO
CREATE TABLE dbo.Liga(
	id_liga int NOT NULL,
	nazwa varchar(50) NOT NULL,
	--PRIMARY KEY (id_liga)
	);
GO
CREATE TABLE dbo.Zawodnik(
	id_zawodnik int NOT NULL,
	imie varchar(50) NOT NULL,
	drugie_imie varchar(50) NULL,
	nazwisko varchar(50) NOT NULL,
	data_urodzenia date NOT NULL,
	wzrost varchar(10) NOT NULL,
	waga varchar(10) NOT NULL,
	lepsza_noga varchar(10) NULL,
	narodowosc varchar(50) NOT NULL,
	do_kiedy_kontrakt date NOT NULL,
	pensja money NOT NULL,
	id_druzyna int NOT NULL,
	id_pozycja int NULL
	--PRIMARY KEY (id_zawodnik)
	);
GO

CREATE TABLE dbo.Pozycja
	(
	id_pozycja int NOT NULL,
	pozycja varchar(50) NOT NULL
	);
GO

CREATE TABLE dbo.Stadion(
	id_stadion int NOT NULL,
	nazwa varchar(50) NOT NULL,
	typ_murawy varchar(50) NOT NULL,
	pelnowymiarowe bit NOT NULL,
	miasto varchar(50) NOT NULL,
	ulica varchar(50) NOT NULL
);
GO

CREATE TABLE dbo.Trening(
	id_trening int NOT NULL IDENTITY (1, 1),
	data date NOT NULL,
	godzina varchar(5) NOT NULL,
	id_druzyna int NOT NULL,
	id_stadion int NOT NULL
);
GO

CREATE TABLE dbo.Trener(
	id_trener int NOT NULL,
	imie varchar(50) NOT NULL,
	drugie_imie varchar(50) NULL,
	nazwisko varchar(50) NOT NULL,
	data_urodzenia date NOT NULL,
	narodowosc varchar(50) NULL,
	do_kiedy_kontrakt date NOT NULL,
	pensja money NOT NULL
);
GO

CREATE TABLE dbo.Stanowisko(
	id_stanowisko int NOT NULL,
	stanowisko varchar(50) NOT NULL
);
GO

CREATE TABLE dbo.Druzyna_Trener(
	id_druzyna_trener int NOT NULL IDENTITY (1, 1),
	id_druzyna int NOT NULL,
	id_trener int NOT NULL,
	id_stanowisko int NOT NULL,
	uwagi varchar(100) NULL
);
GO

CREATE TABLE dbo.Mecz(
	id_mecz int NOT NULL,
	data date NOT NULL,
	godzina varchar(5) NOT NULL,
	id_druzyna_nasza int NOT NULL,
	id_druzyna_przeciwna int NOT NULL,
	bramki_nasze int NULL,
	bramki_przeciwnika int NULL,
	id_stadion int NOT NULL
);
GO

CREATE TABLE dbo.Zawodnik_Mecz(
	id_zawodnik_mecz int NOT NULL IDENTITY (1, 1),
	id_zawodnik int NOT NULL,
	id_mecz int NOT NULL,
	id_pozycja int NOT NULL,
	bramki int NULL,
	kartki_zolte int NULL,
	kartki_czerwone int NULL
);
GO
-------KLUCZE G£ÓWNE-------

ALTER TABLE dbo.Druzyna
ADD CONSTRAINT PK_Druzyna
PRIMARY KEY (id_druzyna);
GO

ALTER TABLE dbo.Liga
ADD CONSTRAINT PK_Liga
PRIMARY KEY (id_liga);
GO

ALTER TABLE dbo.Zawodnik
ADD CONSTRAINT PK_Zawodnik
PRIMARY KEY (id_zawodnik);
GO

ALTER TABLE dbo.Pozycja
ADD CONSTRAINT PK_Pozycja
PRIMARY KEY (id_pozycja);
GO

ALTER TABLE dbo.Stadion
ADD CONSTRAINT PK_Stadion
PRIMARY KEY (id_stadion);
GO

ALTER TABLE dbo.Trening
ADD CONSTRAINT PK_Trening
PRIMARY KEY (id_trening);
GO

ALTER TABLE dbo.Trener
ADD CONSTRAINT PK_Trener
PRIMARY KEY (id_trener);
GO

ALTER TABLE dbo.Stanowisko
ADD CONSTRAINT PK_Stanowisko
PRIMARY KEY (id_stanowisko);
GO

ALTER TABLE dbo.Druzyna_Trener
ADD CONSTRAINT PK_Druzyna_Trener
PRIMARY KEY (id_druzyna_trener);
GO

ALTER TABLE dbo.Mecz
ADD CONSTRAINT PK_Mecz
PRIMARY KEY (id_mecz);
GO

ALTER TABLE dbo.Zawodnik_Mecz
ADD CONSTRAINT PK_Zawodnik_Mecz
PRIMARY KEY (id_zawodnik_mecz);
GO

---------KLUCZE OBCE------

ALTER TABLE dbo.Druzyna
ADD CONSTRAINT FK_DruzynaLiga
FOREIGN KEY (id_liga) REFERENCES dbo.Liga(id_liga)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Zawodnik
ADD CONSTRAINT FK_ZawodnikDruzyna
FOREIGN KEY (id_druzyna) REFERENCES dbo.Druzyna(id_druzyna)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Zawodnik
ADD CONSTRAINT FK_ZawodnikPozycja
FOREIGN KEY (id_pozycja) REFERENCES dbo.Pozycja(id_pozycja);
GO

ALTER TABLE dbo.Trening
ADD CONSTRAINT FK_TreningStadion
FOREIGN KEY (id_stadion) REFERENCES dbo.Stadion(id_stadion)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Trening
ADD CONSTRAINT FK_TreningDruzyna
FOREIGN KEY (id_druzyna) REFERENCES dbo.Druzyna(id_druzyna)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Druzyna_Trener
ADD CONSTRAINT FK_DruzynaTrener_druzyna
FOREIGN KEY (id_druzyna) REFERENCES dbo.Druzyna(id_druzyna)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Druzyna_Trener
ADD CONSTRAINT FK_DruzynaTrener_trener
FOREIGN KEY (id_trener) REFERENCES dbo.Trener(id_trener)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Druzyna_Trener
ADD CONSTRAINT FK_DruzynaTrener_stanowisko
FOREIGN KEY (id_stanowisko) REFERENCES dbo.Stanowisko(id_stanowisko)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Mecz
ADD CONSTRAINT FK_MeczDruzynaNasza
FOREIGN KEY (id_druzyna_nasza) REFERENCES dbo.Druzyna(id_druzyna)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Mecz
ADD CONSTRAINT FK_MeczDruzynaPrzeciwna
FOREIGN KEY (id_druzyna_przeciwna) REFERENCES dbo.Druzyna(id_druzyna);
GO

ALTER TABLE dbo.Mecz
ADD CONSTRAINT FK_MeczStadion
FOREIGN KEY (id_stadion) REFERENCES dbo.Stadion(id_stadion)
ON UPDATE CASCADE;
GO

ALTER TABLE dbo.Zawodnik_Mecz
ADD CONSTRAINT FK_ZawodnikMecz_zawodnik
FOREIGN KEY (id_zawodnik) REFERENCES dbo.Zawodnik(id_zawodnik)
ON UPDATE CASCADE
ON DELETE CASCADE;
GO

ALTER TABLE dbo.Zawodnik_Mecz
ADD CONSTRAINT FK_ZawodnikMecz_mecz
FOREIGN KEY (id_mecz) REFERENCES dbo.Mecz(id_mecz);
GO

ALTER TABLE dbo.Zawodnik_Mecz
ADD CONSTRAINT FK_ZawodnikMecz_pozycja
FOREIGN KEY (id_pozycja) REFERENCES dbo.Pozycja(id_pozycja);
GO

--------WALIDACJA--------

 ALTER TABLE dbo.Zawodnik
 ADD CONSTRAINT CK_Kontrakt_Data
 CHECK (do_kiedy_kontrakt >= GETDATE());
 GO

 ALTER TABLE dbo.Trening
 ADD CONSTRAINT CK_Data_Treningu
 CHECK (data >= GETDATE());
 GO

 ALTER TABLE dbo.Trening
 ADD CONSTRAINT CK_Godzina_Treningu
 CHECK (godzina LIKE '[0-9][0-9][:][0-9][0-9]');
 GO

 ALTER TABLE dbo.Mecz
 ADD CONSTRAINT CK_Godzina_Meczu
 CHECK (godzina LIKE '[0-9][0-9][:][0-9][0-9]');
 GO

 ALTER TABLE dbo.Mecz
 ADD CONSTRAINT CK_Bramki_Nasze
 CHECK (bramki_nasze >= 0);
 GO

 ALTER TABLE dbo.Mecz
 ADD CONSTRAINT CK_Bramki_Przeciwnika
 CHECK (bramki_przeciwnika >= 0);
 GO

 ALTER TABLE dbo.Mecz
 ADD CONSTRAINT CK_Druzyny_w_meczu
 CHECK (id_druzyna_przeciwna != id_druzyna_nasza);
 GO

 ALTER TABLE dbo.Trener
 ADD CONSTRAINT CK_Trener_Kontrakt_Data
 CHECK (do_kiedy_kontrakt >= GETDATE());
 GO

 -------WARTOŒCI UNIQUE--------

 ALTER TABLE dbo.Liga
 ADD CONSTRAINT UN_NazwaLigi
 UNIQUE (nazwa);
 GO

 ALTER TABLE dbo.Pozycja
 ADD CONSTRAINT UN_pozycja
 UNIQUE (pozycja);
 GO


 ALTER TABLE dbo.Stanowisko
 ADD CONSTRAINT UN_stanowisko
 UNIQUE (stanowisko);
 GO

 --------WARTOŒCI DEFAULT---------

 ALTER TABLE dbo.Druzyna
 ADD CONSTRAINT DF_Druzyna_Nasza
 DEFAULT (1) FOR druzyna_nasza;
 GO

 ALTER TABLE dbo.Zawodnik
 ADD CONSTRAINT DF_Kontrakt_DF
 DEFAULT (DATEADD(year, 5, GETDATE())) FOR do_kiedy_kontrakt;
 GO

 ALTER TABLE dbo.Zawodnik
 ADD CONSTRAINT DF_Zawodnik_noga
 DEFAULT 'prawa' FOR lepsza_noga;
 GO

 ALTER TABLE dbo.Trener
 ADD CONSTRAINT DF_Kontrakt_Trener
 DEFAULT (DATEADD(year, 2, GETDATE())) FOR do_kiedy_kontrakt;
 GO



--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
--------------PROCEDURY--------------
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
--LIGA-------------------------########
--insert--
CREATE PROCEDURE dbo.Liga_wstaw
@Par_id_liga int,
@Par_nazwa varchar(50)
AS
BEGIN
	INSERT dbo.Liga
	(id_liga, nazwa)
	VALUES
	(@Par_id_liga, @Par_nazwa)
END;
GO

--update--
CREATE PROCEDURE dbo.Liga_update
@Par_id_liga int,
@Par_nazwa varchar(50)
AS
BEGIN
	UPDATE dbo.Liga
	SET 
		nazwa = @Par_nazwa
	WHERE id_liga = @Par_id_liga;
END;
GO

--delete--
CREATE PROCEDURE dbo.Liga_usun
@Par_id_liga int
AS
BEGIN
	DELETE dbo.Liga
	WHERE id_liga = @Par_id_liga;
END;
GO
-------------------------------------########
--DRUŻYNA----------------------------########
--insert--
CREATE PROCEDURE dbo.Druzyna_wstaw
@Par_id_Druzyna int,
@Par_nazwa varchar(50),
@Par_druzyna_nasza bit,
@Par_id_liga int
AS
BEGIN
	INSERT dbo.Druzyna(id_druzyna, nazwa, druzyna_nasza, id_liga)
	VALUES (@Par_id_Druzyna, @Par_nazwa, @Par_druzyna_nasza, @Par_id_liga);
END;
GO

--update--
CREATE PROCEDURE dbo.Druzyna_update
@Par_id_Druzyna int,
@Par_nazwa varchar(50),
@Par_druzyna_nasza bit,
@Par_id_liga int
AS
BEGIN
	UPDATE dbo.Druzyna
	SET 
		nazwa = @Par_nazwa,
		druzyna_nasza = @Par_druzyna_nasza,
		id_liga = @Par_id_liga
	WHERE id_druzyna = @Par_id_Druzyna;
END;
GO

--delete--
CREATE PROCEDURE dbo.Druzyna_usun
@Par_id_Druzyna int
AS
BEGIN
	DELETE dbo.Druzyna
	WHERE id_druzyna = @Par_id_Druzyna;
END;
GO
---------------------------------------########
--POZYCJA------------------------------########
--insert--
CREATE PROCEDURE dbo.Pozycja_wstaw
@Par_id_pozycja int,
@Par_pozycja varchar(50)
AS
BEGIN
	INSERT dbo.Pozycja
	(id_pozycja, pozycja)
	VALUES
	(@Par_id_pozycja, @Par_pozycja)
END;
GO

--update--
CREATE PROCEDURE dbo.Pozycja_update
@Par_id_pozycja int,
@Par_pozycja varchar(50)
AS
BEGIN
	UPDATE dbo.Pozycja
	SET 
		pozycja = @Par_pozycja
	WHERE id_pozycja = @Par_id_pozycja;
END;
GO

--delete--
CREATE PROCEDURE dbo.Pozycja_usun
@Par_id_pozycja int
AS
BEGIN
	DELETE dbo.Pozycja
	WHERE id_pozycja = @Par_id_pozycja;
END;
GO
-----------------------------------------########
--STANOWISKO-----------------------------########
--insert--
CREATE PROCEDURE dbo.Stanowisko_wstaw
@Par_id_stanowisko int,
@Par_stanowisko varchar(50)
AS
BEGIN
	INSERT dbo.Stanowisko
	(id_stanowisko, stanowisko)
	VALUES
	(@Par_id_stanowisko, @Par_stanowisko)
END;
GO

--update--
CREATE PROCEDURE dbo.Stanowisko_update
@Par_id_stanowisko int,
@Par_stanowisko varchar(50)
AS
BEGIN
	UPDATE dbo.Stanowisko
	SET 
		stanowisko = @Par_stanowisko
	WHERE id_stanowisko = @Par_id_stanowisko;
END;
GO

--delete--
CREATE PROCEDURE dbo.Stanowisko_usun
@Par_id_stanowisko int
AS
BEGIN
	DELETE dbo.Stanowisko
	WHERE id_stanowisko = @Par_id_stanowisko;
END;
GO
------------------------------------########
--TRENER----------------------------########
--insert--
CREATE PROCEDURE dbo.Trener_wstaw
@Par_id_trener int,
@Par_imie varchar(50),
@Par_drugie_imie varchar(50),
@Par_nazwisko varchar(50),
@Par_data_urodzenia date,
@Par_narodowosc varchar(50),
@Par_do_kiedy_kontrakt date,
@Par_pensja money
AS
BEGIN
	INSERT dbo.Trener(id_trener, imie, drugie_imie, nazwisko, data_urodzenia, narodowosc, do_kiedy_kontrakt, pensja)
	VALUES (@Par_id_trener, @Par_imie, @Par_drugie_imie, @Par_nazwisko, @Par_data_urodzenia, @Par_narodowosc, @Par_do_kiedy_kontrakt, @Par_pensja);
END;
GO

--update--
CREATE PROCEDURE dbo.Trener_update
@Par_id_trener int,
@Par_imie varchar(50),
@Par_drugie_imie varchar(50),
@Par_nazwisko varchar(50),
@Par_data_urodzenia date,
@Par_narodowosc varchar(50),
@Par_do_kiedy_kontrakt date,
@Par_pensja money
AS
BEGIN
	UPDATE dbo.Trener
	SET 
		imie = @Par_imie,
		drugie_imie = @Par_drugie_imie,
		nazwisko = @Par_nazwisko,
		data_urodzenia = @Par_data_urodzenia,
		narodowosc = @Par_narodowosc,
		do_kiedy_kontrakt = @Par_do_kiedy_kontrakt,
		pensja = @Par_pensja


	WHERE id_trener = @Par_id_trener;
END;
GO

--delete--
CREATE PROCEDURE dbo.Trener_usun
@Par_id_trener int
AS
BEGIN
	DELETE dbo.Trener
	WHERE id_trener = @Par_id_trener;
END;
GO
--------------------------------------########
--DRUZYNA_TRENER----------------------########
--insert--
CREATE PROCEDURE dbo.Druzyna_Trener_wstaw
--@Par_id_druzyna_trener int,
@Par_id_druzyna int,
@Par_id_trener int,
@Par_id_stanowisko int,
@Par_uwagi varchar(100)
AS
BEGIN
	INSERT dbo.Druzyna_Trener(id_druzyna, id_trener, id_stanowisko, uwagi)
	VALUES (@Par_id_druzyna, @Par_id_trener, @Par_id_stanowisko, @Par_uwagi);
END;
GO

--update--
CREATE PROCEDURE dbo.Druzyna_Trener_update
@Par_id_druzyna_trener int,
@Par_id_druzyna int,
@Par_id_trener int,
@Par_id_stanowisko int,
@Par_uwagi varchar(100)
AS
BEGIN
	UPDATE dbo.Druzyna_Trener
	SET 
		id_druzyna = @Par_id_druzyna,
		id_trener = @Par_id_trener,
		id_stanowisko = @Par_id_stanowisko,
		uwagi = @Par_uwagi

	WHERE id_druzyna_trener = @Par_id_druzyna_trener;
END;
GO

--delete--
CREATE PROCEDURE dbo.Druzyna_Trener_usun
@Par_id_druzyna_trener int
AS
BEGIN
	DELETE dbo.Druzyna_Trener
	WHERE id_druzyna_trener = @Par_id_druzyna_trener;
END;
GO
--------------------------------------########
--ZAWODNIK----------------------------########
--insert--
CREATE PROCEDURE dbo.Zawodnik_wstaw
@Par_id_zawodnik int,
@Par_imie varchar(50),
@Par_drugie_imie varchar(50),
@Par_nazwisko varchar(50),
@Par_data_urodzenia date,
@Par_wzrost varchar(50),
@Par_waga varchar(50),
@Par_lepsza_noga varchar(50),
@Par_narodowosc varchar(50),
@Par_do_kiedy_kontrakt date,
@Par_pensja money,
@Par_id_druzyna int,
@Par_id_pozycja int
AS
BEGIN
	INSERT dbo.Zawodnik(id_zawodnik, imie, drugie_imie, nazwisko, data_urodzenia, wzrost, waga, lepsza_noga, narodowosc, do_kiedy_kontrakt, pensja, id_druzyna, id_pozycja)
	VALUES (@Par_id_zawodnik, @Par_imie, @Par_drugie_imie, @Par_nazwisko, @Par_data_urodzenia, @Par_wzrost, @Par_waga, @Par_lepsza_noga, @Par_narodowosc, @Par_do_kiedy_kontrakt, @Par_pensja, @Par_id_druzyna, @Par_id_pozycja);
END;
GO

--update--
CREATE PROCEDURE dbo.Zawodnik_update
@Par_id_zawodnik int,
@Par_imie varchar(50),
@Par_drugie_imie varchar(50),
@Par_nazwisko varchar(50),
@Par_data_urodzenia date,
@Par_wzrost varchar(50),
@Par_waga varchar(50),
@Par_lepsza_noga varchar(50),
@Par_narodowosc varchar(50),
@Par_do_kiedy_kontrakt date,
@Par_pensja money,
@Par_id_druzyna int,
@Par_id_pozycja int
AS
BEGIN
	UPDATE dbo.Zawodnik
	SET 
		imie = @Par_imie,
		drugie_imie = @Par_drugie_imie,
		nazwisko = @Par_nazwisko,
		data_urodzenia = @Par_data_urodzenia,
		wzrost = @Par_wzrost,
		waga = @Par_waga,
		lepsza_noga = @Par_lepsza_noga,
		narodowosc = @Par_narodowosc,
		do_kiedy_kontrakt = @Par_do_kiedy_kontrakt,
		pensja = @Par_pensja,
		id_druzyna = @Par_id_druzyna,
		id_pozycja = @Par_id_pozycja
	
	WHERE id_zawodnik = @Par_id_zawodnik;
END;
GO

--delete--
CREATE PROCEDURE dbo.Zawodnik_usun
@Par_id_zawodnik int
AS
BEGIN
	DELETE dbo.Zawodnik
	WHERE id_zawodnik = @Par_id_zawodnik;
END;
GO
---------------------------------------########
--STADION------------------------------########
--insert--
CREATE PROCEDURE dbo.Stadion_wstaw
@Par_id_stadion int,
@Par_nazwa varchar(50),
@Par_typ_murawy varchar(50),
@Par_pelnowymiarowe bit,
@Par_miasto varchar(50),
@Par_ulica varchar(50)
AS
BEGIN
	INSERT dbo.Stadion(id_stadion, nazwa, typ_murawy, pelnowymiarowe, miasto, ulica)
	VALUES (@Par_id_stadion, @Par_nazwa, @Par_typ_murawy, @Par_pelnowymiarowe, @Par_miasto, @Par_ulica);
END;
GO

--update--
CREATE PROCEDURE dbo.Stadion_update
@Par_id_stadion int,
@Par_nazwa varchar(50),
@Par_typ_murawy varchar(50),
@Par_pelnowymiarowe bit,
@Par_miasto varchar(50),
@Par_ulica varchar(50)
AS
BEGIN
	UPDATE dbo.Stadion
	SET 
		nazwa = @Par_nazwa,
		typ_murawy = @Par_typ_murawy,
		pelnowymiarowe = @Par_pelnowymiarowe,
		miasto = @Par_miasto,
		ulica = @Par_ulica
	WHERE id_stadion = @Par_id_stadion;
END;
GO

--delete--
CREATE PROCEDURE dbo.Stadion_usun
@Par_id_stadion int
AS
BEGIN
	DELETE dbo.Stadion
	WHERE id_stadion = @Par_id_stadion;
END;
GO
---------------------------------------########
--TRENING------------------------------########
--insert--
CREATE PROCEDURE dbo.Trening_wstaw
--@Par_id_trening int,
@Par_data date,
@Par_godzina varchar(5),
@Par_id_druzyna int,
@Par_id_stadion int
AS
BEGIN
	INSERT dbo.Trening(data, godzina, id_druzyna, id_stadion)
	VALUES (@Par_data, @Par_godzina, @Par_id_druzyna, @Par_id_stadion);
END;
GO

--update--
CREATE PROCEDURE dbo.Trening_update
@Par_id_trening int,
@Par_data date,
@Par_godzina varchar(5),
@Par_id_druzyna int,
@Par_id_stadion int
AS
BEGIN
	UPDATE dbo.Trening
	SET 
		data = @Par_data,
		godzina = @Par_godzina,
		id_druzyna = @Par_id_druzyna,
		id_stadion = @Par_id_stadion
	WHERE id_trening = @Par_id_trening;
END;
GO

--delete--
CREATE PROCEDURE dbo.Trening_usun
@Par_id_trening int
AS
BEGIN
	DELETE dbo.Trening
	WHERE id_trening = @Par_id_trening;
END;
GO
---------------------------------------########
--MECZ------------------------------########
--insert--
CREATE PROCEDURE dbo.Mecz_wstaw
@Par_id_mecz int,
@Par_data date,
@Par_godzina varchar(5),
@Par_id_druzyna_nasza int,
@Par_id_druzyna_przeciwna int,
@Par_id_bramki_nasze int,
@Par_id_bramki_przeciwnika int,
@Par_id_stadion int
AS
BEGIN
	INSERT dbo.Mecz(id_mecz, data, godzina, id_druzyna_nasza, id_druzyna_przeciwna, bramki_nasze, bramki_przeciwnika, id_stadion)
	VALUES (@Par_id_mecz, @Par_data, @Par_godzina, @Par_id_druzyna_nasza, @Par_id_druzyna_przeciwna, @Par_id_bramki_nasze, @Par_id_bramki_przeciwnika, @Par_id_stadion);
END;
GO


--update--
CREATE PROCEDURE dbo.Mecz_update
@Par_id_mecz int,
@Par_data date,
@Par_godzina varchar(5),
@Par_id_druzyna_nasza int,
@Par_id_druzyna_przeciwna int,
@Par_id_bramki_nasze int,
@Par_id_bramki_przeciwnika int,
@Par_id_stadion int
AS
BEGIN
	UPDATE dbo.Mecz
	SET 
		data = @Par_data,
		godzina = @Par_godzina,
		id_druzyna_nasza = @Par_id_druzyna_nasza,
		id_druzyna_przeciwna = @Par_id_druzyna_przeciwna,
		bramki_nasze = @Par_id_bramki_nasze,
		bramki_przeciwnika = @Par_id_bramki_przeciwnika,
		id_stadion = @Par_id_stadion
	WHERE id_mecz = @Par_id_mecz;
END;
GO

--delete--
CREATE PROCEDURE dbo.Mecz_usun
@Par_id_mecz int
AS
BEGIN
	DELETE dbo.Mecz
	WHERE id_mecz = @Par_id_mecz;
END;
GO
---------------------------------------########
--ZAWODNIK_MECZ-------------------------########
--insert--
CREATE PROCEDURE dbo.Zawodnik_Mecz_wstaw
--@Par_id_zawodnik_mecz int,
@Par_id_zawodnik int,
@Par_id_mecz int,
@Par_id_pozycja int,
@Par_bramki int,
@Par_kartki_zolte int,
@Par_kartki_czerwone int
AS
BEGIN
	INSERT dbo.Zawodnik_Mecz(id_zawodnik, id_mecz, id_pozycja, bramki, kartki_zolte, kartki_czerwone)
	VALUES ( @Par_id_zawodnik, @Par_id_mecz, @Par_id_pozycja, @Par_bramki, @Par_kartki_zolte, @Par_kartki_czerwone);
END;
GO

--update--
CREATE PROCEDURE dbo.Zawodnik_Mecz_update
@Par_id_zawodnik_mecz int,
@Par_id_zawodnik int,
@Par_id_mecz int,
@Par_id_pozycja int,
@Par_bramki int,
@Par_kartki_zolte int,
@Par_kartki_czerwone int
AS
BEGIN
	UPDATE dbo.Zawodnik_Mecz
	SET 
		id_zawodnik = @Par_id_zawodnik,
		id_mecz = @Par_id_mecz,
		id_pozycja = @Par_id_pozycja,
		bramki = @Par_bramki,
		kartki_zolte = @Par_kartki_zolte,
		kartki_czerwone = @Par_kartki_czerwone
	WHERE id_zawodnik_mecz = @Par_id_zawodnik_mecz;
END;
GO

--delete--
CREATE PROCEDURE dbo.Zawodnik_Mecz_usun
@Par_id_zawodnik_mecz int
AS
BEGIN
	DELETE dbo.Zawodnik_Mecz
	WHERE id_zawodnik_mecz = @Par_id_zawodnik_mecz;
END;
GO
---------------------------------------########

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--
---------------EXECUTE---------------
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--

--------------WSTAWIANIE--------------------
--LIGA--------------------------------------
EXECUTE dbo.Liga_wstaw 1, 'Ekstraklasa'; 
GO
EXECUTE dbo.Liga_wstaw 2, '1-Liga'; 
GO
EXECUTE dbo.Liga_wstaw 3, '2-Liga'; 
GO
EXECUTE dbo.Liga_wstaw 4, '3-Liga'; 
GO
EXECUTE dbo.Liga_wstaw 5, '4-Liga'; 
GO
EXECUTE dbo.Liga_wstaw 6, '8 liga mistrzów'; 
GO
---------------------------------------------
--DRUŻYNA------------------------------------
EXECUTE dbo.Druzyna_wstaw 1, 'Calisia Kalisz', 1, 1;
GO
EXECUTE dbo.Druzyna_wstaw 2, 'Calisia Kalisz Kadra B', 1, 2;
GO
EXECUTE dbo.Druzyna_wstaw 3, 'Prosna Kalisz', 1, 3;
GO
EXECUTE dbo.Druzyna_wstaw 4, 'KKS Galeria Amber', 1, 4;
GO
EXECUTE dbo.Druzyna_wstaw 5, 'FC PoNalewce', 1, 5;
GO
EXECUTE dbo.Druzyna_wstaw 6, 'TP Ostrovia 1909', 0, 1;
GO
EXECUTE dbo.Druzyna_wstaw 7, 'Centra Ostrów', 0, 2;
GO
EXECUTE dbo.Druzyna_wstaw 8, 'KKS Galeria Ostrovia', 0, 3;
GO
EXECUTE dbo.Druzyna_wstaw 9, 'Juventus Ostrów WLKP', 0, 4;
GO
EXECUTE dbo.Druzyna_wstaw 10, 'Piast Czekanów', 0, 5;
GO
EXECUTE dbo.Druzyna_wstaw 11, 'Amica Wronki', 0, 6;
GO
-----------------------------------------------
--POZYCJA--------------------------------------
EXECUTE dbo.Pozycja_wstaw 1, 'Bramkarz';
GO
EXECUTE dbo.Pozycja_wstaw 2, 'Stoper';
GO
EXECUTE dbo.Pozycja_wstaw 3, 'Prawy Obrońca';
GO
EXECUTE dbo.Pozycja_wstaw 4, 'Lewy Obrońca';
GO
EXECUTE dbo.Pozycja_wstaw 5, 'Pomocnik Ofensywny';
GO
EXECUTE dbo.Pozycja_wstaw 6, 'Pomocnik Defensywny';
GO
EXECUTE dbo.Pozycja_wstaw 7, 'Prawo Skrzydłowy';
GO
EXECUTE dbo.Pozycja_wstaw 8, 'Lewo Skrzydłowy';
GO
EXECUTE dbo.Pozycja_wstaw 9, 'Napastnik';
GO
EXECUTE dbo.Pozycja_wstaw 10, 'Środkowy Pomocnik';
GO
-----------------------------------------------
--STANOWISKO-----------------------------------
EXECUTE dbo.Stanowisko_wstaw 1, 'Trener Główny';
GO
EXECUTE dbo.Stanowisko_wstaw 2, 'Trener Motoryki';
GO
EXECUTE dbo.Stanowisko_wstaw 3, 'Trener Techniki';
GO
EXECUTE dbo.Stanowisko_wstaw 4, 'Trener Bramkarzy';
GO
EXECUTE dbo.Stanowisko_wstaw 5, 'Psycholog';
GO
EXECUTE dbo.Stanowisko_wstaw 6, 'Dietetyk';
GO
EXECUTE dbo.Stanowisko_wstaw 7, 'Fizjoterapeuta';
GO
EXECUTE dbo.Stanowisko_wstaw 8, 'Asystent';
GO
-----------------------------------------------
--TRENER-----------------------------------
EXECUTE dbo.Trener_wstaw 1, 'Leszek', '', 'Barczyński', '1980-04-10', 'Polska', '2022-01-13', 20000;
GO
EXECUTE dbo.Trener_wstaw 2, 'Marcin', '', 'Olek', '1989-03-10', 'Polska', '2025-01-13', 24000;
GO
EXECUTE dbo.Trener_wstaw 3, 'Kosta', '', 'Runjaić', '1980-06-10', 'Czechy', '2022-01-13', 20000;
GO
EXECUTE dbo.Trener_wstaw 4, 'Lettieri', 'Gonzalo', 'Gino', '1985-04-10', 'Włochy', '2032-01-13', 30000;
GO
EXECUTE dbo.Trener_wstaw 5, 'Jerzy', '', 'Brzęczek', '1978-02-10', 'Polska', '2022-01-23', 27000;
GO
EXECUTE dbo.Trener_wstaw 6, 'Adam', '', 'Nawałka', '1970-05-10', 'Polska', '2026-07-13', 42000;
GO
EXECUTE dbo.Trener_wstaw 7, 'Ireneusz', 'Damian', 'Mamrot', '1975-06-10', 'Polska', '2025-03-13', 20000;
GO
EXECUTE dbo.Trener_wstaw 8, 'Dragomir', '', 'Okuka', '1979-04-23', 'Rosja', '2021-02-13', 30000;
GO
EXECUTE dbo.Trener_wstaw 9, 'Henning', '', 'Berg', '1988-08-10', 'Holandia', '2026-04-03', 20000;
GO
EXECUTE dbo.Trener_wstaw 10, 'Nenad', '', 'Bjelica', '1985-02-10', 'Słowenia', '2025-04-17', 29000;
GO
EXECUTE dbo.Trener_wstaw 11, 'Juri', '', 'Owsienko', '1968-04-14', 'Czeczenia', '2025-04-17', 29000;
GO
-----------------------------------------------
--DRUZYNA_TRENER-----------------------------------
EXECUTE dbo.Druzyna_Trener_wstaw 1, 1, 1, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 2, 2, 1, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 3, 3, 1, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 4, 4, 1, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 5, 5, 1, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 1, 6, 3, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 5, 7, 2, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 3, 7, 2, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 4, 8, 5, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 3, 9, 4, '';
GO
EXECUTE dbo.Druzyna_Trener_wstaw 2, 11, 7, '';
GO
-----------------------------------------------
--ZAWODNIK-----------------------------------
EXECUTE dbo.Zawodnik_wstaw 1, 'Radosław', 'Radek', 'Majecki', '1990-10-02',' 180', '75', 'Prawa', 'Polska', '2024-01-13', 50000, 1, 1;
GO
EXECUTE dbo.Zawodnik_wstaw 2, 'Przemyslav', '', 'Radović', '1985-10-02',' 170', '75', 'Prawa', 'Łotwa', '2024-01-13', 560000, 1, 9;
GO
EXECUTE dbo.Zawodnik_wstaw 3, 'Szymon', '', 'Zurkowski', '1992-11-02',' 185', '85', 'Lewa', 'Polska', '2025-04-13', 340000, 2, 10;
GO
EXECUTE dbo.Zawodnik_wstaw 4, 'Mateusz', '', 'Wieteska', '1993-05-02',' 183', '76', 'Prawa', 'Polska', '2022-01-13', 20000, 2, 2;
GO
EXECUTE dbo.Zawodnik_wstaw 5, 'Mohamed', '', 'Salah', '1994-11-02',' 182', '78', 'Prawa', 'Egipt', '2026-03-17', 70000, 3, 7;
GO
EXECUTE dbo.Zawodnik_wstaw 6, 'Artur', '', 'Boruc', '1986-01-02',' 188', '80', 'Lewa', 'Polska', '2027-02-23', 50000, 3, 1;
GO
EXECUTE dbo.Zawodnik_wstaw 7, 'Michał', 'Pazdanavarro', 'Pazdan', '1995-10-02',' 184', '85', 'Prawa', 'Polska', '2021-09-13', 50000, 4, 2;
GO
EXECUTE dbo.Zawodnik_wstaw 8, 'Michał', '', 'Kucharczyk', '1982-11-02',' 175', '72', 'Prawa', 'Polska', '2024-01-13', 30000, 4, 8;
GO
EXECUTE dbo.Zawodnik_wstaw 9, 'Ebi', '', 'Smolarek', '1980-10-02',' 170', '71', 'Prawa', 'Polska', '2022-01-20', 60000, 5, 9;
GO
EXECUTE dbo.Zawodnik_wstaw 10, 'Piotr', '', 'Zieliński', '1996-10-02',' 178', '73', 'Prawa', 'Polska', '2027-04-13', 90000, 5, 10;
GO
EXECUTE dbo.Zawodnik_wstaw 11, 'Andrzej', '', 'Lobby', '1986-12-02',' 179', '75', 'Prawa', 'Polska', '2027-02-13', 70000, 2, 10;
GO
-----------------------------------------------
--STADION-----------------------------------
EXECUTE dbo.Stadion_wstaw 1, 'Kartoflisko', 'Trawa', 1, 'Kalisz', 'Poznańska';
GO
EXECUTE dbo.Stadion_wstaw 2, 'Parowozownia', 'Trawa', 1, 'Ostrów Wlkp', 'Trauguta';
GO
EXECUTE dbo.Stadion_wstaw 3, 'Narodowy', 'Trawa', 1, 'Warszawa', 'Kaliska';
GO
EXECUTE dbo.Stadion_wstaw 4, 'Łazienkowska', 'Trawa', 1, 'Warszawa', 'Łazienkowska';
GO
EXECUTE dbo.Stadion_wstaw 5, 'Camp Nou', 'Trawa', 1, 'Kalisz', 'Górnośląska';
GO
EXECUTE dbo.Stadion_wstaw 6, 'Stal', 'Trawa', 1, 'Ostrów Wlkp', 'Lewandowskiego';
GO
EXECUTE dbo.Stadion_wstaw 7, 'Orlik Brzoskwiniowa', 'Tartan', 0, 'Ostrów Wlkp', 'Brzoskwiniowa';
GO
EXECUTE dbo.Stadion_wstaw 8, 'Kampus Trningowy', 'Trawa', 0, 'Wielowieś', 'Gołuchowska';
GO
EXECUTE dbo.Stadion_wstaw 9, 'Olimpijska', 'Trawa', 1, 'Czekanów', 'Konpnickiej';
GO
EXECUTE dbo.Stadion_wstaw 10, 'San Siro', 'Trawa', 1, 'Sosnowiec', 'Mediolańska';
GO
EXECUTE dbo.Stadion_wstaw 11, 'Detroit', 'Asfalt', 0, 'Radom', 'Studencka';
GO
-----------------------------------------------
--TRENING-----------------------------------
EXECUTE dbo.Trening_wstaw '2019-06-01', '13:00', 1, 8;
GO
EXECUTE dbo.Trening_wstaw '2019-06-05', '14:00', 2, 7;
GO
EXECUTE dbo.Trening_wstaw '2019-06-09', '13:30', 3, 9;
GO
EXECUTE dbo.Trening_wstaw '2019-06-11', '10:00', 4, 8;
GO
EXECUTE dbo.Trening_wstaw '2019-07-01', '11:20', 5, 2;
GO
EXECUTE dbo.Trening_wstaw '2019-07-08', '17:00', 1, 7;
GO
EXECUTE dbo.Trening_wstaw '2019-07-21', '10:30', 2, 7;
GO
EXECUTE dbo.Trening_wstaw '2019-08-01', '15:00', 3, 8;
GO
EXECUTE dbo.Trening_wstaw '2019-08-05', '19:00', 4, 9;
GO
EXECUTE dbo.Trening_wstaw '2019-08-08', '13:50', 5, 2;
GO
-----------------------------------------------
--MECZ-----------------------------------
EXECUTE dbo.Mecz_wstaw 1,'2019-01-01', '13:00', 1, 6, 2, 0, 1;
GO
EXECUTE dbo.Mecz_wstaw 2,'2019-02-01', '17:00', 2, 7, 2, 2, 4;
GO
EXECUTE dbo.Mecz_wstaw 3,'2019-03-01', '15:00', 3, 8, 3, 1, 3;
GO
EXECUTE dbo.Mecz_wstaw 4,'2019-03-11', '14:00', 4, 9, 2, 5, 1;
GO
EXECUTE dbo.Mecz_wstaw 5,'2019-04-20', '13:00', 5, 10, 1, 2, 10;
GO
EXECUTE dbo.Mecz_wstaw 6,'2019-06-01', '17:00', 1, 6, '', '', 5;
GO
EXECUTE dbo.Mecz_wstaw 7,'2019-06-21', '20:45', 2, 7, '', '', 6;
GO
EXECUTE dbo.Mecz_wstaw 8,'2019-07-11', '19:00', 3, 8, '', '', 6;
GO
EXECUTE dbo.Mecz_wstaw 9,'2019-07-21', '20:45', 4, 9, '', '', 10;
GO
EXECUTE dbo.Mecz_wstaw 10,'2019-08-06', '13:00', 5, 10, '', '', 1;
GO
--EXECUTE dbo.Mecz_wstaw 11,'2019-09-16', '14:30', 1, 6, '', '', 11;
--GO
-----------------------------------------------
--ZAWODNIK_MECZ-----------------------------------
EXECUTE dbo.Zawodnik_Mecz_wstaw 1, 1, 1, '', '', '';
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 2, 1, 9, 1, 1, '';
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 3, 2, 5, '', 1, '';
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 4, 2, 6, '', '', 1;
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 5, 3, 8, '', 2, 1;
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 6, 3, 9, 2, '', '';
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 7, 4, 1, '', 1, '';
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 8, 4, 3, 1, 1, '';
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 9, 5, 2, '', '', '';
GO
EXECUTE dbo.Zawodnik_Mecz_wstaw 10, 5, 7, '', 1, '';
GO
-----------------------------------------------
-----------------------------------------------
---------------UPDATE--------------------------
/*EXECUTE dbo.Liga_update 6, 'Liga Okręgowa';
GO
EXECUTE dbo.Pozycja_update 10, 'Dyrygent pomocy';
GO
EXECUTE dbo.Stanowisko_update 8, 'Pomoc Kuchenna';
GO
EXECUTE dbo.Druzyna_update 4, 'KKS Galeria Tęcza', 1, 4;
GO
EXECUTE dbo.Zawodnik_update 4, 'Mateusz', '', 'Wieteska', '1993-05-02',' 183', '79', 'Prawa', 'Polska', '2028-01-13', 25000, 2, 2;
GO
EXECUTE dbo.Stadion_update 7, 'Akademia Piłkarska', 'Tartan', 0, 'Ostrów Wlkp', 'Brzoskwiniowa';
GO
EXECUTE dbo.Trening_update 8, '2019-08-06', '14:10', 3, 8;
GO
EXECUTE dbo.Trener_update 2, 'Marcin', '', 'Olek', '1997-03-10', 'Polska', '2027-01-13', 94000;
GO
EXECUTE dbo.Druzyna_Trener_update 9, 1, 6, 3, 'Niemiły Pan';
GO
EXECUTE dbo.Mecz_update 6,'2019-06-01', '17:00', 1, 6, 1, 3, 5;
GO
EXECUTE dbo.Zawodnik_Mecz_update 6, 6, 3, 9, 2, '', 1;
GO
-----------------------------------------------
-----------------------------------------------
---------------DELETE--------------------------
EXECUTE dbo.Druzyna_usun 11;
GO
EXECUTE dbo.Zawodnik_usun 11;
GO
EXECUTE dbo.Stadion_usun 11;
GO
EXECUTE dbo.Trening_usun 10;
GO
EXECUTE dbo.Trener_usun 11;
GO
EXECUTE dbo.Druzyna_Trener_usun 11;
GO
EXECUTE dbo.Mecz_usun 10;
GO
EXECUTE dbo.Zawodnik_Mecz_usun 10;
GO
EXECUTE dbo.Pozycja_usun 4;
GO
EXECUTE dbo.Stanowisko_usun 8;
GO
EXECUTE dbo.Liga_usun 6;
GO

----------??????????????-------------Czyszczenie auto inkrementacji
DBCC CHECKIDENT('dbo.Zawodnik_Mecz', RESEED, 0);
GO
-----------?????????????--------------

*/

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-------------
---------------TRANSAKCJE--------------------
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@------------

------------------------------
-----ARCHIWIZACJA TRENERA-----
------------------------------
CREATE TABLE dbo.Trener_Kopia(
	id_trener_kopia int NOT NULL IDENTITY (1, 1),
	id_trener int NOT NULL,
	imie varchar(50) NOT NULL,
	drugie_imie varchar(50) NULL,
	nazwisko varchar(50) NOT NULL,
	data_urodzenia date NOT NULL,
	narodowosc varchar(50) NULL,
	do_kiedy_kontrakt date NOT NULL,
	pensja money NOT NULL
);
GO

ALTER TABLE dbo.Trener_Kopia
ADD CONSTRAINT PK_Trener_Kopia
PRIMARY KEY (id_trener_kopia);
GO

CREATE PROCEDURE dbo.Trener_Archiwizuj
@Par_id_trener int
AS
BEGIN

SET XACT_ABORT ON;

BEGIN TRANSACTION 
INSERT dbo.Trener_Kopia
(id_trener, imie, drugie_imie, nazwisko, data_urodzenia, narodowosc, do_kiedy_kontrakt, pensja)
SELECT id_trener, imie, drugie_imie, nazwisko, data_urodzenia, narodowosc, do_kiedy_kontrakt, pensja
FROM dbo.Trener
WHERE id_trener = @Par_id_trener;

DELETE dbo.Trener
WHERE id_trener = @Par_id_trener;

IF (@@ERROR <> 0)
	ROLLBACK TRANSACTION
ELSE
	COMMIT TRANSACTION
END;
GO
------------------------------------------
------EXECUTE dla archiwizuj trenera------
/*
EXECUTE dbo.Trener_Archiwizuj
@Par_id_trener = 5;
GO

SELECT *
FROM dbo.Trener;

SELECT *
FROM dbo.Trener_Kopia;
GO
*/
------------------------------------------
------------------------------------------


------------------------------
-----ARCHIWIZACJA ZAWODNIKA-----
------------------------------
CREATE TABLE dbo.Zawodnik_Kopia(
	id_zawodnik_kopia int NOT NULL IDENTITY (1, 1),
	id_zawodnik int NOT NULL,
	imie varchar(50) NOT NULL,
	drugie_imie varchar(50) NULL,
	nazwisko varchar(50) NOT NULL,
	data_urodzenia date NOT NULL,
	wzrost varchar(10) NOT NULL,
	waga varchar(10) NOT NULL,
	lepsza_noga varchar(10) NULL,
	narodowosc varchar(50) NOT NULL,
	do_kiedy_kontrakt date NOT NULL,
	pensja money NOT NULL,
	id_druzyna int NOT NULL,
	id_pozycja int NULL
	--PRIMARY KEY (id_zawodnik)
);
GO

ALTER TABLE dbo.Zawodnik_Kopia
ADD CONSTRAINT PK_Zawodnik_Kopia
PRIMARY KEY (id_zawodnik_kopia);
GO

CREATE PROCEDURE dbo.Zawodnik_Archiwizuj
@Par_id_zawodnik int
AS
BEGIN

SET XACT_ABORT ON;

BEGIN TRANSACTION 
INSERT dbo.Zawodnik_Kopia
(id_zawodnik, imie, drugie_imie, nazwisko, data_urodzenia, wzrost, waga, lepsza_noga, narodowosc, do_kiedy_kontrakt, pensja, id_druzyna, id_pozycja)
SELECT id_zawodnik, imie, drugie_imie, nazwisko, data_urodzenia, wzrost, waga, lepsza_noga, narodowosc, do_kiedy_kontrakt, pensja, id_druzyna, id_pozycja
FROM dbo.Zawodnik
WHERE id_zawodnik = @Par_id_zawodnik;

DELETE dbo.Zawodnik
WHERE id_zawodnik = @Par_id_zawodnik;

IF (@@ERROR <> 0)
	ROLLBACK TRANSACTION
ELSE
	COMMIT TRANSACTION
END;
GO
------------------------------------------
------EXECUTE dla archiwizuj zawodnika------
/*
EXECUTE dbo.Zawodnik_Archiwizuj
@Par_id_zawodnik = 11;
GO

SELECT *
FROM dbo.Zawodnik;

SELECT *
FROM dbo.Zawodnik_Kopia;
GO
*/
------------------------------------------
------------------------------------------


------------------------------
-----HISTORIA DRUZYNY---------Transakcja ustawia nową lige dla druzyny,
------------------------------a ową druzyne z poprzednią ligą wrzuca do historii

CREATE TABLE dbo.HistoriaDruzyny
(
	id_historia_druzyny int NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_druzyna int NOT NULL REFERENCES dbo.Druzyna(id_druzyna),
	sezon int NOT NULL,
	liga_nowa int NOT NULL REFERENCES dbo.Liga(id_liga),
	liga_poprzednia int NOT NULL REFERENCES dbo.Liga(id_liga)
);
GO

CREATE PROCEDURE dbo.Druzyna_historia
@Par_id_druzyna int,
--@Par_id_liga int,
@Par_liga_nowa int
AS
BEGIN
-- Ustawienie przerywania bloku transakcji po wyst¹pieniu
-- b³êdu czasu wykonania (ang. runtime error).
SET XACT_ABORT ON;

BEGIN TRANSACTION -- Rozpoczêcie bloku transakcji.
DECLARE @Var_liga_poprzednia int;

-- (1) Pobranie poprzedniej ligi w której wystepowa³a druzyna.
SELECT @Var_liga_poprzednia = id_liga
FROM dbo.Druzyna
WHERE id_druzyna = @Par_id_druzyna;

IF (@Var_liga_poprzednia <> @Par_liga_nowa)
BEGIN
	-- (2) Zmiana ligi druzyny.
	UPDATE dbo.Druzyna
	SET id_liga = @Par_liga_nowa
	WHERE id_druzyna = @Par_id_druzyna;

	WAITFOR DELAY '00:00:15'

	-- (3) Zarejestrowanie zmiany ligi w tabeli historii.
	INSERT dbo.HistoriaDruzyny
	(id_druzyna, sezon, liga_nowa, liga_poprzednia)
	VALUES
	(@Par_id_druzyna, YEAR(GETDATE()), @Par_liga_nowa, @Var_liga_poprzednia);
END

IF (@@ERROR <> 0)
	ROLLBACK TRANSACTION
ELSE
	COMMIT TRANSACTION
END;
GO

------------------------------------------
------EXECUTE dla Historia druzyny------
/*
EXECUTE dbo.Druzyna_historia
@Par_id_druzyna = 1,
@Par_liga_nowa = 5;
GO

SELECT*
FROM dbo.Druzyna;
GO

SELECT*
FROM dbo.HistoriaDruzyny;
GO
*/
------------------------------------------
------------------------------------------


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-------------
---------------SELECT--------------------
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@------------
/*
SELECT*
FROM dbo.Pozycja;
GO
SELECT*
FROM dbo.Zawodnik;
GO
SELECT*
FROM dbo.Liga;
GO
SELECT*
FROM dbo.Druzyna;
GO
SELECT*
FROM dbo.Stanowisko;
GO
SELECT*
FROM dbo.Trener;
GO
SELECT*
FROM dbo.Druzyna_Trener;
GO
SELECT*
FROM dbo.Stadion;
GO
SELECT*
FROM dbo.Trening;
GO
SELECT*
FROM dbo.Mecz;
GO
SELECT*
FROM dbo.Zawodnik_Mecz;
GO
*/



--#########--PROJEKT P4--###################################XD###############################--

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-----
--@@@@@@@@@@--PROCEDURY WYSZUKIWANIA--@@@@@@@@@@@@@@-----
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-----

----------B34--------------------------------------
-- BZDN - lista zadan C6.
---------------------------------------------------


CREATE PROCEDURE dbo.Trener_Znajdz_Id
@Par_id_trener int
AS
BEGIN
SELECT id_trener as [id], imie, drugie_imie as [drugie imie] , nazwisko, data_urodzenia as [data urodzenia], narodowosc, do_kiedy_kontrakt as [kontrakt], pensja
FROM dbo.Trener
WHERE id_trener = @Par_id_trener;
END;
GO
/*
EXECUTE dbo.Trener_Znajdz_Id 1;
GO
*/
-----------------
-----------------
-- 2) Wyszukiwanie przyblizone wzgledem nazwiska pracownika.
--
CREATE PROCEDURE dbo.Trener_Znajdz_Nazwisko
@Par_nazwisko varchar(40) = ''
AS
BEGIN
SELECT id_trener as [id], imie, drugie_imie as [drugie imie] , nazwisko, data_urodzenia as [data urodzenia], narodowosc, do_kiedy_kontrakt as [kontrakt], pensja
FROM dbo.Trener
WHERE Nazwisko LIKE '%' + LTRIM(RTRIM(@Par_nazwisko)) + '%'
ORDER BY nazwisko ASC, imie ASC;
END;
GO
/*
EXECUTE dbo.Trener_Znajdz_Nazwisko 'B';
GO
*/
---------------------------------------
---------------------------------------

------------------------------------------------------
-- 3) Wyszukiwanie przyblizone wzgledem pola liczbowego.
--------Pokazuje trenerów, których pensja mieści się w podanym zakresie.
--
CREATE PROCEDURE dbo.Trener_Znajdz_Pensja
@Par_pensjaOd money = 0.00,
@Par_pensjaDo money = 1000000000
AS
BEGIN
SELECT id_trener as [id], imie, drugie_imie as [drugie imie] , nazwisko, data_urodzenia as [data urodzenia], narodowosc, do_kiedy_kontrakt as [kontrakt], pensja
FROM dbo.Trener
WHERE pensja BETWEEN @Par_pensjaOd AND @Par_pensjaDo
ORDER BY pensja ASC, nazwisko ASC;
END;
GO

/*
EXECUTE dbo.Trener_Znajdz_Pensja 30000, 50000;
GO
*/
------------------------------------------------------
-- 4) DATEDIFF -- Wyświetlenie ilości dni do poszczególnych meczy (nie odbytych)
--	Można wybrać konkretną drużynę		

CREATE PROCEDURE dbo.Mecz_ileDniDoMeczu
@Par_druzyna_nasza varchar(50) = '',
@Par_ileDni int = 365
AS
BEGIN
SELECT id_mecz, data, godzina, dbo.Druzyna.nazwa AS [druzyna], DATEDIFF(DAY, GETDATE(), data) AS [Dni do meczu]
FROM dbo.Mecz INNER JOIN dbo.Druzyna ON dbo.Mecz.id_druzyna_nasza = dbo.Druzyna.id_druzyna
WHERE dbo.Druzyna.nazwa LIKE '%' + LTRIM(RTRIM(@Par_druzyna_nasza)) + '%' AND DATEDIFF(DAY, GETDATE(), data) <= @Par_ileDni AND DATEDIFF(DAY, GETDATE(), data) >= 0
ORDER BY [Dni do meczu] DESC;
END;
GO

/*
EXECUTE dbo.Mecz_ileDniDoMeczu;
GO

EXECUTE dbo.Mecz_ileDniDoMeczu 'FC PoNalewce';
GO

EXECUTE dbo.Mecz_ileDniDoMeczu '', 20;
GO
*/
------------------------------------------------------
-- 5) WYLICZANIE -- Suma pensji zawodników w poszczególnych drużynach, można wybrać minimalną sumę
--
CREATE PROCEDURE dbo.Druzna_SumaPensjiZawodnikow
@Par_n int = 0
AS
BEGIN
SELECT dbo.Druzyna.nazwa, SUM(pensja) AS [Suma pensji zawodników], DENSE_RANK() OVER(ORDER BY SUM(pensja) DESC) AS [ranking plac]
FROM dbo.Zawodnik INNER JOIN dbo.Druzyna ON dbo.Zawodnik.id_druzyna = dbo.Druzyna.id_druzyna
GROUP BY dbo.Druzyna.nazwa
HAVING SUM(pensja) >= @Par_n 
ORDER BY [Suma pensji zawodników] DESC;
END;
GO
/*
EXECUTE dbo.Druzna_SumaPensjiZawodnikow;
GO
EXECUTE dbo.Druzna_SumaPensjiZawodnikow 300000;
GO
*/
--------------------------


---------------Lista C7-----------------

---------------1------------------TOP średnich płac zawodników w drużynach
----------------------------------

CREATE PROCEDURE dbo.Druzna_sredniaPensji
@Par_n int
AS
BEGIN
SELECT TOP (@Par_n) dbo.Druzyna.nazwa, AVG(pensja) AS [srednia pensja zawodnika]
FROM dbo.Zawodnik INNER JOIN dbo.Druzyna ON dbo.Zawodnik.id_druzyna = dbo.Druzyna.id_druzyna
GROUP BY dbo.Druzyna.nazwa
--ORDER BY AVG(pensja) DESC;
END;
GO
/*
EXECUTE dbo.Druzna_sredniaPensji 3;
GO
*/

---------------2------------------Liczba zawodników na danej pozycji
----------------------------------Right outer join użyty aby pokazać pozycje do których nie ma przypisanych zawodników
----------------------------------Użyte indeksowanie
CREATE INDEX id_pozycja
ON dbo.Zawodnik(id_pozycja)
GO

CREATE PROCEDURE dbo.Pozycja_Lzawodnikow
AS
BEGIN
SELECT dbo.Pozycja.pozycja AS [Pozycja], COUNT(dbo.Zawodnik.id_zawodnik) AS [Liczba zwodników]
FROM dbo.Zawodnik RIGHT OUTER JOIN dbo.Pozycja ON dbo.Zawodnik.id_pozycja = dbo.Pozycja.id_pozycja
GROUP BY dbo.Pozycja.pozycja;
END;
GO

/*
EXECUTE dbo.Pozycja_Lzawodnikow;
GO

SELECT *
FROM dbo.Pozycja
GO
*/

---------------3------------------wyświetlanie drużyn w których średnia pensji trenerów jest większa niż sednia wszystkich trenerów

CREATE PROCEDURE dbo.Druzna_minPensjaTrenera
AS
BEGIN
SELECT DENSE_RANK() OVER(ORDER BY AVG(pensja) DESC) AS [ranking plac], dbo.Druzyna.nazwa, AVG(dbo.Trener.pensja) AS [średnia pensja trenera]
FROM   dbo.Druzyna INNER JOIN
       dbo.Druzyna_Trener ON dbo.Druzyna.id_druzyna = dbo.Druzyna_Trener.id_druzyna INNER JOIN
       dbo.Trener ON dbo.Druzyna_Trener.id_trener = dbo.Trener.id_trener INNER JOIN
       dbo.Stanowisko ON dbo.Druzyna_Trener.id_stanowisko = dbo.Stanowisko.id_stanowisko
GROUP BY dbo.Druzyna.nazwa
HAVING  AVG(dbo.Trener.pensja) >= (SELECT AVG(pensja) FROM dbo.Trener);
END;
GO

/*
EXECUTE dbo.Druzna_minPensjaTrenera;
GO
*/

--------------4-----------------------wyświetlanie wszystkich przypisań trenerów do rużyn i ich stanowisk w drużynie
--------------------------------------dzięki FULL OUTER JOIN można określić, w której drużynie jakie stanowiska są wolne i jacy trenerzy są wolni
--------------------------------------(Obsługa tylko drużyn klubowych)
CREATE PROCEDURE dbo.wyswietlTrenerowDruzyn
AS
BEGIN
SELECT dbo.Druzyna.nazwa, CONCAT(dbo.Trener.imie,' ', dbo.Trener.drugie_imie,' ', dbo.Trener.nazwisko) AS [trener], dbo.Stanowisko.stanowisko
FROM   dbo.Druzyna INNER JOIN
       dbo.Druzyna_Trener ON dbo.Druzyna.id_druzyna = dbo.Druzyna_Trener.id_druzyna FULL OUTER JOIN
       dbo.Trener ON dbo.Druzyna_Trener.id_trener = dbo.Trener.id_trener FULL OUTER JOIN
       dbo.Stanowisko ON dbo.Druzyna_Trener.id_stanowisko = dbo.Stanowisko.id_stanowisko
ORDER BY dbo.Druzyna.nazwa DESC;
END;
GO

/*
EXECUTE dbo.wyswietlTrenerowDruzyn;
GO
*/

-------5--------------------------Statystyki drużyn (tylko klubowych) ze wszystkich meczów w swoich ligach
---funkcja zliczająca punkty jeżeli nasza drużyna wygrała mecz

CREATE FUNCTION dbo.LiczbaPunktow(@Par_BramkiNasze int, @Par_BramkiPrzeciwnika int)
RETURNS int
AS
BEGIN
DECLARE @Var_Punkty int;
	IF(@Par_BramkiNasze > @Par_BramkiPrzeciwnika)
		SET @Var_Punkty = 3;
	ELSE IF(@Par_BramkiNasze = @Par_BramkiPrzeciwnika)
		SET @Var_Punkty = 1;
	ELSE
		SET @Var_Punkty = 0;
RETURN @Var_Punkty;
END;
GO
---
---
CREATE PROCEDURE dbo.statystykiDruzyn
AS
BEGIN
SELECT N.nazwa [Druzyna], dbo.Liga.nazwa AS [Liga],COUNT(dbo.Mecz.id_mecz) AS [Liczba meczy],
SUM(dbo.Mecz.bramki_nasze) AS [Liczba goli] ,SUM(dbo.LiczbaPunktow(bramki_nasze, bramki_przeciwnika)) AS [Liczba punktów]
FROM dbo.Druzyna AS N INNER JOIN dbo.Mecz ON N.id_druzyna = dbo.Mecz.id_druzyna_nasza
	 INNER JOIN dbo.Liga ON N.id_liga = dbo.Liga.id_liga
GROUP BY N.nazwa, dbo.Liga.nazwa;
END;
GO

/*
EXECUTE dbo.statystykiDruzyn;
GO
*/
------------------6-----------------zawodnicy któzy są starsi niż średnia wieku wszystkich zawodników

CREATE PROCEDURE dbo.wiekZawPowSredniej
AS
BEGIN
SELECT CONCAT(dbo.Zawodnik.imie,' ', dbo.Zawodnik.drugie_imie,' ', dbo.Zawodnik.nazwisko) AS [Zawodnik], DATEDIFF(YEAR, data_urodzenia, GETDATE()) AS [Wiek]
FROM dbo.Zawodnik
WHERE DATEDIFF(YEAR, data_urodzenia, GETDATE()) > (SELECT AVG(DATEDIFF(YEAR, data_urodzenia, GETDATE())) FROM dbo.Zawodnik)
ORDER BY [Wiek];
END;
GO

/*
EXECUTE wiekZawPowSredniej;
GO
*/
------------------7-----------------Statystyki zawodników
------------------------------------Dzięki LEFT OUTER JOIN widzimy zawodników bez goli i przewinień

CREATE PROCEDURE dbo.StatystkiZawodnikow
AS
BEGIN
SELECT DENSE_RANK() OVER(ORDER BY SUM(ZM.bramki) DESC) AS [Ranking Strzelców], CONCAT(Z.imie,' ', Z.nazwisko) AS [Zawodnik], SUM(ZM.bramki) AS [Gole], SUM(ZM.kartki_zolte) AS [Żółte kartki], 
SUM(ZM.kartki_czerwone) AS [Czerowne Kartki]
FROM dbo.Zawodnik AS Z LEFT OUTER JOIN dbo.Zawodnik_Mecz AS ZM ON Z.id_zawodnik = ZM.id_zawodnik
GROUP BY Z.imie, Z.drugie_imie , Z.nazwisko;
END;
GO

/*
EXECUTE dbo.StatystkiZawodnikow;
GO
*/


/*
CREATE PROCEDURE dbo.StatystkiZawodnikow
@Par_id int = ''
AS
BEGIN
SELECT CONCAT(Z.imie,' ', Z.nazwisko) AS [Zawodnik], SUM(ZM.bramki) AS [Gole], SUM(ZM.kartki_zolte) AS [Żółte kartki], 
SUM(ZM.kartki_czerwone) AS [Czerowne Kartki]
FROM dbo.Zawodnik AS Z LEFT OUTER JOIN dbo.Zawodnik_Mecz AS ZM ON Z.id_zawodnik = ZM.id_zawodnik
WHERE Z.id_zawodnik = @Par_id
GROUP BY Z.imie, Z.nazwisko;
END;
GO

EXECUTE dbo.StatystkiZawodnikow 1;
GO

*/


ALTER PROCEDURE dbo.Mecz_ileDniDoMeczu2
@Par_druzyna_nasza varchar(50) = '',
@Par_ileDni int = 365
AS
BEGIN
SELECT data, godzina, CONCAT(N.nazwa, ' - ' , P.nazwa) AS [Druzyny], DATEDIFF(DAY, GETDATE(), data) AS [Dni do meczu], dbo.Stadion.nazwa AS [Stadion]
FROM dbo.Mecz INNER JOIN dbo.Druzyna AS N ON dbo.Mecz.id_druzyna_nasza = N.id_druzyna
		INNER JOIN dbo.Druzyna AS P ON dbo.Mecz.id_druzyna_przeciwna = P.id_druzyna
		INNER JOIN dbo.Stadion ON dbo.Stadion.id_stadion = dbo.Mecz.id_stadion
WHERE N.nazwa LIKE '%' + LTRIM(RTRIM(@Par_druzyna_nasza)) + '%' AND DATEDIFF(DAY, GETDATE(), data) <= @Par_ileDni AND DATEDIFF(DAY, GETDATE(), data) >= 0
ORDER BY [Dni do meczu] DESC;
END;
GO

/*
EXECUTE dbo.Mecz_ileDniDoMeczu2;
GO
*/