drop view if exists Query1;
create view Query1 as
select f.id, f.nome
from Fornitore f
where exists (
    select *
    from Fornitore f1 join RisorsaAlimentare a on (f1.id=a.idFornitore)
    where f.id=f1.id and a.idFornitore in (
         select idFornitore
         from RisorsaMedica
         )
	);
    

drop view if exists Query2;
create view Query2 as
select distinct f.nome
from Fornitore f join RisorsaAlimentare m on (f.id = m.idFornitore) 
where m.dataScadenza >= '2019-03-01' and f.id not in (
	select idFornitore
	from RisorsaMedica
	);
    

drop view if exists Query3;
create view Query3 as
select c.nome, c.cognome
from Cliente c
where exists(
      select *
      from Prenotazione p join Impiegato i on ( p.idImpiegato = i.id)
      where c.email = p.email and p.idImpiegato <> any (
			select p1.idImpiegato
            from Prenotazione p1 join Impiegato i1 on ( p1.idImpiegato = i1.id)
            where p.email = p1.email
            )
	  );


drop view if exists Query4;
create view Query4 as
select r.nome, count(*) as numeroUsi 
from RisorsaMedica r, Visita v
where r.id = v.medica
group by r.nome;


delimiter $
drop function if exists PrezzoTotaleRisorsa;
CREATE FUNCTION PrezzoTotaleRisorsa (Id_ris INT)
RETURNS INT
BEGIN
DECLARE Totale INT ;
SELECT sum(r.prezzo) INTO Totale
FROM RisorsaMedica r JOIN Visita v ON(r.id= v.medica)
where Id_ris = id
GROUP BY r.id;
RETURN Totale;
END $ 


delimiter $
drop procedure if exists NumeroVisite;
create procedure NumeroVisite( Id_Impiegato int)
begin
select count(*) as Visite
from Visita
where idImpiegato = Id_Impiegato and year(dataVisita) = year(now()) - 1;
end $


delimiter $
drop procedure if exists volpi_settore;
create procedure volpi_settore(Id_Impiegato int)
begin
select count(*) as Numero
from  Volpe v1 join Specie s1 on (v1.idSpecie = s1.id ) join Settore r on ( s1.id = r.specie ) join Guardia on (r.nome = settore)
where idImpiegato = Id_Impiegato;
end $


delimiter $
drop function if exists mangiaVolpi;
create function mangiaVolpi (Id_Alimento int)
returns int
begin 
declare num int;
select count(*) into num
from Volpe v join Specie s on ( v.idSpecie = s.id)
where s.idRisorsa = Id_Alimento;
return num; 
end $



