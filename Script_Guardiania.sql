-- Database: Empresa_Guardiania

-- DROP DATABASE "Empresa_Guardiania";

CREATE DATABASE "Empresa_Guardiania"

/*==============================================================*/
/* Table: Empresa                                               */
/*==============================================================*/
create table Empresa 
(
   Id_empresa           integer                        not null,
   Nombre_empresa       varchar(20)                    null,
   Ruc                  numeric                        null,
   Pagina_web           varchar(50)                    null,
   Contacto             numeric                        null,
   constraint PK_EMPRESA primary key (Id_empresa)
);
/*==============================================================*/
/* Table: Entrenamiento                                         */
/*==============================================================*/
create table Entrenamiento 
(
   Id_entrenamiento     integer                        not null,
   Fecha_inicio         date                           null,
   Fecha_final          date                           null,
   Duracion             varchar(20)                    null,
   Costo                numeric                        null,
   constraint PK_ENTRENAMIENTO primary key (Id_entrenamiento)
);
/*==============================================================*/
/* Table: Equipo                                                */
/*==============================================================*/
create table Equipo 
(
   Id_equipo            integer                        not null,
   Nombre_equipo        varchar(20)                    null,
   Descripcion_equipo   varchar(60)                    null,
   constraint PK_EQUIPO primary key (Id_equipo)
);

/*==============================================================*/
/* Table: Grado_Ascenso                                         */
/*==============================================================*/
create table Grado_Ascenso 
(
   Id_grado             integer                        not null,
   Nombre_grado         varchar(15)                    null,
   Descripcion          varchar(40)                    null,
   constraint PK_GRADO_ASCENSO primary key (Id_grado)
);

/*==============================================================*/
/* Table: Horario                                               */
/*==============================================================*/
create table Horario 
(
   Id_Horario           integer                        not null,
   Inicio_jornada       time                           null,
   Fin_jornada          time                           null,
   constraint PK_HORARIO primary key (Id_Horario)
);
/*==============================================================*/
/* Table: Parte                                                 */
/*==============================================================*/
create table Parte 
(
   Id_parte             integer                        not null,
   Id_Horario           integer                        null,
   Descripcion_parte    varchar(60)                    null,
   Fecha_part           date                           null,
   constraint PK_PARTE primary key (Id_parte),
   constraint FK_PARTE_RELATIONS_HORARIO foreign key (Id_Horario) references Horario (Id_Horario)

);
/*==============================================================*/
/* Table: Servicios_Guardiania                                  */
/*==============================================================*/
create table Servicios_Guardiania 
(
   Id_servicio          integer                        not null,
   Nombre_servicio      varchar(40)                    null,
   constraint PK_SERVICIOS_GUARDIANIA primary key (Id_servicio)
);

/*==============================================================*/
/* Table: Mantenimiento                                         */
/*==============================================================*/
create table Mantenimiento 
(
   Id_mantenimiento     integer                        not null,
   Id_parte             integer                        null,
   nombre_mantenimiento varchar(20)                    null,
   descripcion_mantenimiento varchar(60)                    null,
   constraint PK_MANTENIMIENTO primary key (Id_mantenimiento),
   constraint FK_MANTENIM_RELATIONS_PARTE foreign key (Id_parte) references Parte (Id_parte)
);

/*==============================================================*/
/* Table: Contrato                                              */
/*==============================================================*/
create table Contrato 
(
   Id_contrato          integer                        not null,
   Id_Horario           integer                        null,
   Id_empresa           integer                        null,
   Nombre_Contrato      varchar(20)                    null,
   Costo_contrato       numeric                        null,
   constraint PK_CONTRATO primary key (Id_contrato),
   constraint FK_CONTRATO_RELATIONS_EMPRESA foreign key (Id_empresa) references Empresa (Id_empresa),
   constraint FK_CONTRATO_RELATIONS_HORARIO foreign key (Id_Horario) references Horario (Id_Horario)
);

