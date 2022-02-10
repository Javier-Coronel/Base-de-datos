CREATE VIEW `view1` AS
    SELECT 
        PE.*
    FROM
        ProductoElaboracion PE,
        Porcentages P,
        AlimentoElaborado AE,
        SeElaboraEn SEE,
        PlantaElaboracion PE2,
        LugarTrabajo LT
    WHERE
        PE.idProductoElaboracion = P.ProductoElaboracion
            && AE.IDAlimento = P.AlimentoElaborado
            && AE.IDAlimento = SEE.IDAlimento
            && PE2.idPlantaElaboracion = SEE.idPlantaElaboracion
            && PE2.idPlantaElaboracion = LT.idLugar
            && LT.Pais LIKE 'Spain';