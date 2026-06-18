-- =====================================================
-- PROYECTO FINAL - BASE DE DATOS VETERINARIA
-- Sistema de Gestión Clínica Veterinaria
-- Autores: Equipo de Base de Datos
-- Descripción: Sistema completo para gestionar mascotas,
-- veterinarios, citas, diagnósticos, tratamientos y facturación
-- =====================================================

-- =====================================================
-- SECCION 1: ELIMINACIÓN DE TABLAS EXISTENTES
-- =====================================================

drop table if exists Factura cascade;
drop table if exists Tratamiento cascade;
drop table if exists Diagnostico cascade;
drop table if exists Cita cascade;
drop table if exists Mascota cascade;
drop table if exists Veterinario cascade;
drop table if exists Propietario cascade;
drop table if exists Medicamento cascade;
drop table if exists Especialidad cascade;
drop table if exists Especie cascade;

-- =====================================================
-- SECCION 2: CREACIÓN DE TABLAS (DDL)
-- =====================================================
-- Tablas base del sistema con sus restricciones de integridad 

create table Especie (
    id_especie serial primary key,
    nombre_especie varchar(50) unique not null
);

-- Tabla para almacenar las especialidades de los veterinarios
create table Especialidad (
    id_especialidad serial primary key,
    nombre_especialidad varchar(50) unique not null
);

-- Tabla de medicamentos disponibles en la clínica
create table Medicamento (
    id_medicamento serial primary key,
    nombre_medicamento varchar(100) not null,
    descripcion text
);

-- Tabla de propietarios de mascotas
create table Propietario (
    id_propietario serial primary key,
    cedula varchar(20) unique not null,
    nombre_completo varchar(100) not null,
    telefono varchar(20),
    email varchar(100),
    direccion text
);

-- Tabla de veterinarios con su especialidad
create table Veterinario (
    id_veterinario serial primary key,
    cedula varchar(20) unique not null,
    nombre_completo varchar(100) not null,
    telefono varchar(20),
    email varchar(100),
    id_especialidad int not null,
    foreign key (id_especialidad) references Especialidad(id_especialidad)
);

-- Tabla de mascotas con información de alergias
create table Mascota (
    id_mascota serial primary key,
    nombre varchar(50) not null,
    fecha_nacimiento date,
    id_propietario int not null,
    id_especie int not null,
    alergias text,
    foreign key (id_propietario) references Propietario(id_propietario),
    foreign key (id_especie) references Especie(id_especie)
);

-- Tabla de citas programadas
create table Cita (
    id_cita serial primary key,
    fecha_hora timestamp not null,
    motivo varchar(200),
    id_mascota int not null,
    id_veterinario int not null,
    foreign key (id_mascota) references Mascota(id_mascota),
    foreign key (id_veterinario) references Veterinario(id_veterinario)
);

-- Tabla de diagnósticos asociados a citas
create table Diagnostico (
    id_diagnostico serial primary key,
    descripcion text not null,
    id_cita int not null unique,
    foreign key (id_cita) references Cita(id_cita) on delete cascade
);

-- Tabla de tratamientos con medicamentos prescritos
create table Tratamiento (
    id_tratamiento serial primary key,
    indicaciones text,
    id_diagnostico int not null,
    id_medicamento int,
    foreign key (id_diagnostico) references Diagnostico(id_diagnostico),
    foreign key (id_medicamento) references Medicamento(id_medicamento)
);

-- Tabla de facturación por cita
create table Factura (
    id_factura serial primary key,
    fecha_emision timestamp default current_timestamp,
    total decimal(10,2) not null check (total >= 0),
    id_cita int not null unique,
    foreign key (id_cita) references Cita(id_cita)
);


-- =====================================================
-- SECCION 3: CARGA DE DATOS INICIALES (DML)
-- =====================================================
-- Inserción de datos de prueba para poblamiento inicial

-- Inserción de especies disponibles
insert into Especie (nombre_especie) values 
('Perro'), ('Gato'), ('Conejo'), ('Hamster'), ('Loro');