/*==============================================================*/
/* Table: Guardia                                               */
/*==============================================================*/
create table Guardia 
(
   Id_Guardia           integer                        not null,
   Id_contrato          integer                        null,
   Nombre_guardia       varchar(15)                    null,
   Apellido_guardia     varchar(15)                    null,
   Fecha_nacimiento     date                           null,
   Tipo_sangre          varchar(6)                     null,
   constraint PK_GUARDIA primary key (Id_Guardia),
   constraint FK_GUARDIA_RELATIONS_CONTRATO foreign key (Id_contrato) references Contrato (Id_contrato)
);
/*==============================================================*/
/* Table: Facturacion                                           */
/*==============================================================*/
create table Facturacion 
(
   Id_Factura           integer                        not null,
   Id_contrato          integer                        null,
   fecha_fact           date                           null,
   Total_fact           numeric                        null,
   constraint PK_FACTURACION primary key (Id_Factura),
   constraint FK_FACTURAC_RELATIONS_CONTRATO foreign key (Id_contrato) references Contrato (Id_contrato)
);
/*==============================================================*/
/* Table: Equipo_guardia                                        */
/*==============================================================*/
create table Equipo_guardia 
(
   Id_Guardia           integer                        not null,
   Id_equipo            integer                        not null,
   fecha_equipo         date                           null,
   talla_guardia        char(10)                       null,
   constraint PK_EQUIPO_GUARDIA primary key  (Id_Guardia, Id_equipo),
   constraint FK_EQUIPO_G_RELATIONS_GUARDIA foreign key (Id_Guardia) references Guardia (Id_Guardia),
   constraint FK_EQUIPO_G_RELATIONS_EQUIPO foreign key (Id_equipo) references Equipo (Id_equipo)
);
/*==============================================================*/
/* Table: Ascenso                                               */
/*==============================================================*/
create table Ascenso 
(
   Id_Guardia           integer                        not null,
   Id_grado             integer                        not null,
   fecha_ascenso        date                           null,
   constraint PK_ASCENSO primary key  (Id_Guardia, Id_grado),
   constraint FK_ASCENSO_RELATIONS_GUARDIA foreign key (Id_Guardia) references Guardia (Id_Guardia),
   constraint FK_ASCENSO_RELATIONS_GRADO_AS foreign key (Id_grado) references Grado_Ascenso (Id_grado)
);
/*==============================================================*/
/* Table: Guardia_entrenamiento                                 */
/*==============================================================*/
create table Guardia_entrenamiento 
(
   Id_Guardia           integer                        not null,
   Id_entrenamiento     integer                        not null,
   fecha_entrenamiento  date                           null,
   constraint PK_GUARDIA_ENTRENAMIENTO primary key  (Id_Guardia, Id_entrenamiento),
   constraint FK_GUARDIA__RELATIONS_GUARDIA foreign key (Id_Guardia) references Guardia (Id_Guardia),
   constraint FK_GUARDIA__RELATIONS_ENTRENAM foreign key (Id_entrenamiento) references Entrenamiento (Id_entrenamiento)
);

/*==============================================================*/
/* Table: Pedido_Servicio                                       */
/*==============================================================*/
create table Pedido_Servicio 
(
   Id_Guardia           integer                        not null,
   Id_servicio          integer                        not null,
   fecha_pedido         date                           null,
   constraint PK_PEDIDO_SERVICIO primary key  (Id_Guardia, Id_servicio),
   constraint FK_PEDIDO_S_RELATIONS_GUARDIA foreign key (Id_Guardia) references Guardia (Id_Guardia),
   constraint FK_PEDIDO_S_RELATIONS_SERVICIO foreign key (Id_servicio) references Servicios_Guardiania (Id_servicio)
);



/*INSERCIONES*/


insert into empresa values (1,'LAFABRIL',2100215545852,'lafabril@gmail.com',09563246354);
insert into empresa values (2,'INDUSTRIA ALES',1353535586865,'ales@gmail.com',096532471);
insert into empresa values (3,'BODEGAS TIA',13235626862,'tiabodegas@live.ec',0972432153);
select * from empresa;


insert into equipo values (1,'GAMMA','Guardias con regular estado fisico');
insert into equipo values (2,'BETA','Guardias con buen estado fisico');
insert into equipo values (3,'ALFA','Guardias con excelente estado fisico');
select * from equipo;

insert into horario values (1,'06:00:00','12:00:00');
insert into horario values (2,'12:00:00','18:00:00');
insert into horario values (3,'18:00:00','00:00:00');
insert into horario values (4,'00:00:00','06:00:00');
select * from horario;

insert into entrenamiento values(1,'2021/05/25','2021/06/25','1 mes',30);
insert into entrenamiento values(2,'2021/07/01','2021/09/01','2 mes',60);
insert into entrenamiento values(3,'2021/09/01','2021/10/01','1 mes',25);
select * from entrenamiento;

