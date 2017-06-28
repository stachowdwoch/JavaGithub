DROP PROCEDURE dostawa_towaru;
DROP PROCEDURE dostawa_ksiazki;
DROP FUNCTION zwroc_kaucja;
DROP PROCEDURE obsluz_archiwum;
DROP PROCEDURE uiszczenie_oplaty;
DROP FUNCTION set_random_date_for_borrow;
DROP FUNCTION set_random_date_for_return;
DROP PROCEDURE dodaj_wypozyczenie;
DROP PROCEDURE dodaj_wypozyczenie_random;

DROP TRIGGER AKTUALIZACJA_ILOSCI;
DROP TRIGGER ARCHIWUM_TRIGGER;
DROP TRIGGER CZY_BIBLIOTEKARZ;
DROP TRIGGER ODDANIE_KSIAZKI;
DROP TRIGGER OGRANICZENIE_LICZBY_POZYCZEN;
DROP TRIGGER SCHEMA_HISTORY_TRG;
DROP TRIGGER USUN_STARE_WPISY_TRG;
DROP TRIGGER USUN_UZYTKOWNIKA_BAZY;

DROP TABLE AUTOR CASCADE CONSTRAINTS;
DROP TABLE AUTORZY_KSIAZEK CASCADE CONSTRAINTS;
DROP TABLE KLIENCI CASCADE CONSTRAINTS;
DROP TABLE KSIAZKI CASCADE CONSTRAINTS;
DROP TABLE PRACOWNICY CASCADE CONSTRAINTS;
DROP TABLE SCHEMA_HISTORY CASCADE CONSTRAINTS;
DROP TABLE UZYTKOWNICY_BAZY CASCADE CONSTRAINTS;
DROP TABLE WYPOZYCZENIA CASCADE CONSTRAINTS;
DROP TABLE WYPOZYCZENIA_ARCHIWUM CASCADE CONSTRAINTS;

DROP SEQUENCE pracownicy_seq;
DROP SEQUENCE autor_seq;
DROP SEQUENCE klienci_seq;
DROP SEQUENCE ksiazki_seq;
DROP SEQUENCE wypozyczenia_seq;
DROP SEQUENCE history_seq;

CREATE TABLE pracownicy(
  id_pracownik INT PRIMARY KEY,
  imie_pracownik VARCHAR2(25),
  nazwisko_pracownik VARCHAR2(40),
  stanowisko VARCHAR2(30),
  wynagrodzenie NUMBER(6,2),
  plec VARCHAR2(1) CONSTRAINT plec_check2
    CHECK ( plec = 'K' OR plec = 'M') NOT NULL
);

CREATE TABLE uzytkownicy_bazy(
  id_pracownik INT PRIMARY KEY,
  login VARCHAR2(25),
  haslo VARCHAR2(10),
  FOREIGN KEY (id_pracownik) REFERENCES pracownicy(id_pracownik)
);

CREATE TABLE ksiazki(
  id_ksiazka INT PRIMARY KEY NOT NULL,
  tytul VARCHAR2(30),
  rok_wydania INT,
  gatunek VARCHAR2(30),
  wydawnictwo VARCHAR2(30),
  pozycja VARCHAR2(20) UNIQUE,
  ilosc NUMBER(6),
  ilosc_posiadana NUMBER(6)
);
  
CREATE TABLE klienci(
  id_klient INT PRIMARY KEY NOT NULL,
  imie_klient VARCHAR2(25),
  nazwisko_klient VARCHAR2(40),
  adres_email VARCHAR2(30),
  nr_tel VARCHAR2(12),
  oplaty NUMBER(6,2) DEFAULT 5
  );
  
CREATE TABLE wypozyczenia(
  id_wypozyczenie INT PRIMARY KEY NOT NULL,
  id_klient INT NOT NULL,
  id_ksiazka INT NOT NULL,
  id_pracownik INT NOT NULL,
  data_wypozyczenia DATE,
  data_oddania DATE,
  CONSTRAINT klient_fk FOREIGN KEY (id_klient) REFERENCES klienci(id_klient),
  CONSTRAINT ksiazka_fk FOREIGN KEY (id_ksiazka) REFERENCES ksiazki(id_ksiazka),
  CONSTRAINT pracownik_fk FOREIGN KEY (id_pracownik) REFERENCES pracownicy(id_pracownik)
  );

