/*

Datentypen in SQL:

Numerisch:

int/integer = Ganzzahl

tinyint (8bit): bis 255
smallint (16bit): bis 32k
int: bis 2Mrd.
bigint: groﬂ

bit: 1/0

decimal(x,y): x = Anzahl Stellen gesamt; davon y Nachkommastellen
decimal(5,2): 999,99

float: variable Nachkommastellen, bzw. wie geht

binary: Bin‰rcode


Strings/Character:
char(10): 'Nico      '
nchar(X)
varchar(bis 8000): 'Nico'
nvarchar(bis 4000)

text (legacy)
image (legacy)
varchar(MAX)


Datum:
date: YYYY.MM.DD
time: HH.MM.SS.MS
datetime: Kombination aus date & time; bis MS Bereich
(datetime2: Bis NS Bereich)
smalldatetime: pr‰zision bis Sek.


Andere:
XML
JSON
geometry
geography