insert into Grado_Ascenso values (1,'Auxiliar','Guardia o persona de apoyo');
insert into Grado_Ascenso values (2,'Vigilante','Vigilancia y proteccion');
insert into Grado_Ascenso values (3,'Guarda rural','Proteccion de bienes en fincas,agricolas');
insert into Grado_Ascenso values (4,'Jefe seguridad','Analisis de situaciones de riesgo');
select * from grado_ascenso;


insert into parte values (1,1,'Parte de la manana','2021/05/01');
insert into parte values (2,2,'Parte de la tarde','2021/05/01');
insert into parte values (3,3,'Parte de la noche','2021/05/01');
insert into parte values (4,4,'Parte de la madrugada','2021/05/01');
select * from parte;

insert into servicios_guardiania values (1,'Vacaciones');
insert into servicios_guardiania values (2,'Capacitaciones');
insert into servicios_guardiania values (3,'Cambio de armamento');
select * from servicios_guardiania;

insert into mantenimiento values(1,1,'Armas','Mantenimiento de armas');
insert into mantenimiento values(2,1,'Uniformes','Mantenimiento de uniformes');
insert into mantenimiento values(3,2,'Establecimiento','Mantenimiento de establecimiento');
insert into mantenimiento values(4,3,'Control personas','Controlar cantidad de personas');
insert into mantenimiento values(5,4,'Tecnologia ','Mantenimiento de celulares y pc');
select * from mantenimiento;

insert into contrato values (1,2,1,'Vigilancia','150000');
insert into contrato values (2,3,1,'Custodia de Dinero','200000');
insert into contrato values (3,2,2,'Vigilancia','150000');
insert into contrato values (4,1,3,'Vigilancia','150000');
select * from contrato;

insert into guardia values(1,2,'Sergio','Loor','1995/05/08','O+');
insert into guardia values(2,3,'Luis','Pivaque','1996/10/10','O+');
insert into guardia values(3,1,'Carla','Fernandez','1998/11/04','O-');
insert into guardia values(4,2,'Andres','Suarez','1995/02/12','A+');
insert into guardia values(5,3,'Javier','Pico','1997/12/21','O+');
select * from guardia;

insert into facturacion values(1,1,'2021/10/12',150000);
insert into facturacion values(2,2,'2021/10/12',200000);
insert into facturacion values(3,3,'2021/10/12',150000);
insert into facturacion values(4,4,'2021/10/12',150000);
insert into facturacion values(5,1,'2020/10/12',150000);
insert into facturacion values(6,2,'2019/10/12',200000);
insert into facturacion values(7,2,'2018/10/12',300000);
insert into facturacion values(8,3,'2020/10/12',50000);
insert into facturacion values(9,4,'2019/10/12',100000);
select * from facturacion;

insert into equipo_guardia values(1,1,'2021/05/24','XL');
insert into equipo_guardia values(2,3,'2021/05/24','M');
insert into equipo_guardia values(3,2,'2021/05/24','L');
insert into equipo_guardia values(4,1,'2021/05/24','XL');
insert into equipo_guardia values(5,3,'2021/05/24','M');
SELECT * FROM EQUIPO_GUARDIA;

insert into ascenso values (1,2,'2021/08/24');
insert into ascenso values (1,3,'2021/12/10');
insert into ascenso values (2,3,'2021/12/10');
insert into ascenso values (4,4,'2021/09/11');
insert into ascenso values (3,3,'2021/12/10');
insert into ascenso values (5,2,'2021/08/24');
select * from ascenso;

insert into guardia_entrenamiento values(1,1,'2021/05/28');
insert into guardia_entrenamiento values(1,2,'2021/07/10');
insert into guardia_entrenamiento values(2,1,'2021/06/03');
insert into guardia_entrenamiento values(3,2,'2021/07/11');
insert into guardia_entrenamiento values(4,3,'2021/09/20');
insert into guardia_entrenamiento values(5,3,'2021/09/02');
select * from guardia_entrenamiento;


insert into pedido_servicio values (1,1,'2021/10/14');
insert into pedido_servicio values (2,1,'2021/11/13');
insert into pedido_servicio values (2,2,'2021/09/20');
insert into pedido_servicio values (3,1,'2021/07/03');
insert into pedido_servicio values (4,2,'2021/07/12');
insert into pedido_servicio values (4,3,'2021/10/21');
insert into pedido_servicio values (5,3,'2021/12/05');
select * from pedido_servicio;


