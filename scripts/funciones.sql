DROP FUNCTION IF EXISTS FUN_GUARDARINVENTARIO(IN INTEGER, IN CHARACTER VARYING(50), IN CHARACTER VARYING(70), IN INTEGER);
CREATE OR REPLACE FUNCTION FUN_GUARDARINVENTARIO(IN INTEGER, IN CHARACTER VARYING(50), IN CHARACTER VARYING(70), IN INTEGER)
RETURNS SMALLINT AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: guardar inventario
--------------------------------------------------------------------------------	
DECLARE 
	iSKU 				ALIAS FOR $1; 
	sNombreArticulo 	ALIAS FOR $2;
	sDescripionArticulo	ALIAS FOR $3;
	iCantidad			ALIAS FOR $4;
BEGIN
	IF EXISTS(SELECT 1 FROM ctl_inventario WHERE sku = iSKU) THEN
		UPDATE ctl_inventario SET nombre_articulo = sNombreArticulo, descripcion_articulo = sDescripionArticulo, cantidad = iCantidad 
		WHERE sku = iSKU;
		
		RETURN 2;
	ELSE
		IF iSku > 0 THEN
			INSERT INTO ctl_inventario(sku, nombre_articulo, descripcion_articulo, cantidad, fechamovto)
			VALUES (iSKU, sNombreArticulo, sDescripionArticulo, iCantidad, CURRENT_TIMESTAMP);
		
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_GUARDARINVENTARIO(IN INTEGER, IN CHARACTER VARYING(50), IN CHARACTER VARYING(70), IN INTEGER) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_GUARDARINVENTARIO(IN INTEGER, IN CHARACTER VARYING(50), IN CHARACTER VARYING(70), IN INTEGER) TO public;
GRANT EXECUTE ON FUNCTION FUN_GUARDARINVENTARIO(IN INTEGER, IN CHARACTER VARYING(50), IN CHARACTER VARYING(70), IN INTEGER) TO postgres;


DROP FUNCTION IF EXISTS FUN_ELIMINARINVENTARIO(IN INTEGER);
CREATE OR REPLACE FUNCTION FUN_ELIMINARINVENTARIO(IN INTEGER)
RETURNS SMALLINT AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: eliminar inventario
--------------------------------------------------------------------------------	
DECLARE 
	iSKU	ALIAS FOR $1; 
BEGIN
	IF EXISTS(SELECT 1 FROM ctl_inventario WHERE sku = iSKU) THEN
		DELETE FROM ctl_inventario WHERE sku = iSKU;
		RETURN 3;
	END IF; 
	
	RETURN 0;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_ELIMINARINVENTARIO(IN INTEGER) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_ELIMINARINVENTARIO(IN INTEGER) TO public;
GRANT EXECUTE ON FUNCTION FUN_ELIMINARINVENTARIO(IN INTEGER) TO postgres;


DROP FUNCTION IF EXISTS FUN_CONSULTARINVENTARIO(IN INTEGER);
CREATE OR REPLACE FUNCTION FUN_CONSULTARINVENTARIO(IN INTEGER)
RETURNS TABLE(
	sku 				    INTEGER, 
	nombre_articulo			CHARACTER VARYING(50), 
	descripcion_articulo	CHARACTER VARYING(70), 
	cantidad				INTEGER, 
	fechamovto				TIMESTAMP WITHOUT TIME ZONE
) AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: consultar inventario
--------------------------------------------------------------------------------	
DECLARE 
	iSKU	ALIAS FOR $1; 
BEGIN
	IF iSKU > 0 THEN
		RETURN QUERY
		SELECT c.sku, c.nombre_articulo, c.descripcion_articulo, c.cantidad, c.fechamovto 
		FROM ctl_inventario AS c WHERE c.sku = iSKU;
	ELSE
		RETURN QUERY
		SELECT c.sku, c.nombre_articulo, c.descripcion_articulo, c.cantidad, c.fechamovto 
		FROM ctl_inventario AS c;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_CONSULTARINVENTARIO(IN INTEGER) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_CONSULTARINVENTARIO(IN INTEGER) TO public;
GRANT EXECUTE ON FUNCTION FUN_CONSULTARINVENTARIO(IN INTEGER) TO postgres;


DROP FUNCTION IF EXISTS FUN_GUARDAREMPLEADO(IN INTEGER, IN CHARACTER VARYING(30), IN CHARACTER VARYING(50), IN CHARACTER VARYING(30));
CREATE OR REPLACE FUNCTION FUN_GUARDAREMPLEADO(IN INTEGER, IN CHARACTER VARYING(30), IN CHARACTER VARYING(50), IN CHARACTER VARYING(30))
RETURNS SMALLINT AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: guardar empleado
--------------------------------------------------------------------------------	
DECLARE 
	id			ALIAS FOR $1;
	sNombre   	ALIAS FOR $2;
	sApellido	ALIAS FOR $3;
	sPuesto     ALIAS FOR $4;
