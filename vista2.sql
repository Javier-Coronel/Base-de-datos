create view `view2` as
select LT.*
from
LugarTrabajo LT
inner join PlantaElaboracion PE
on LT.idLugar = PE.idPlantaElaboracion
inner join Lote L2
on L2.PlantaElaboracion=idPlantaElaboracion
where Year(L2.FechaCaducidad)=2022
group by LT.idLugar;