-- Inserción de especialidades veterinarias
insert into Especialidad (nombre_especialidad) values 
('Medicina General'), ('Dermatologia'), ('Cardiologia'), ('Odontologia'), ('Cirugia');

-- Inserción de medicamentos disponibles
insert into Medicamento (nombre_medicamento, descripcion) values
('Amoxicilina', 'Antibiotico de amplio espectro'),
('Meloxicam', 'Antiinflamatorio'),
('Fipronil', 'Antiparasitario externo'),
('Omeprazol', 'Protector gastrico'),
('Dexametasona', 'Corticoide');

-- Inserción de propietarios
insert into Propietario (cedula, nombre_completo, telefono, email, direccion) values
('12345678A', 'Maria Gonzalez', '600111222', 'maria@email.com', 'Calle Luna 123'),
('87654321B', 'Carlos Perez', '600333444', 'carlos@email.com', 'Av. Sol 456'),
('11223344C', 'Ana Rodriguez', '600555666', 'ana@email.com', 'Plaza Mayor 789');

-- Inserción de veterinarios
insert into Veterinario (cedula, nombre_completo, telefono, email, id_especialidad) values
('VET001', 'Dr. Juan Martinez', '600777888', 'juan@vet.com', 1),
('VET002', 'Dra. Laura Fernandez', '600999000', 'laura@vet.com', 2),
('VET003', 'Dr. Roberto Sanchez', '600111333', 'roberto@vet.com', 3);

-- Inserción de mascotas
insert into Mascota (nombre, fecha_nacimiento, id_propietario, id_especie, alergias) values
('Max', '2020-05-10', 1, 1, 'Ninguna'),
('Luna', '2019-08-22', 1, 2, 'Penicilina'),
('Toby', '2021-01-15', 2, 1, 'Ninguna'),
('Rocky', '2018-11-30', 3, 1, 'Dexametasona');

-- Inserción de citas programadas
insert into Cita (fecha_hora, motivo, id_mascota, id_veterinario) values
('2025-01-15 10:00:00', 'Vacunacion', 1, 1),
('2025-01-20 11:30:00', 'Dermatitis', 2, 2),
('2025-02-10 09:00:00', 'Chequeo general', 3, 1),
('2025-02-15 16:00:00', 'Tos', 4, 3),
('2025-03-05 12:00:00', 'Herida', 1, 1),
('2025-03-18 10:30:00', 'Alopecia', 2, 2),
('2025-04-01 15:00:00', 'Dolor dental', 3, 1),
('2025-04-10 09:30:00', 'Dificultad respiratoria', 4, 3),
('2025-04-20 11:00:00', 'Revision control', 1, 1),
('2025-05-05 17:00:00', 'Vomitos', 2, 1);

-- Inserción de diagnósticos
insert into Diagnostico (descripcion, id_cita) values
('Saludable, vacuna aplicada', 1),
('Dermatitis alergica', 2),
('Estado general bueno', 3),
('Bronquitis', 4),
('Herida superficial', 5),
('Dermatitis por pulgas', 6),
('Calculo dental', 7),
('Insuficiencia cardiaca', 8),
('Control post-quirurgico', 9),
('Gastroenteritis', 10);

-- Inserción de tratamientos
insert into Tratamiento (indicaciones, id_diagnostico, id_medicamento) values
('Aplicar cada 24h', 2, 2),
('Cada 12h por 7 dias', 4, 1),
('Limpiar con suero', 5, null),
('Aplicar antiparasitario', 6, 3),
('Cada 24h por 5 dias', 8, 4),
('Dieta blanda 3 dias', 10, 5);

-- Inserción de facturas
insert into Factura (total, id_cita) values
(45.00, 1), (60.00, 2), (40.00, 3), (80.00, 4), (35.00, 5),
(55.00, 6), (120.00, 7), (95.00, 8), (50.00, 9), (70.00, 10);