CREATE TABLE autor(
  id_autor INT PRIMARY KEY NOT NULL,
  imie_autor VARCHAR2(25),
  nazwisko_autor VARCHAR2(40)
);

CREATE TABLE autorzy_ksiazek(
  id_autor INT NOT NULL,
  id_ksiazka INT NOT NULL,
  PRIMARY KEY (id_autor, id_ksiazka),
  FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
  FOREIGN KEY (id_ksiazka) REFERENCES ksiazki(id_ksiazka)
);

CREATE TABLE SCHEMA_HISTORY(
   UZYTKOWNIK VARCHAR2 (30 BYTE),
   ZDARZENIE VARCHAR2 (30 BYTE),
   TYP VARCHAR2 (30 BYTE),
   NAZWA VARCHAR2 (30 BYTE),
   POLECENIE CLOB,
   DATA_STWORZENIA DATE,
   id_event NUMBER(6)
);

CREATE TABLE WYPOZYCZENIA_ARCHIWUM(
   ID_WYPOZYCZENIE NUMBER(6),
   ID_KLIENT NUMBER(6),
   ID_KSIAZKA NUMBER(6),
   ID_PRACOWNIK NUMBER(6),
   DATA_WYPOZYCZENIA DATE,
   DATA_ODDANIA DATE,
   DATA_ZWROTU DATE,
   KAUCJA NUMBER(6,2)
);

CREATE SEQUENCE pracownicy_seq;
CREATE SEQUENCE ksiazki_seq;
CREATE SEQUENCE klienci_seq;
CREATE SEQUENCE wypozyczenia_seq;
CREATE SEQUENCE autor_seq;
CREATE SEQUENCE history_seq;

INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Adam', 'Nowak', 'bibliotekarz', '1800', 'M');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Piotr', 'Kowalczyk', 'konserwator', '1500', 'M');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Magda', 'Kowalska', 'bibliotekarz', '1900', 'K');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Andrzej', 'Pi¹tek', 'pracownik techniczny', '1500', 'M');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Kamila', 'Borys', 'bibliotekarz', '2200', 'K');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Natalia', 'Kowalska', 'bibliotekarz', '2100', 'K');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Marian', 'Jankowski', 'pracownik techniczny', '1550', 'M');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Olga', 'Pieñ', 'bibliotekarz', '2000', 'K');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Micha³', 'Szpakowski', 'pracownik techniczny', '1500', 'M');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Dariusz', 'Piekoszewski', 'bibliotekarz', '2100', 'M');
INSERT INTO pracownicy 
VALUES (pracownicy_seq.nextval, 'Daniel', 'Markowski', 'administrator', '2600', 'M');

INSERT INTO uzytkownicy_bazy VALUES (1, 'adno', 'adno12');
INSERT INTO uzytkownicy_bazy VALUES (3, 'mako', 'mako12');
INSERT INTO uzytkownicy_bazy VALUES (5, 'kabo', 'kabo12');
INSERT INTO uzytkownicy_bazy VALUES (6, 'nako', 'nako12');
INSERT INTO uzytkownicy_bazy VALUES (8, 'olpi', 'olpi12');
INSERT INTO uzytkownicy_bazy VALUES (10, 'dapi', 'dapi12');
INSERT INTO uzytkownicy_bazy VALUES (11, 'dama', 'dama12');

INSERT INTO autor
VALUES (autor_seq.nextval, 'William', 'Shakespeare');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Adam', 'Mickiewicz');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Boleslaw', 'Prus');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Fiodor', 'Dostojewski');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Juliusz', 'Slowacki');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Rita', 'Monaldi');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Francesco', 'Sorti');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Jan', 'Kochanowski');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Ignacy', 'Krasicki');
INSERT INTO autor
VALUES (autor_seq.nextval, 'Maria', 'Konopnicka');

INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Artur', 'Lato', 'alato@gmail.com', '342-432-421');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Andrzej', 'Poniedzialek', 'apon@interia.pl', '111-442-401');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Józef', 'Orkisz', 'orkisz.j@wp.pl', '258-369-000');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Pawel', 'Rak', 'p.rak@o2.pl', '305-002-036');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Aleksander', 'Mickiewicz', 'mickiewicz@gmail.com', '895-222-021');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Wojciech', 'Naruszewicz', 'wojna@gmail.com', '235-123-621');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Marta', 'Na³kowska', 'marnal@wp.pl.com', '660-550-440');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Jaros³aw', 'Morsztyn', 'morek@onet.pl', '693-724-312');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Jacek', 'Krawczyk', 'jackra@gmail.com', '721-315-692');
INSERT INTO klienci (id_klient, imie_klient, nazwisko_klient, adres_email, nr_tel)
VALUES (klienci_seq.nextval, 'Natalia', 'Malikowska', 'malina@onet.pl', '684-357-631');

INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Pan Tadeusz', '1834', 'epos', 'Greg', 'EP/1', '25', '25');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Burza', '1611', 'komedia', 'PWN', 'KM/1', '9', '10');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Arab', '1830', 'poemat', 'Greg', 'PM/1', '27', '28');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Balladyna', '1834', 'dramat', 'Nowa Era', 'DM/1', '4', '6');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Sonety krymskie', '1828', 'sonet', 'Greg', 'SN/1', '1', '2');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Imprimatur', '2005', 'powieœæ', 'Bertelsmann Media', 'PW/1', '5', '7');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Kordian', '2006', 'dramat', 'Greg', 'DM/2', '9', '10');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Zbiór trenów', '2001', 'tren', 'Greg', 'TR/1', '14', '15');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Mendel Gdañski', '1998', 'nowela', 'Greg', 'NW/1', '10', '10');
INSERT INTO ksiazki
VALUES (ksiazki_seq.nextval, 'Nasza szkapa', '1998', 'nowela', 'Greg', 'NW/2', '9', '10');

INSERT INTO autorzy_ksiazek
VALUES ('6', '6');
INSERT INTO autorzy_ksiazek
VALUES ('7', '6');
INSERT INTO autorzy_ksiazek
VALUES ('1', '2');
INSERT INTO autorzy_ksiazek
VALUES ('2', '1');
INSERT INTO autorzy_ksiazek
VALUES ('5', '3');
INSERT INTO autorzy_ksiazek
VALUES ('5', '4');
INSERT INTO autorzy_ksiazek
VALUES ('2', '5');
INSERT INTO autorzy_ksiazek
VALUES ('5', '7');
INSERT INTO autorzy_ksiazek
VALUES ('8', '8');
INSERT INTO autorzy_ksiazek
VALUES ('10', '9');
INSERT INTO autorzy_ksiazek
VALUES ('10', '10');

--Wyzwalacz dodajacy wpis do archiwum po dokonaniu wypozyczenia
CREATE OR REPLACE TRIGGER archiwum_trigger
AFTER INSERT ON WYPOZYCZENIA
FOR EACH ROW
  BEGIN
        INSERT INTO WYPOZYCZENIA_ARCHIWUM(ID_WYPOZYCZENIE, ID_KLIENT, ID_KSIAZKA, ID_PRACOWNIK, DATA_WYPOZYCZENIA, DATA_ODDANIA)
        VALUES (:NEW.ID_WYPOZYCZENIE, :NEW.ID_KLIENT, :NEW.ID_KSIAZKA, :NEW.ID_PRACOWNIK, :NEW.DATA_WYPOZYCZENIA, :NEW.DATA_ODDANIA);
  END;
/

INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '1', '4', '3', '2016-02-11', '2017-02-02');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '4', '2', '1', '2016-01-01', '2016-01-03');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '5', '6', '5', '2016-03-20', '2016-06-20');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '4', '3', '1', '2016-10-01', '2016-01-01');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '4', '4', '3', '2016-08-15', '2016-10-25');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '10', '8', '6', '2016-11-15', '2017-01-15');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '7', '10', '8', '2016-11-16', '2017-01-16');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '8', '6', '5', '2016-11-18', '2017-01-18');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '9', '7', '10', '2016-11-19', '2017-01-19');
INSERT INTO wypozyczenia
VALUES (wypozyczenia_seq.nextval, '6', '5', '10', '2016-11-19', '2017-01-19');

--trigger zapisuj¹cy zmiany w strukturze bazy danych
CREATE OR REPLACE TRIGGER SCHEMA_HISTORY_TRG
AFTER DDL ON SCHEMA
DECLARE
    n PLS_INTEGER;
    vc_stmt CLOB;
    vt_sql_text ora_name_list_t;
