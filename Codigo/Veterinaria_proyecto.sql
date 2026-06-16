-- Proyecto Veterinaria 

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

--  2. crear Tablas 

create table Especie (
    id_especie serial primary key,
    nombre_especie varchar(50) unique not null
);

create table Especialidad (
    id_especialidad serial primary key,
    nombre_especialidad varchar(50) unique not null
);

create table Medicamento (
    id_medicamento serial primary key,
    nombre_medicamento varchar(100) not null,
    descripcion text
);

create table Propietario (
    id_propietario serial primary key,
    cedula varchar(20) unique not null,
    nombre_completo varchar(100) not null,
    telefono varchar(20),
    email varchar(100),
    direccion text
);

create table Veterinario (
    id_veterinario serial primary key,
    cedula varchar(20) unique not null,
    nombre_completo varchar(100) not null,
    telefono varchar(20),
    email varchar(100),
    id_especialidad int not null,
    foreign key (id_especialidad) references Especialidad(id_especialidad)
);

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

create table Cita (
    id_cita serial primary key,
    fecha_hora timestamp not null,
    motivo varchar(200),
    id_mascota int not null,
    id_veterinario int not null,
    foreign key (id_mascota) references Mascota(id_mascota),
    foreign key (id_veterinario) references Veterinario(id_veterinario)
);

create table Diagnostico (
    id_diagnostico serial primary key,
    descripcion text not null,
    id_cita int not null unique,
    foreign key (id_cita) references Cita(id_cita) on delete cascade
);

create table Tratamiento (
    id_tratamiento serial primary key,
    indicaciones text,
    id_diagnostico int not null,
    id_medicamento int,
    foreign key (id_diagnostico) references Diagnostico(id_diagnostico),
    foreign key (id_medicamento) references Medicamento(id_medicamento)
);

create table Factura (
    id_factura serial primary key,
    fecha_emision timestamp default current_timestamp,
    total decimal(10,2) not null check (total >= 0),
    id_cita int not null unique,
    foreign key (id_cita) references Cita(id_cita)
);

-- 3. Insertar Datos

insert into Especie (nombre_especie) values 
('Perro'), ('Gato'), ('Conejo'), ('Hamster'), ('Loro');

insert into Especialidad (nombre_especialidad) values 
('Medicina General'), ('Dermatologia'), ('Cardiologia'), ('Odontologia'), ('Cirugia');

insert into Medicamento (nombre_medicamento, descripcion) values
('Amoxicilina', 'Antibiotico de amplio espectro'),
('Meloxicam', 'Antiinflamatorio'),
('Fipronil', 'Antiparasitario externo'),
('Omeprazol', 'Protector gastrico'),
('Dexametasona', 'Corticoide');

insert into Propietario (cedula, nombre_completo, telefono, email, direccion) values
('12345678A', 'Maria Gonzalez', '600111222', 'maria@email.com', 'Calle Luna 123'),
('87654321B', 'Carlos Perez', '600333444', 'carlos@email.com', 'Av. Sol 456'),
('11223344C', 'Ana Rodriguez', '600555666', 'ana@email.com', 'Plaza Mayor 789');

insert into Veterinario (cedula, nombre_completo, telefono, email, id_especialidad) values
('VET001', 'Dr. Juan Martinez', '600777888', 'juan@vet.com', 1),
('VET002', 'Dra. Laura Fernandez', '600999000', 'laura@vet.com', 2),
('VET003', 'Dr. Roberto Sanchez', '600111333', 'roberto@vet.com', 3);

insert into Mascota (nombre, fecha_nacimiento, id_propietario, id_especie, alergias) values
('Max', '2020-05-10', 1, 1, 'Ninguna'),
('Luna', '2019-08-22', 1, 2, 'Penicilina'),
('Toby', '2021-01-15', 2, 1, 'Ninguna'),
('Rocky', '2018-11-30', 3, 1, 'Dexametasona');

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

insert into Tratamiento (indicaciones, id_diagnostico, id_medicamento) values
('Aplicar cada 24h', 2, 2),
('Cada 12h por 7 dias', 4, 1),
('Limpiar con suero', 5, null),
('Aplicar antiparasitario', 6, 3),
('Cada 24h por 5 dias', 8, 4),
('Dieta blanda 3 dias', 10, 5);

insert into Factura (total, id_cita) values
(45.00, 1), (60.00, 2), (40.00, 3), (80.00, 4), (35.00, 5),
(55.00, 6), (120.00, 7), (95.00, 8), (50.00, 9), (70.00, 10);

-- 4. Funciones y triggers 

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

create or replace function verificar_alergias()
returns trigger as $$
declare
    v_alergias text;
    v_medicamento_alergico text;
begin
    select m.alergias into v_alergias
    from Mascota m
    join Cita c on m.id_mascota = c.id_mascota
    where c.id_cita = new.id_cita;
    
    select m.nombre_medicamento into v_medicamento_alergico
    from Tratamiento t
    join Medicamento m on t.id_medicamento = m.id_medicamento
    where t.id_diagnostico = new.id_diagnostico
      and v_alergias ilike ('%' || m.nombre_medicamento || '%');
    
    if v_medicamento_alergico is not null then
        raise exception 'ALERTA: La mascota es alergica a %', v_medicamento_alergico;
    end if;
    
    return new;
end;
$$ language plpgsql;

drop trigger if exists trigger_verificar_alergias on Diagnostico;
create trigger trigger_verificar_alergias
after insert on Diagnostico
for each row
execute function verificar_alergias();

--  5. Consultas

select 
    extract(month from c.fecha_hora) as mes,
    m.nombre as mascota,
    count(*) as total_citas
from Cita c
join Mascota m on c.id_mascota = m.id_mascota
where extract(year from c.fecha_hora) = 2025
group by mes, m.nombre
order by mes, total_citas desc;

select 
    v.nombre_completo as veterinario,
    count(*) as total_citas
from Cita c
join Veterinario v on c.id_veterinario = v.id_veterinario
where c.fecha_hora between '2025-01-01' and '2025-03-31'
group by v.nombre_completo
order by total_citas desc
limit 1;

select 
    m.nombre_medicamento,
    count(t.id_tratamiento) as veces_prescrito
from Tratamiento t
join Medicamento m on t.id_medicamento = m.id_medicamento
group by m.nombre_medicamento
order by veces_prescrito desc;

select 
    e.nombre_especialidad,
    sum(f.total) as ingresos_totales
from Factura f
join Cita c on f.id_cita = c.id_cita
join Veterinario v on c.id_veterinario = v.id_veterinario
join Especialidad e on v.id_especialidad = e.id_especialidad
group by e.nombre_especialidad
order by ingresos_totales desc;

select distinct p.nombre_completo as propietario, p.telefono
from Propietario p
join Mascota m on p.id_propietario = m.id_propietario
left join Cita c on m.id_mascota = c.id_mascota 
    and c.fecha_hora >= current_date - interval '6 months'
where c.id_cita is null;