-- =====================================================
-- SECCION 4: FUNCIONES Y TRIGGERS
-- =====================================================
-- Lógica procedimental para validaciones y operaciones

-- Función para obtener el historial clínico completo de una mascota
-- Parametro: ID de la mascota
-- Retorna: tabla con fecha, motivo, veterinario, diagnóstico, medicamentos y total
create or replace function historial_clinico(p_id_mascota int)
returns table(
    fecha timestamp,
    motivo varchar,
    veterinario varchar,
    diagnostico text,
    medicamentos text,
    total decimal
) as $$
begin
    return query
    select 
        c.fecha_hora,
        c.motivo,
        v.nombre_completo,
        d.descripcion,
        string_agg(m.nombre_medicamento, ', '),
        f.total
    from Cita c
    join Veterinario v on c.id_veterinario = v.id_veterinario
    left join Diagnostico d on c.id_cita = d.id_cita
    left join Tratamiento t on d.id_diagnostico = t.id_diagnostico
    left join Medicamento m on t.id_medicamento = m.id_medicamento
    left join Factura f on c.id_cita = f.id_cita
    where c.id_mascota = p_id_mascota
    group by c.id_cita, c.fecha_hora, c.motivo, v.nombre_completo, d.descripcion, f.total
    order by c.fecha_hora desc;
end;
$$ language plpgsql;

-- Función trigger para verificar alergias antes de prescribir medicamentos
-- Se ejecuta al insertar un diagnóstico
-- Valida que ningún medicamento prescrito esté en la lista de alergias
create or replace function verificar_alergias()
returns trigger as $$
declare
    v_alergias text;
    v_mascota_id int;
    v_medicamento_alergico text;
begin
    -- Obtener información de alergias de la mascota asociada a la cita
    select m.id_mascota, m.alergias into v_mascota_id, v_alergias
    from Mascota m
    join Cita c on m.id_mascota = c.id_mascota
    where c.id_cita = new.id_cita;
    
    -- Si la mascota tiene alergias registradas
    if v_alergias is not null and v_alergias != 'Ninguna' then
        -- Verificar cada medicamento asignado a este diagnóstico
        select m.nombre_medicamento into v_medicamento_alergico
        from Tratamiento t
        join Medicamento m on t.id_medicamento = m.id_medicamento
        where t.id_diagnostico = new.id_diagnostico
          and m.id_medicamento is not null
          and (v_alergias ilike ('%' || m.nombre_medicamento || '%')
               or lower(v_alergias) like lower('%' || m.nombre_medicamento || '%'))
        limit 1;
        
        if v_medicamento_alergico is not null then
            raise exception 'ALERTA DE SEGURIDAD: La mascota es alergica a %. No se puede proceder con este tratamiento.', v_medicamento_alergico;
        end if;
    end if;
    
    return new;
end;
$$ language plpgsql;

-- Trigger que se ejecuta después de insertar un diagnóstico
drop trigger if exists trigger_verificar_alergias on Diagnostico;
create trigger trigger_verificar_alergias
after insert on Diagnostico
for each row
execute function verificar_alergias();

-- =====================================================
-- SECCION 5: PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)
-- =====================================================
-- Procedimientos para operaciones comunes del negocio

-- Procedimiento para registrar un nuevo propietario
-- Parametros: cédula, nombre, teléfono, email, dirección
-- Retorna: ID del propietario registrado
create or replace procedure registrar_propietario(
    p_cedula varchar,
    p_nombre varchar,
    p_telefono varchar,
    p_email varchar,
    p_direccion text,
    out p_id_propietario int
) as $$
begin
    insert into Propietario (cedula, nombre_completo, telefono, email, direccion)
    values (p_cedula, p_nombre, p_telefono, p_email, p_direccion)
    returning id_propietario into p_id_propietario;
    
    raise notice 'Propietario registrado exitosamente con ID: %', p_id_propietario;
exception when unique_violation then
    raise exception 'Error: La cedula % ya está registrada', p_cedula;