BEGIN
    n := ora_sql_txt(vt_sql_text);   
    FOR i IN 1 .. n
    LOOP
        vc_stmt := vc_stmt || vt_sql_text(i);
    END LOOP;
     
    IF INSTR(UPPER(ora_sysevent), 'TRUNCATE') = 0 AND
       INSTR(UPPER(ora_dict_obj_type), 'PACKAGE') = 0 AND
       INSTR(UPPER(vc_stmt), 'COMPILE') = 0
    THEN
        INSERT INTO SCHEMA_HISTORY
          VALUES (ora_dict_obj_owner, ora_sysevent, ora_dict_obj_type,
                  ora_dict_obj_name, vc_stmt, SYSDATE, history_seq.nextval);
    END IF;
END;
/

--1w 1 - wyzwalacz ograniczaj¹cy liczbê po¿yczeñ do 5 przez tego samego klienta
CREATE OR REPLACE TRIGGER ograniczenie_liczby_pozyczen
BEFORE INSERT ON wypozyczenia
FOR EACH ROW
DECLARE
liczba_wypozyczonych_pozycji NUMBER(6);
v_id wypozyczenia.id_klient%TYPE;
BEGIN
SELECT count(*)
INTO liczba_wypozyczonych_pozycji
FROM wypozyczenia wyp
WHERE wyp.ID_KLIENT = :NEW.ID_KLIENT;
IF (liczba_wypozyczonych_pozycji > 5) THEN
RAISE_APPLICATION_ERROR(-20000, 'Klient o id = '||v_id||'ma wypozyczone juz 5 pozycji');
END IF;
END;
/

--2w 1 - wyzwalacz wyrzucaj¹cy b³¹d, podczas gdy chcielibyœmy wprowadziæ id pracownika do obs³ugi wypo¿yczenia, który nie jest "bibliotekarzem"
CREATE OR REPLACE TRIGGER czy_bibliotekarz
BEFORE INSERT ON wypozyczenia
FOR EACH ROW
DECLARE
v_stanowisko PRACOWNICY.STANOWISKO%TYPE;
stanowisko_bibliotekarz VARCHAR2(15) := 'bibliotekarz';
BEGIN
SELECT stanowisko
INTO v_stanowisko
FROM pracownicy pr
WHERE pr.ID_PRACOWNIK = :NEW.ID_PRACOWNIK;
IF (v_stanowisko != stanowisko_bibliotekarz) THEN
RAISE_APPLICATION_ERROR(-20000, 'Podany pracownik nie moze obluzyc klienta, gdyz nie jest zatrudniony na stanowisku bibliotekarz');
END IF;
END;
/

--Wyzwalacz aktualizujacy liczbe ksiazek po dokonaniu wypozyczenia oraz zwrotu ksiazki przez klienta
CREATE OR REPLACE TRIGGER aktualizacja_ilosci
AFTER INSERT OR DELETE ON wypozyczenia
REFERENCING NEW AS nowa OLD AS stara
FOR EACH ROW
DECLARE
v_liczba_ksiazek ksiazki.ilosc%TYPE;
BEGIN
CASE
WHEN INSERTING THEN
  select ilosc into v_liczba_ksiazek from ksiazki ks where ks.id_ksiazka = :nowa.id_ksiazka;
  IF((v_liczba_ksiazek - 1) >= 0) THEN
    update ksiazki set ilosc = ilosc-1 where id_ksiazka = :nowa.id_ksiazka;
  ELSE 
      RAISE_APPLICATION_ERROR(-2000, 'Nie mozna wypozyczyc ksiazki. Brak pozycji w bibliotece');
  END IF;
WHEN DELETING THEN
  update ksiazki set ilosc = ilosc+1 where id_ksiazka = :stara.id_ksiazka;
  END CASE;
END;
/



--Wyzwalacz + funkcja, z której korzysta, uruchamiajacy procedure obsluz_archiwum
CREATE OR REPLACE FUNCTION zwroc_kaucja(id_wyp NUMBER)
RETURN NUMBER
IS
caution NUMBER(6,2);
price CONSTANT NUMBER := 0.30;
date_give_back DATE;
to_late NUMBER(6);
today DATE := SYSDATE;
BEGIN
SELECT DATA_ODDANIA
INTO date_give_back
FROM WYPOZYCZENIA_ARCHIWUM wyp_arch
WHERE wyp_arch.ID_WYPOZYCZENIE = id_wyp;
to_late := Trunc(today - date_give_back);
IF(to_late > 0) THEN
  caution := to_late*price;
