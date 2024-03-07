--=========================================================================
--Elaboro  : Jesus Roberto Hernandez Gallegos
--Descripcion: Creacion de tabla 'ctl_inventario'
--=========================================================================
DO
$$
DECLARE
BEGIN
	IF EXISTS (SELECT FROM pg_catalog.pg_tables WHERE schemaname = 'public' AND tablename = 'ctl_inventario') THEN
		DROP TABLE public.ctl_inventario;
	END IF;
	
	CREATE TABLE public.ctl_inventario 
	(
		sku 				 	INTEGER NOT NULL,
		nombre_articulo 	 	CHARACTER VARYING(50),
		descripcion_articulo	CHARACTER VARYING(70),
		cantidad 			 	INTEGER NOT NULL,
		fechamovto 			 	TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
		CONSTRAINT inventario_pkey PRIMARY KEY (sku)
	);
	
	GRANT ALL ON TABLE ctl_inventario TO postgres;
	
	COMMENT ON TABLE ctl_inventario IS 'Se crea tabla para el catalogo de inventario';

	COMMENT ON COLUMN ctl_inventario.sku IS 'Guarda el número del sku';

	COMMENT ON COLUMN ctl_inventario.nombre_articulo IS 'Guarda el nombre del sku';
	
	COMMENT ON COLUMN ctl_inventario.descripcion_articulo IS 'Guarda la descripcion del articulo';
	
	COMMENT ON COLUMN ctl_inventario.cantidad IS 'Guarda la cantidad de unidades del articulo';

	COMMENT ON COLUMN ctl_inventario.fechamovto IS 'Guarda la fecha en la que se agrego el articulo al inventario';
END;
$$;

--=========================================================================
--Elaboro  : Jesus Roberto Hernandez Gallegos
--Descripcion: Creacion de tabla 'ctl_empleado'
--=========================================================================
DO
$$
DECLARE
BEGIN
	IF EXISTS (SELECT FROM pg_catalog.pg_tables WHERE schemaname = 'public' AND tablename = 'ctl_empleado') THEN
		DROP TABLE public.ctl_empleado;
	END IF;
	
	CREATE TABLE public.ctl_empleado
	(
		idEmpleado		  INTEGER NOT NULL,
		nombre   		  CHARACTER VARYING(30) NOT NULL,
		apellido          CHARACTER VARYING(50) NOT NULL,
		puesto 		      CHARACTER VARYING(30) NOT NULL,
		fechamovto        TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
		CONSTRAINT empleado_pkey PRIMARY KEY (idEmpleado)
	);
	
	GRANT ALL ON TABLE ctl_empleado TO postgres;

	COMMENT ON TABLE ctl_empleado IS 'Se crea tabla para el catalogo de empleados';

	COMMENT ON COLUMN ctl_empleado.idEmpleado IS 'Guarda el número del empleado';

	COMMENT ON COLUMN ctl_empleado.nombre IS 'Guarda el nombre del empleado';
	
	COMMENT ON COLUMN ctl_empleado.apellido IS 'Guarda el apellido del empleado';
	
	COMMENT ON COLUMN ctl_empleado.puesto IS 'Guarda el puesto del empleado';
		  
	COMMENT ON COLUMN ctl_empleado.fechamovto IS 'Guarda la fecha en la que se agrego el articulo al inventario';
END;
$$;

--=========================================================================
--Elaboro  : Jesus Roberto Hernandez Gallegos
--Descripcion: Creacion de tabla 'ctl_polizas'
--=========================================================================
DO
$$
DECLARE
BEGIN
	IF EXISTS (SELECT FROM pg_catalog.pg_tables WHERE schemaname = 'public' AND tablename = 'ctl_polizas') THEN
		DROP TABLE public.ctl_polizas;
	END IF;
	
	CREATE TABLE public.ctl_polizas
	(
		idPoliza		INTEGER NOT NULL,
		nombre_cliente 	CHARACTER VARYING(50),
		empleado_genero INTEGER NOT NULL,
		sku 			INTEGER NOT NULL,
		cantidad 		INTEGER NOT NULL,
		fechamovto      TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
		CONSTRAINT ctl_polizas_pkey PRIMARY KEY (idPoliza)
	);
	
	GRANT ALL ON TABLE ctl_polizas TO postgres;
	
	COMMENT ON TABLE ctl_polizas IS 'Se crea catalogo de empleado';

	COMMENT ON COLUMN ctl_polizas.idPoliza IS 'Guarda el número de la poliza';

	COMMENT ON COLUMN ctl_polizas.nombre_cliente IS 'Guarda el nombre del cliente asignado a la poliza';
	
	COMMENT ON COLUMN ctl_polizas.empleado_genero IS 'Guarda el empleado que genero la poliza';
	
	COMMENT ON COLUMN ctl_polizas.sku IS 'Guarda el sku de poliza';
	
	COMMENT ON COLUMN ctl_polizas.cantidad IS 'Guarda la cantidad qde poliza';

	COMMENT ON COLUMN ctl_polizas.fechamovto IS 'Guarda la fecha de la creacion de la poliza';
END;
$$;