end;
$$ language plpgsql;

-- Procedimiento para registrar una nueva mascota
-- Parametros: nombre, fecha nacimiento, ID propietario, ID especie, alergias
-- Retorna: ID de la mascota registrada
create or replace procedure registrar_mascota(
    p_nombre varchar,
    p_fecha_nacimiento date,
    p_id_propietario int,
    p_id_especie int,
    p_alergias text,
    out p_id_mascota int
) as $$
begin
    -- Validar que el propietario exista
    if not exists (select 1 from Propietario where id_propietario = p_id_propietario) then
        raise exception 'Error: El propietario con ID % no existe', p_id_propietario;
    end if;
    
    -- Validar que la especie exista
    if not exists (select 1 from Especie where id_especie = p_id_especie) then
        raise exception 'Error: La especie con ID % no existe', p_id_especie;
    end if;
    
    insert into Mascota (nombre, fecha_nacimiento, id_propietario, id_especie, alergias)
    values (p_nombre, p_fecha_nacimiento, p_id_propietario, p_id_especie, coalesce(p_alergias, 'Ninguna'))
    returning id_mascota into p_id_mascota;
    
    raise notice 'Mascota registrada exitosamente con ID: %', p_id_mascota;
end;
$$ language plpgsql;

-- Procedimiento para programar una nueva cita
-- Parametros: fecha/hora, motivo, ID mascota, ID veterinario
-- Retorna: ID de la cita programada
create or replace procedure programar_cita(
    p_fecha_hora timestamp,
    p_motivo varchar,
    p_id_mascota int,
    p_id_veterinario int,
    out p_id_cita int
) as $$
begin
    -- Validar que la mascota exista
    if not exists (select 1 from Mascota where id_mascota = p_id_mascota) then
        raise exception 'Error: La mascota con ID % no existe', p_id_mascota;
    end if;
    
    -- Validar que el veterinario exista
    if not exists (select 1 from Veterinario where id_veterinario = p_id_veterinario) then
        raise exception 'Error: El veterinario con ID % no existe', p_id_veterinario;
    end if;
    
    -- Validar que la fecha no sea en el pasado
    if p_fecha_hora < current_timestamp then
        raise exception 'Error: No se pueden programar citas en fechas pasadas';
    end if;
    
    insert into Cita (fecha_hora, motivo, id_mascota, id_veterinario)
    values (p_fecha_hora, p_motivo, p_id_mascota, p_id_veterinario)
    returning id_cita into p_id_cita;
    
    raise notice 'Cita programada exitosamente con ID: %', p_id_cita;
end;
$$ language plpgsql;

-- Procedimiento para registrar un diagnóstico y generar factura
-- Parametros: descripción diagnóstico, ID cita, total a cobrar
-- Retorna: ID del diagnóstico registrado
create or replace procedure registrar_diagnostico_y_factura(
    p_descripcion text,
    p_id_cita int,
    p_total decimal,
    out p_id_diagnostico int
) as $$
begin
    -- Validar que la cita exista
    if not exists (select 1 from Cita where id_cita = p_id_cita) then
        raise exception 'Error: La cita con ID % no existe', p_id_cita;
    end if;
    
    -- Validar que no exista diagnóstico previo para esta cita
    if exists (select 1 from Diagnostico where id_cita = p_id_cita) then
        raise exception 'Error: Ya existe un diagnóstico registrado para esta cita';
    end if;
    
    -- Validar que el total sea positivo
    if p_total <= 0 then
        raise exception 'Error: El total debe ser mayor a 0';
    end if;
    
    -- Insertar diagnóstico
    insert into Diagnostico (descripcion, id_cita)
    values (p_descripcion, p_id_cita)
    returning id_diagnostico into p_id_diagnostico;
    
    -- Insertar factura automáticamente
    insert into Factura (total, id_cita)
    values (p_total, p_id_cita);
    
    raise notice 'Diagnóstico registrado con ID: % y factura generada', p_id_diagnostico;
end;
$$ language plpgsql;