ELSE 
  RETURN 0;
END IF;
RETURN caution;
END;
/

--Wyzwalacz uruchamiajacy procedure obsluz_archiwum
CREATE OR REPLACE PROCEDURE obsluz_archiwum(id_wyp NUMBER, id_kl NUMBER)
AS
caution NUMBER(6,2) := zwroc_kaucja(id_wyp);
BEGIN
    UPDATE WYPOZYCZENIA_ARCHIWUM SET KAUCJA = caution WHERE ID_WYPOZYCZENIE = id_wyp;
    UPDATE WYPOZYCZENIA_ARCHIWUM SET DATA_ZWROTU = SYSDATE WHERE ID_WYPOZYCZENIE = id_wyp;
    UPDATE KLIENCI SET OPLATY = OPLATY + caution WHERE ID_KLIENT = id_kl;
END;
/

CREATE OR REPLACE TRIGGER oddanie_ksiazki
BEFORE DELETE ON WYPOZYCZENIA
REFERENCING OLD AS old
FOR EACH ROW
  BEGIN
    obsluz_archiwum(:old.ID_WYPOZYCZENIE, :old.ID_KLIENT);
  END;
/

--wyzwalacz typu LOGON usuwajacy wpisy starsze niz dwa lata z archiwum
CREATE OR REPLACE TRIGGER usun_stare_wpisy_trg
AFTER LOGON ON DATABASE
BEGIN
  DELETE FROM WYPOZYCZENIA_ARCHIWUM WHERE DATA_ZWROTU + INTERVAL '2' YEAR < SYSDATE;
END;
/

--Wyzwalacz zapamietujacy wszystkie operacje dokonywane na strukturze bazy danych
CREATE OR REPLACE TRIGGER usun_uzytkownika_bazy
BEFORE DELETE ON pracownicy
REFERENCING OLD AS stary
FOR EACH ROW
BEGIN
DELETE FROM UZYTKOWNICY_BAZY WHERE ID_PRACOWNIK = :stary.ID_PRACOWNIK;
END;
/

--Procedura, która doda tak¹ sam¹ liczbê do iloœci ksi¹¿ek z wydawnictwa o podanej przez parametr nazwie i iloœci, dostawa towaru
CREATE OR REPLACE PROCEDURE dostawa_towaru(wyd VARCHAR2, ile NUMBER)
AS
BEGIN
UPDATE KSIAZKI SET ILOSC_POSIADANA = ILOSC_POSIADANA + ile WHERE WYDAWNICTWO = wyd;
UPDATE KSIAZKI SET ILOSC= ILOSC + ile WHERE WYDAWNICTWO = wyd;
END;
/

--Procedura, która doda tak¹ sam¹ liczbê do iloœci ksi¹¿ek o podanej przez parametr nazwie i iloœci, dostawa ksi¹¿ek
CREATE OR REPLACE PROCEDURE dostawa_ksiazki(id_k NUMBER, ile NUMBER)
AS
BEGIN
UPDATE KSIAZKI SET ILOSC_POSIADANA = ILOSC_POSIADANA + ile WHERE ID_KSIAZKA = id_k;
UPDATE KSIAZKI SET ILOSC= ILOSC + ile WHERE ID_KSIAZKA = id_k;
END;
/

--Funkcja zwracajaca kaucje dla spóŸnialskich czytelników na podstawie naliczonej daty oddania ksi¹zki i dnia w którym ksi¹¿ka zostala fizycznie zwrocona do biblioteki
CREATE OR REPLACE FUNCTION zwroc_kaucja(id_wyp NUMBER)
RETURN NUMBER
IS
caution NUMBER(6,2);
price CONSTANT NUMBER := 0.30;
date_give_back DATE;
to_late NUMBER(6);
today DATE := SYSDATE;
BEGIN
SELECT DATA_ODDANIA
INTO date_give_back
FROM WYPOZYCZENIA_ARCHIWUM wyp_arch
WHERE wyp_arch.ID_WYPOZYCZENIE = id_wyp;
to_late := Trunc(today - date_give_back);
IF(to_late > 0) THEN
  caution := to_late*price;
ELSE 
  RETURN 0;
END IF;
RETURN caution;
END;
/