-- consultas
--  1.Historico de ingresos por empresa select 
extract (year from facturacion.fecha_fact) as anio,
empresa.nombre_empresa as Empresa,
sum(facturacion.total_fact )as Total_Ingresos
from empresa
inner join contrato on contrato.id_empresa = empresa.id_empresa
inner join facturacion on contrato.id_contrato = facturacion.id_contrato
group by facturacion.fecha_fact,empresa.nombre_empresa,facturacion.total_fact

--2.Historico tipo de mantenimientos por empresa

select 
extract (year from parte.fecha_part) as anio,
empresa.nombre_empresa as Empresa,
mantenimiento.nombre_mantenimiento,
count(mantenimiento.id_parte) as Total
from empresa
inner join contrato on contrato.id_empresa = empresa.id_empresa
inner join horario on horario.id_horario = contrato.id_horario
inner join parte on parte.id_horario = horario.id_horario
inner join mantenimiento on mantenimiento.id_parte = parte.id_parte
group by parte.fecha_part,empresa.nombre_empresa,mantenimiento.nombre_mantenimiento,mantenimiento.id_parte

--3. Historico de servicios que ha pedido cada guardia desde qeu esta em la institucion
select 
extract (year from pedido_servicio.fecha_pedido) as anio,
(guardia.nombre_guardia || ' ' || guardia.apellido_guardia) AS Nombre_guardia,
servicios_guardiania.nombre_servicio,
count(pedido_servicio.id_servicio) as Total
from guardia
inner join pedido_servicio on pedido_servicio.id_guardia = guardia.id_guardia
inner join servicios_guardiania on servicios_guardiania.id_servicio = pedido_servicio.id_servicio
group by pedido_servicio.fecha_pedido,servicios_guardiania.nombre_servicio,pedido_servicio.id_servicio
,guardia.nombre_guardia,guardia.apellido_guardia



--4.Historico de cursos hechos por cada guardia

select 
extract (year from pedido_servicio.fecha_pedido) as anio,
(guardia.nombre_guardia || ' ' || guardia.apellido_guardia) AS Nombre_guardia,
count(pedido_servicio.id_servicio) as Total
from guardia
inner join pedido_servicio on pedido_servicio.id_guardia = guardia.id_guardia
inner join servicios_guardiania on servicios_guardiania.id_servicio = pedido_servicio.id_servicio
where pedido_servicio.id_servicio = 2
group by pedido_servicio.fecha_pedido,pedido_servicio.id_servicio
,guardia.nombre_guardia,guardia.apellido_guardia

-- TRIGGER

CREATE OR REPLACE FUNCTION asignacion_balas() RETURNS TRIGGER AS $asignacion_balas$
DECLARE BEGIN
     RAISE notice '%','No se puede asignar de nuevo';
END;
$asignacion_balas$ LANGUAGE plpgsql;
   
CREATE TRIGGER asignacion_balas BEFORE INSERT OR UPDATE 
    ON mantenimiento FOR EACH ROW 
    EXECUTE PROCEDURE asignacion_balas();
	
	
insert into mantenimiento values(6,4,'Cambio de balas','balas en mal estado');
SELECT * FROM mantenimiento;




--CURSOR
declare 
	cursor_contratos cursor for 
	select extract (year from facturacion.fecha_fact) as anio,
	contrato.nombre_contrato as tipo_contrato,
	sum(facturacion.total_fact )as Total_Ingresos,
	count(contrato.id_empresa) as Cantidad_empresas
	from empresa
	inner join contrato on contrato.id_empresa = empresa.id_empresa
	inner join facturacion on contrato.id_contrato = facturacion.id_contrato
	group by facturacion.fecha_fact,contrato.nombre_contrato,facturacion.total_fact;
begin

open cursor_contratos;
fetch cursor_contratos;





--Procedimiento almacenado


create or replace function Guardias_empresa(varchar) returns integer
as
$$
select 
count(guardia.id_contrato)
from guardia 
inner join contrato on contrato.id_contrato = guardia.id_contrato
inner join empresa on empresa.id_empresa=contrato.id_empresa
$$
Language sql

select Guardias_empresa ('BODEGAS TIA')


--IREPORT

select 
extract (year from facturacion.fecha_fact) as anio,
sum(facturacion.total_fact )as ingresos
from facturacion
group by facturacion.fecha_fact 
order by extract (year from facturacion.fecha_fact) asc