-- Procedimiento para actualizar las alergias de una mascota
-- Parametros: ID mascota, nuevas alergias
create or replace procedure actualizar_alergias_mascota(
    p_id_mascota int,
    p_nuevas_alergias text
) as $$
begin
    -- Validar que la mascota exista
    if not exists (select 1 from Mascota where id_mascota = p_id_mascota) then
        raise exception 'Error: La mascota con ID % no existe', p_id_mascota;
    end if;
    
    update Mascota
    set alergias = p_nuevas_alergias
    where id_mascota = p_id_mascota;
    
    raise notice 'Alergias de la mascota ID % actualizadas a: %', p_id_mascota, p_nuevas_alergias;
end;
$$ language plpgsql;

-- Procedimiento para obtener el veterinario con más citas en un período
-- Parametros: fecha inicio, fecha fin
-- Retorna: nombre, cédula y cantidad de citas del veterinario
create or replace procedure veterinario_mas_citas(
    p_fecha_inicio date,
    p_fecha_fin date
) as $$
begin
    select 
        v.nombre_completo,
        v.cedula,
        count(c.id_cita) as total_citas
    from Veterinario v
    left join Cita c on v.id_veterinario = c.id_veterinario
        and date(c.fecha_hora) between p_fecha_inicio and p_fecha_fin
    group by v.id_veterinario, v.nombre_completo, v.cedula
    order by total_citas desc
    limit 1;
end;
$$ language plpgsql;

-- =====================================================
-- SECCION 6: VISTAS PARA CONSULTAS FRECUENTES
-- =====================================================
-- Vistas para facilitar el acceso a información común

-- Vista: Resumen de citas pendientes
create or replace view vista_citas_proximas as
select 
    c.id_cita,
    m.nombre as mascota,
    p.nombre_completo as propietario,
    p.telefono,
    v.nombre_completo as veterinario,
    c.fecha_hora,
    c.motivo
from Cita c
join Mascota m on c.id_mascota = m.id_mascota
join Propietario p on m.id_propietario = p.id_propietario
join Veterinario v on c.id_veterinario = v.id_veterinario
where c.fecha_hora > current_timestamp
order by c.fecha_hora asc;

-- Vista: Resumen de facturación por especialidad
create or replace view vista_ingresos_por_especialidad as
select 
    e.nombre_especialidad,
    count(f.id_factura) as total_facturas,
    sum(f.total) as ingresos_totales,
    round(avg(f.total), 2) as promedio_por_factura
from Factura f
join Cita c on f.id_cita = c.id_cita
join Veterinario v on c.id_veterinario = v.id_veterinario
join Especialidad e on v.id_especialidad = e.id_especialidad
group by e.id_especialidad, e.nombre_especialidad
order by ingresos_totales desc;

-- Vista: Medicamentos más prescritos
create or replace view vista_medicamentos_frecuentes as
select 
    m.nombre_medicamento,
    m.descripcion,
    count(t.id_tratamiento) as veces_prescrito,
    count(distinct d.id_diagnostico) as diagnosticos_tratados
from Medicamento m
left join Tratamiento t on m.id_medicamento = t.id_medicamento
left join Diagnostico d on t.id_diagnostico = d.id_diagnostico
group by m.id_medicamento, m.nombre_medicamento, m.descripcion
order by veces_prescrito desc;


-- =====================================================
-- SECCION 7: CONSULTAS SQL FRECUENTES DEL NEGOCIO
-- =====================================================
-- Consultas para análisis y reportes

-- Consulta 1: Citas por mes por mascota en 2025
-- Objetivo: Identificar patrones de asistencia
select 
    extract(month from c.fecha_hora) as mes,
    m.nombre as mascota,
    count(*) as total_citas
from Cita c
join Mascota m on c.id_mascota = m.id_mascota
where extract(year from c.fecha_hora) = 2025
group by mes, m.nombre
order by mes, total_citas desc;