--Procedura oblugujaca zdarzenie w archiwum polegajace na zwrocie ksiazki do bilioteki, tj. wpisanie do archiwum kiedy oddal ksiazke i na tej podstawie 
--naliczona(lub nie) kaucja oraz odpowiednie aktualizowanie rekordow w bazie.
CREATE OR REPLACE PROCEDURE obsluz_archiwum(id_wyp NUMBER, id_kl NUMBER)
AS
caution NUMBER(6,2) := zwroc_kaucja(id_wyp);
BEGIN
    UPDATE WYPOZYCZENIA_ARCHIWUM SET KAUCJA = caution WHERE ID_WYPOZYCZENIE = id_wyp;
    UPDATE WYPOZYCZENIA_ARCHIWUM SET DATA_ZWROTU = SYSDATE WHERE ID_WYPOZYCZENIE = id_wyp;
    UPDATE KLIENCI SET OPLATY = OPLATY + caution WHERE ID_KLIENT = id_kl;
END;
/

--Funkcja dokonujaca uiszczenia oplaty i wypisuj¹ca komunikat o przyjêtej kwocie i zwroconej reszcie
CREATE OR REPLACE PROCEDURE uiszczenie_oplaty(id_kl NUMBER, oplata NUMBER)
AS 
SQL_STAT VARCHAR2(250);
v_kwota KLIENCI.OPLATY%TYPE;
BEGIN
SELECT oplaty
INTO v_kwota
FROM KLIENCI kl
WHERE kl.id_klient = id_kl;
IF(v_kwota >= oplata) THEN
SQL_STAT := 'UPDATE klienci SET oplaty = oplaty - '||oplata||'WHERE id_klient = '||id_kl;
DBMS_OUTPUT.PUT_LINE('Uiszczono oplate w wysokosci '||oplata||'zl');
ELSE 
SQL_STAT := 'UPDATE klienci SET oplaty = oplaty - '||v_kwota||'WHERE id_klient = '||id_kl;
DBMS_OUTPUT.PUT_LINE('Uiszczono oplate w wysokosci '||v_kwota||'zl i zwrocono reszte w wysokosci '||(oplata-v_kwota)||'zl');
END IF;
EXECUTE IMMEDIATE SQL_STAT;
END;
/

--Funkcje losujace czas
CREATE OR REPLACE FUNCTION set_random_date_for_borrow
RETURN DATE
IS
diviner NUMBER(6) := 3650;
BEGIN
RETURN TO_DATE('2007-01-15') + SYS.DBMS_RANDOM.VALUE(0, diviner);
END;
/

CREATE OR REPLACE FUNCTION set_random_date_for_return(date_borrow DATE)
RETURN DATE
IS
diviner NUMBER(6) := 365;
BEGIN
RETURN date_borrow + SYS.DBMS_RANDOM.VALUE(0, diviner);
END;
/

--Procedura dodajaca wypozyczenie o zadanym id klienta id ksiazki i id pracownika, ktory dokonal transakcji wypozyczenia
CREATE OR REPLACE PROCEDURE dodaj_wypozyczenie(p_id_klienta IN NUMBER, p_id_ksiazki IN NUMBER, p_id_pracownika IN NUMBER)
IS
  aktualna_data DATE := SYSDATE;
  obliczona_data DATE := ADD_MONTHS(aktualna_data, 3);
BEGIN
  IF p_id_klienta IS NULL OR p_id_ksiazki IS NULL or p_id_pracownika IS NULL
    THEN
    RAISE_APPLICATION_ERROR(-20001,'Nie podano wszystkich wartosci!');
  ELSE
    INSERT INTO WYPOZYCZENIA VALUES (wypozyczenia_seq.nextval, p_id_klienta, p_id_ksiazki, p_id_pracownika, aktualna_data, obliczona_data);
  END IF;
END;
/

--Procedura dodajaca wypozyczenie o losowej dacie wypozyczenia i losowej dacie zwrotu ksiazki(maksymalnie do roku w przód)
CREATE OR REPLACE PROCEDURE dodaj_wypozyczenie_random(p_id_klienta IN NUMBER, 
                p_id_ksiazki IN NUMBER, p_id_pracownika IN NUMBER)
IS
  aktualna_data DATE := set_random_date_for_borrow;
  obliczona_data DATE := set_random_date_for_return(aktualna_data);
BEGIN
    INSERT INTO WYPOZYCZENIA VALUES (wypozyczenia_seq.nextval, p_id_klienta, p_id_ksiazki, p_id_pracownika, aktualna_data, obliczona_data);
END;
/