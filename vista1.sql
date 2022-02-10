CREATE VIEW `view1` AS
select idProductoElaboracion 
from ProductoElaboracion PE, Porcentages P, AlimentoElaborado AE, SeElaboraEn SEE, PlantaElaboracion PE2, LugarTrabajo LT
where PE.idProductoElaboracion = P.ProductoElaboracion && AE.IDAlimento = P.AlimentoElaborado && AE.IDAlimento = SEE.IDAlimento && PE2.idPlantaElaboracion = SEE.idPlantaElaboracion && PE2.idPlantaElaboracion = LT.idLugar 
&& LT.Pais like 'Spain';