-- Consulta 2: Veterinario más activo en primer trimestre 2025
-- Objetivo: Evaluar carga de trabajo por veterinario
select 
    v.nombre_completo as veterinario,
    e.nombre_especialidad,
    count(*) as total_citas
from Cita c
join Veterinario v on c.id_veterinario = v.id_veterinario
join Especialidad e on v.id_especialidad = e.id_especialidad
where c.fecha_hora between '2025-01-01' and '2025-03-31'
group by v.id_veterinario, v.nombre_completo, e.nombre_especialidad
order by total_citas desc
limit 1;

-- Consulta 3: Medicamentos más utilizados en tratamientos
-- Objetivo: Controlar inventario de medicamentos
select 
    m.nombre_medicamento,
    m.descripcion,
    count(t.id_tratamiento) as veces_prescrito
from Medicamento m
left join Tratamiento t on m.id_medicamento = t.id_medicamento
group by m.id_medicamento, m.nombre_medicamento, m.descripcion
order by veces_prescrito desc;

-- Consulta 4: Ingresos totales por especialidad veterinaria
-- Objetivo: Evaluar rentabilidad por área
select 
    e.nombre_especialidad,
    count(f.id_factura) as numero_facturas,
    sum(f.total) as ingresos_totales,
    round(avg(f.total), 2) as promedio_por_factura
from Factura f
join Cita c on f.id_cita = c.id_cita
join Veterinario v on c.id_veterinario = v.id_veterinario
join Especialidad e on v.id_especialidad = e.id_especialidad
group by e.id_especialidad, e.nombre_especialidad
order by ingresos_totales desc;

-- Consulta 5: Propietarios con mascotas sin citas en últimos 6 meses
-- Objetivo: Identificar clientes potenciales para seguimiento
select distinct p.nombre_completo as propietario, p.telefono, p.email
from Propietario p
join Mascota m on p.id_propietario = m.id_propietario
left join Cita c on m.id_mascota = c.id_mascota 
    and c.fecha_hora >= current_date - interval '6 months'
where c.id_cita is null;

-- Consulta 6: Mascotas con alergias registradas
-- Objetivo: Consulta de seguridad para medicamentos
select 
    m.nombre as mascota,
    es.nombre_especie,
    p.nombre_completo as propietario,
    m.alergias
from Mascota m
join Especie es on m.id_especie = es.id_especie
join Propietario p on m.id_propietario = p.id_propietario
where m.alergias is not null and m.alergias != 'Ninguna'
order by m.nombre;

-- Consulta 7: Historial de diagnósticos por tipo
-- Objetivo: Análisis epidemiológico
select 
    d.descripcion as diagnostico,
    count(d.id_diagnostico) as numero_casos,
    round(avg(f.total), 2) as costo_promedio_tratamiento
from Diagnostico d
left join Tratamiento t on d.id_diagnostico = t.id_diagnostico
left join Factura f on d.id_cita = f.id_cita
group by d.descripcion
order by numero_casos desc;

-- =====================================================
-- SECCION 8: EJEMPLOS DE USO DE PROCEDIMIENTOS
-- =====================================================
-- Descomenta para ejecutar ejemplos

-- Ejemplo 1: Registrar un nuevo propietario
-- call registrar_propietario('99999999Z', 'Pedro Lopez', '600123456', 'pedro@email.com', 'Calle Nueva 100', null);

-- Ejemplo 2: Registrar una nueva mascota
-- call registrar_mascota('Firulais', '2023-06-15', 1, 1, 'Ninguna', null);

-- Ejemplo 3: Programar una cita
-- call programar_cita('2025-06-25 14:30:00', 'Vacunación anual', 1, 1, null);

-- Ejemplo 4: Actualizar alergias
-- call actualizar_alergias_mascota(2, 'Penicilina, Amoxicilina');

-- Ejemplo 5: Obtener veterinario con más citas
-- call veterinario_mas_citas('2025-01-01', '2025-03-31');

-- =====================================================
-- FIN DEL SCRIPT
-- =================================================== 