use alimentoselaborados;

DROP function if exists lote_precio_mayor_dia;

delimiter $$
create function lote_precio_mayor_dia (alimento int) returns int deterministic
begin
	declare a int default 0;
	select l.idLote into a 
	from lote l 
	where l.IDAlimento = alimento and l.PrecioVenta = (select max(l.PrecioVenta) 
	from lote l 
	where l.IDAlimento = alimento);
	return a;
end$$
delimiter ;

select lote_precio_mayor_dia (19);

DROP function if exists que_tipo_de_lugar_es;

delimiter $$
create function que_tipo_de_lugar_es (lugar int) returns enum('local','planta de elaboracion','no determinado') deterministic
begin
	declare a enum('local','planta de elaboracion','no determinado');
	declare b int;
	declare c int;
	select p.idPlantaElaboracion 
	into b
	from plantaelaboracion p  
	where p.idPlantaElaboracion = lugar;
	select l.idLocal  
	into c
	from `local` l   
	where l.idLocal  = lugar;
	case 
		when b = lugar then 
			set a = 'planta de elaboracion';
		when c = lugar then 
			set a = 'local';
		else
			set a = 'no determinado';
		end case;
	return a;
end$$
delimiter ;

select que_tipo_de_lugar_es (150);*/

Drop procedure if exists prefijos_telefonicos;




delimiter $$
create procedure prefijos_telefonicos () 
begin
	declare done INT default false;
	declare a varchar(45);
	declare b int;
	declare cur1 cursor for select l.Pais, l.idLugar from lugartrabajo l ;
	declare continue HANDLER for not found set done = true;
	open cur1;
	while done = false do
		fetch cur1 into a, b;
		if done = false then
			case a
				when 'United Stades' then 
					update alimentoselaborados.lugartrabajo set Telefono = concat('+1 ', Telefono) where idLugar = b;
				when 'Spain' then 
					update alimentoselaborados.lugartrabajo set Telefono = concat('+34 ', Telefono) where idLugar = b;
				when 'Argentina' then 
					update alimentoselaborados.lugartrabajo set Telefono = concat('+54 ', Telefono) where idLugar = b;
				when 'Mexico' then 
					update alimentoselaborados.lugartrabajo set Telefono = concat('+52 ', Telefono) where idLugar = b;
				when 'France' then 
					update alimentoselaborados.lugartrabajo set Telefono = concat('+33 ', Telefono) where idLugar = b;
				when 'United Kingdom' then 
					update alimentoselaborados.lugartrabajo set Telefono = concat('+44 ', Telefono) where idLugar = b;
			end case;
		end if;
	end while;
	close cur1 ;
end$$
delimiter ;

-- sp 34
-- argentina 54
-- france 33
-- united stades 1
-- mex 52
-- uk 44

call prefijos_telefonicos ();

drop procedure if exists descuento ;

delimiter $$
create procedure descuento (alimento int) 
begin
	declare a int;
	select lote_precio_mayor_dia(alimento) into a;
	update alimentoselaborados.lote l set l.PrecioVenta = l.PrecioVenta * 0.95 where l.idLote = a;
end$$
delimiter ;

call descuento (19);


drop procedure if exists add_descripcion  ;

delimiter $$
create procedure add_descripcion (alimento int, nueva_descripcion longtext) 
begin
	update alimentoselaborados.lote set Descripcion = nueva_descripcion where IDAlimento = alimento;
	update alimentoselaborados.alimentoelaborado set Descripcion = nueva_descripcion where IDAlimento = alimento;
end$$
delimiter ;

call add_descripcion (19, 'Tostadas francesas');


drop trigger if exists descuento_de_mas_de_cien  ;

delimiter $$ 
create trigger descuento_de_mas_de_cien before insert on lote for each row
begin 
	if (new.PrecioVenta >= 100) then
		set new.PrecioVenta = new.PrecioVenta * 0.9  ;
	end if;
end$$ 
delimiter ;


insert into lote values(134543, 45, 500, 9, '2021-04-09', '2022-07-28', 'vgvvgvhj', 110);

drop trigger if exists maximo_de_porcentajes;

delimiter $$
create trigger maximo_de_porcentajes before insert on porcentages for each row
begin
	declare a decimal;
	select sum(porcentages) 
	into a 
	from porcentages 
	where porcentages.AlimentoElaborado = new.alimentoelaborado 
	group by porcentages.AlimentoElaborado ;
	if((a + new.porcentages) > 100) then
		set new.porcentages = 100 - a ;
	end if;
end$$
delimiter ;

insert into porcentages values(1,1,90);
insert into porcentages values(2,1,90);