BEGIN
	IF EXISTS(SELECT 1 FROM ctl_empleado WHERE idEmpleado = id) THEN
		UPDATE ctl_empleado SET nombre = sNombre, apellido = sApellido, puesto = sPuesto 
		WHERE idempleado = id;
		
		RETURN 2;
	ELSE
		INSERT INTO ctl_empleado(idEmpleado, nombre, apellido, puesto, fechamovto)
		VALUES (id, sNombre, sApellido, sPuesto, CURRENT_TIMESTAMP);
		
		RETURN 1;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_GUARDAREMPLEADO(IN INTEGER, IN CHARACTER VARYING(30), IN CHARACTER VARYING(50), IN CHARACTER VARYING(30)) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_GUARDAREMPLEADO(IN INTEGER, IN CHARACTER VARYING(30), IN CHARACTER VARYING(50), IN CHARACTER VARYING(30)) TO public;
GRANT EXECUTE ON FUNCTION FUN_GUARDAREMPLEADO(IN INTEGER, IN CHARACTER VARYING(30), IN CHARACTER VARYING(50), IN CHARACTER VARYING(30)) TO postgres;


DROP FUNCTION IF EXISTS FUN_ELIMINAREMPLEADO(IN INTEGER);
CREATE OR REPLACE FUNCTION FUN_ELIMINAREMPLEADO(IN INTEGER)
RETURNS SMALLINT AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: eliminar empleado
--------------------------------------------------------------------------------	
DECLARE 
	id	ALIAS FOR $1; 
BEGIN
	IF EXISTS(SELECT 1 FROM ctl_empleado WHERE idempleado = id) THEN
		DELETE FROM ctl_empleado WHERE idEmpleado = id;
		RETURN 3;
	ELSE 
		RETURN 0;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_ELIMINAREMPLEADO(IN INTEGER) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_ELIMINAREMPLEADO(IN INTEGER) TO public;
GRANT EXECUTE ON FUNCTION FUN_ELIMINAREMPLEADO(IN INTEGER) TO postgres;


DROP FUNCTION IF EXISTS FUN_CONSULTAREMPLEADO(IN INTEGER);
CREATE OR REPLACE FUNCTION FUN_CONSULTAREMPLEADO(IN INTEGER)
RETURNS TABLE(
	idEmpleado	INTEGER, 
	nombre		CHARACTER VARYING(30), 
	apellido	CHARACTER VARYING(50), 
	puesto		CHARACTER VARYING(30), 
	fechamovto	TIMESTAMP WITHOUT TIME ZONE
) AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: consultar empleado
--------------------------------------------------------------------------------	
DECLARE 
	id	ALIAS FOR $1; 
BEGIN
	IF id > 0 THEN
		RETURN QUERY
		SELECT ce.idEmpleado, ce.nombre, ce.apellido, ce.puesto, ce.fechamovto 
		FROM ctl_empleado AS ce WHERE idempleado = id;
	ELSE
		RETURN QUERY
		SELECT ce.idempleado, ce.nombre, ce.apellido, ce.puesto, ce.fechamovto 
		FROM ctl_empleado AS ce;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_CONSULTAREMPLEADO(IN INTEGER) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_CONSULTAREMPLEADO(IN INTEGER) TO public;
GRANT EXECUTE ON FUNCTION FUN_CONSULTAREMPLEADO(IN INTEGER) TO postgres;


DROP FUNCTION IF EXISTS FUN_GUARDARPOLIZA(IN INTEGER, IN CHARACTER VARYING(50), IN INTEGER, IN INTEGER, IN INTEGER);
CREATE OR REPLACE FUNCTION FUN_GUARDARPOLIZA(IN INTEGER, IN CHARACTER VARYING(50), IN INTEGER, IN INTEGER, IN INTEGER)
RETURNS SMALLINT AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: guardar poliza
--------------------------------------------------------------------------------	
DECLARE 
	id 				ALIAS FOR $1;
	sNombreCliente	ALIAS FOR $2;
	sEmpleadoGenero	ALIAS FOR $3;
	iSKU     		ALIAS FOR $4;
	iCantidad 		ALIAS FOR $5;
BEGIN
	IF EXISTS(SELECT 1 FROM ctl_polizas WHERE idpoliza = id) THEN
		UPDATE ctl_polizas SET nombre_cliente = sNombreCliente, empleado_genero = sEmpleadoGenero, sku = iSKU, cantidad = iCantidad
		WHERE idpoliza = id;
		
		RETURN 2;
	ELSE
		INSERT INTO ctl_polizas(idpoliza, nombre_cliente, empleado_genero, sku, cantidad, fechamovto)
		VALUES (id, sNombreCliente, sEmpleadoGenero, iSKU, iCantidad, CURRENT_TIMESTAMP);
		
		RETURN 1;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_GUARDARPOLIZA(IN INTEGER, IN CHARACTER VARYING(50), IN INTEGER, IN INTEGER, IN INTEGER) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_GUARDARPOLIZA(IN INTEGER, IN CHARACTER VARYING(50), IN INTEGER, IN INTEGER, IN INTEGER) TO public;
GRANT EXECUTE ON FUNCTION FUN_GUARDARPOLIZA(IN INTEGER, IN CHARACTER VARYING(50), IN INTEGER, IN INTEGER, IN INTEGER) TO postgres;


DROP FUNCTION IF EXISTS FUN_ELIMINARPOLIZA(IN INTEGER);
CREATE OR REPLACE FUNCTION FUN_ELIMINARPOLIZA(IN INTEGER)
RETURNS SMALLINT AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: eliminar poliza
--------------------------------------------------------------------------------	
DECLARE 
	id	ALIAS FOR $1; 
BEGIN
	IF EXISTS(SELECT 1 FROM ctl_polizas WHERE idpoliza = idPoliza) THEN
		DELETE FROM ctl_polizas WHERE idpoliza = id;
		RETURN 3;
	ELSE 
		RETURN 0;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_ELIMINARPOLIZA(IN INTEGER) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_ELIMINARPOLIZA(IN INTEGER) TO public;
GRANT EXECUTE ON FUNCTION FUN_ELIMINARPOLIZA(IN INTEGER) TO postgres;


DROP FUNCTION IF EXISTS FUN_CONSULTARPOLIZA(IN INTEGER);
CREATE OR REPLACE FUNCTION FUN_CONSULTARPOLIZA(IN INTEGER)
RETURNS TABLE(
	idPoliza			 INTEGER, 
	nombre_cliente		 CHARACTER VARYING(50), 
	empleado_genero		 INTEGER, 
	nombre          	 CHARACTER VARYING(30),
	apellido        	 CHARACTER VARYING(50),
	puesto               CHARACTER VARYING(50),
	sku					 INTEGER,
	nombre_articulo 	 CHARACTER VARYING(50),
	descripcion_articulo CHARACTER VARYING(70),
	cantidad			 INTEGER,
	fechamovto	    	 TIMESTAMP WITHOUT TIME ZONE
) AS
$BODY$
--------------------------------------------------------------------------------
	--AUTOR : Jesus Roberto Hernandez Gallegos.
	--DESCRIPCION: consultar empleado
--------------------------------------------------------------------------------	
DECLARE 
	id	ALIAS FOR $1; 
BEGIN
	IF id > 0 THEN
		RETURN QUERY
		SELECT pls.idPoliza, pls.nombre_cliente, pls.empleado_genero, emp.nombre, 
		emp.apellido, emp.puesto, pls.sku, inv.nombre_articulo, inv.descripcion_articulo, pls.cantidad, pls.fechamovto
		FROM ctl_polizas AS pls 
		INNER JOIN ctl_empleado AS emp ON pls.empleado_genero = emp.idempleado 
		INNER JOIN ctl_inventario AS inv ON pls.sku = inv.sku
		WHERE pls.idPoliza = id;
	ELSE
		RETURN QUERY
		SELECT pls.idPoliza, pls.nombre_cliente, pls.empleado_genero, emp.nombre, 
		emp.apellido, emp.puesto, pls.sku, inv.nombre_articulo, inv.descripcion_articulo, pls.cantidad, pls.fechamovto
		FROM ctl_polizas AS pls 
		INNER JOIN ctl_empleado AS emp ON pls.empleado_genero = emp.idempleado 
		INNER JOIN ctl_inventario AS inv ON pls.sku = inv.sku;
	END IF;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;
ALTER FUNCTION FUN_CONSULTARPOLIZA(IN INTEGER) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION FUN_CONSULTARPOLIZA(IN INTEGER) TO public;
GRANT EXECUTE ON FUNCTION FUN_CONSULTARPOLIZA(IN INTEGER) TO postgres;


--=========================================================================
--select * from ctl_inventario limit 10
--select * from ctl_empleado limit 10
--select * from ctl_polizas limit 10

--SELECT FUN_GUARDARINVENTARIO FROM FUN_GUARDARINVENTARIO (232323, 'PATINETA', 'PATINETA PARA SKATERS', 10);
--SELECT FUN_ELIMINARINVENTARIO FROM FUN_ELIMINARINVENTARIO(232323);
--SELECT sku, nombre_articulo, descripcion_articulo, cantidad, fechamovto FROM FUN_CONSULTARINVENTARIO(232323);

--SELECT FUN_GUARDAREMPLEADO FROM FUN_GUARDAREMPLEADO(90222124, 'JESUS', 'GALLEGOS', 'DESARROLLADOR');
--SELECT FUN_ELIMINAREMPLEADO FROM FUN_ELIMINAREMPLEADO(90222124);
--SELECT idempleado, nombre, apellido, puesto, fechamovto FROM FUN_CONSULTAREMPLEADO(90222124);

--SELECT FUN_GUARDARPOLIZA FROM FUN_GUARDARPOLIZA(15154, 'Jesus Roberto', 90222124, 232323, 5);
--SELECT FUN_ELIMINARPOLIZA FROM FUN_ELIMINARPOLIZA(15154);
--SELECT idpoliza, nombre_cliente, empleado_genero, nombre, apellido, sku, nombre_articulo, description_articulo, cantidad, fechamovto FROM FUN_CONSULTARPOLIZA(15154);
--=========================================================================