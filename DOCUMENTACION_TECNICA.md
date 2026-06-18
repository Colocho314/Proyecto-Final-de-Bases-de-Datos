# DOCUMENTACIÓN TÉCNICA - PROYECTO FINAL BASE DE DATOS
## Sistema de Gestión Clínica Veterinaria

---

## 1. DESCRIPCIÓN GENERAL

El presente proyecto implementa un **Sistema de Gestión Clínica Veterinaria** completo en PostgreSQL. El sistema permite gestionar propietarios de mascotas, mascotas, veterinarios, citas, diagnósticos, tratamientos, medicamentos y facturación.

**Escenario seleccionado:** Escenario A - Sistema de Gestión Clínica Veterinaria

---

## 2. MODELO ENTIDAD-RELACIÓN (ER)

### Entidades principales:
- **Especie**: Tipos de animales (Perro, Gato, etc.)
- **Especialidad**: Especialidades veterinarias disponibles
- **Medicamento**: Catálogo de medicamentos
- **Propietario**: Dueños de mascotas
- **Veterinario**: Personal veterinario con especialidades
- **Mascota**: Registro de mascotas con datos de alergias
- **Cita**: Citas programadas
- **Diagnóstico**: Diagnósticos de cada cita
- **Tratamiento**: Tratamientos prescritos con medicamentos
- **Factura**: Facturación por servicios

### Relaciones:
```
Propietario (1:N) ← → Mascota
Especie (1:N) ← → Mascota
Veterinario (1:N) ← → Cita
Mascota (1:N) ← → Cita
Cita (1:1) ← → Diagnóstico
Cita (1:1) ← → Factura
Diagnóstico (1:N) ← → Tratamiento
Medicamento (1:N) ← → Tratamiento
Especialidad (1:N) ← → Veterinario
```

---

## 3. ESQUEMA RELACIONAL NORMALIZADO (3FN)

### Normalización aplicada:

- **1FN**: Todos los atributos contienen valores atómicos
- **2FN**: Todos los atributos no clave dependen completamente de la clave primaria
- **3FN**: Sin dependencias transitivas entre atributos no clave

Todas las tablas están diseñadas siguiendo la tercera forma normal, con:
- Claves primarias bien definidas
- Claves foráneas que mantienen integridad referencial
- Restricciones CHECK para validaciones de datos
- Restricciones UNIQUE para campos que no pueden repetirse

---

## 4. DICCIONARIO DE DATOS

### Tabla: Especie
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_especie | serial | PK | Identificador único |
| nombre_especie | varchar(50) | UNIQUE, NOT NULL | Nombre de la especie |

### Tabla: Especialidad
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_especialidad | serial | PK | Identificador único |
| nombre_especialidad | varchar(50) | UNIQUE, NOT NULL | Nombre especialidad |

### Tabla: Medicamento
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_medicamento | serial | PK | Identificador único |
| nombre_medicamento | varchar(100) | NOT NULL | Nombre del medicamento |
| descripcion | text | - | Descripción del uso |

### Tabla: Propietario
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_propietario | serial | PK | Identificador único |
| cedula | varchar(20) | UNIQUE, NOT NULL | Cédula única |
| nombre_completo | varchar(100) | NOT NULL | Nombre completo |
| telefono | varchar(20) | - | Número de contacto |
| email | varchar(100) | - | Correo electrónico |
| direccion | text | - | Dirección de residencia |

### Tabla: Veterinario
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_veterinario | serial | PK | Identificador único |
| cedula | varchar(20) | UNIQUE, NOT NULL | Cédula profesional |
| nombre_completo | varchar(100) | NOT NULL | Nombre completo |
| telefono | varchar(20) | - | Número de contacto |
| email | varchar(100) | - | Correo electrónico |
| id_especialidad | int | FK, NOT NULL | Referencia a especialidad |

### Tabla: Mascota
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_mascota | serial | PK | Identificador único |
| nombre | varchar(50) | NOT NULL | Nombre de la mascota |
| fecha_nacimiento | date | - | Fecha de nacimiento |
| id_propietario | int | FK, NOT NULL | Referencia a propietario |
| id_especie | int | FK, NOT NULL | Referencia a especie |
| alergias | text | - | Alergias conocidas |

### Tabla: Cita
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_cita | serial | PK | Identificador único |
| fecha_hora | timestamp | NOT NULL | Fecha y hora de cita |
| motivo | varchar(200) | - | Motivo de consulta |
| id_mascota | int | FK, NOT NULL | Referencia a mascota |
| id_veterinario | int | FK, NOT NULL | Referencia a veterinario |

### Tabla: Diagnostico
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_diagnostico | serial | PK | Identificador único |
| descripcion | text | NOT NULL | Descripción diagnóstico |
| id_cita | int | FK, UNIQUE, NOT NULL | Referencia a cita |

### Tabla: Tratamiento
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_tratamiento | serial | PK | Identificador único |
| indicaciones | text | - | Instrucciones de uso |
| id_diagnostico | int | FK, NOT NULL | Referencia a diagnóstico |
| id_medicamento | int | FK | Referencia a medicamento |

### Tabla: Factura
| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_factura | serial | PK | Identificador único |
| fecha_emision | timestamp | DEFAULT current_timestamp | Fecha de emisión |
| total | decimal(10,2) | CHECK >= 0, NOT NULL | Monto total |
| id_cita | int | FK, UNIQUE, NOT NULL | Referencia a cita |

---

## 5. PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)

### 1. `registrar_propietario`
**Propósito:** Registrar un nuevo propietario en el sistema
**Parámetros:**
- `p_cedula`: Cédula del propietario
- `p_nombre`: Nombre completo
- `p_telefono`: Número de teléfono
- `p_email`: Correo electrónico
- `p_direccion`: Dirección de residencia
- `p_id_propietario` (OUT): ID generado

**Validaciones:** Verifica que la cédula sea única

---

### 2. `registrar_mascota`
**Propósito:** Registrar una nueva mascota en el sistema
**Parámetros:**
- `p_nombre`: Nombre de la mascota
- `p_fecha_nacimiento`: Fecha de nacimiento
- `p_id_propietario`: ID del propietario dueño
- `p_id_especie`: ID de la especie
- `p_alergias`: Alergias conocidas
- `p_id_mascota` (OUT): ID generado

**Validaciones:** Verifica existencia de propietario y especie

---

### 3. `programar_cita`
**Propósito:** Programar una nueva cita veterinaria
**Parámetros:**
- `p_fecha_hora`: Fecha y hora de la cita
- `p_motivo`: Motivo de consulta
- `p_id_mascota`: ID de la mascota
- `p_id_veterinario`: ID del veterinario
- `p_id_cita` (OUT): ID generado

**Validaciones:** 
- Verifica existencia de mascota y veterinario
- Valida que no sea en fecha pasada

---

### 4. `registrar_diagnostico_y_factura`
**Propósito:** Registrar diagnóstico y generar factura automáticamente
**Parámetros:**
- `p_descripcion`: Descripción del diagnóstico
- `p_id_cita`: ID de la cita
- `p_total`: Total a facturar
- `p_id_diagnostico` (OUT): ID generado

**Validaciones:**
- Verifica que la cita exista
- Valida que no exista diagnóstico previo
- Valida que el total sea positivo

---

### 5. `actualizar_alergias_mascota`
**Propósito:** Actualizar registro de alergias de una mascota
**Parámetros:**
- `p_id_mascota`: ID de la mascota
- `p_nuevas_alergias`: Nuevas alergias a registrar

**Validaciones:** Verifica que la mascota exista

---

### 6. `veterinario_mas_citas`
**Propósito:** Identificar el veterinario con más citas en un período
**Parámetros:**
- `p_fecha_inicio`: Fecha inicio del período
- `p_fecha_fin`: Fecha fin del período

**Retorna:** Nombre, cédula y cantidad de citas del veterinario más activo

---

## 6. FUNCIONES

### 1. `historial_clinico(p_id_mascota)`
**Propósito:** Obtener el historial clínico completo de una mascota
**Parámetros:** ID de la mascota
**Retorna:**
- `fecha`: Fecha de la cita
- `motivo`: Motivo de la consulta
- `veterinario`: Nombre del veterinario
- `diagnostico`: Descripción del diagnóstico
- `medicamentos`: Listado de medicamentos prescritos
- `total`: Total facturado

**Uso:**
```sql
SELECT * FROM historial_clinico(1);
```

---

### 2. `verificar_alergias()`
**Propósito:** Trigger que valida medicamentos contra alergias de mascota
**Comportamiento:** Se ejecuta AFTER INSERT en tabla Diagnóstico
**Lógica:**
1. Obtiene las alergias de la mascota
2. Verifica medicamentos prescritos contra las alergias
3. Lanza excepción si hay conflicto
4. Impide registro del diagnóstico con medicamento alérgico

---

## 7. TRIGGERS

### `trigger_verificar_alergias`
**Tabla:** Diagnóstico
**Evento:** AFTER INSERT
**Función:** verificar_alergias()
**Propósito:** Validar seguridad al prescribir medicamentos
**Regla de negocio implementada:** 
*"Al registrar un diagnóstico, verificar automáticamente si existen alergias registradas de la mascota a algún medicamento del tratamiento"*

---

## 8. VISTAS CREADAS

### 1. `vista_citas_proximas`
Muestra todas las citas futuras con información de mascota, propietario y veterinario
**Columnas:** id_cita, mascota, propietario, telefono, veterinario, fecha_hora, motivo

### 2. `vista_ingresos_por_especialidad`
Resumen de facturación por especialidad veterinaria
**Columnas:** nombre_especialidad, total_facturas, ingresos_totales, promedio_por_factura

### 3. `vista_medicamentos_frecuentes`
Ranking de medicamentos más utilizados
**Columnas:** nombre_medicamento, descripcion, veces_prescrito, diagnosticos_tratados

---

## 9. CONSULTAS SQL PRINCIPALES

### Consulta 1: Citas por mes
Analiza el volumen de citas por mascota en cada mes

### Consulta 2: Veterinario más activo
Identifica al veterinario con mayor carga de trabajo en un período

### Consulta 3: Medicamentos más utilizados
Ranking de medicamentos para control de inventario

### Consulta 4: Ingresos por especialidad
Análisis de rentabilidad por área de especialización

### Consulta 5: Seguimiento de clientes
Identifica propietarios con mascotas sin citas recientes

### Consulta 6: Alergias registradas
Consulta de seguridad para medicamentos con riesgo

### Consulta 7: Diagnósticos y estadísticas
Análisis epidemiológico de padecimientos tratados

---

## 10. REGLAS DE NEGOCIO IMPLEMENTADAS

1. **Alergia a medicamentos**: Un propietario puede tener varias mascotas
2. **Especialidad veterinaria**: Cada mascota pertenece a una sola especie
3. **Citas con diagnóstico**: Una cita es atendida por un solo veterinario
4. **Único diagnóstico por cita**: Cada cita genera un solo diagnóstico
5. **Tratamiento multimedicamentoso**: Un diagnóstico puede tener múltiples tratamientos
6. **Facturación automática**: Se genera factura al registrar diagnóstico
7. **Validación de alergias**: Prevent prescripción de medicamentos alérgicos
8. **Validación de fechas**: No se permiten citas en fechas pasadas

---

## 11. DATOS DE PRUEBA

El script incluye datos iniciales para:
- 5 especies de animales
- 5 especialidades veterinarias
- 5 medicamentos
- 3 propietarios
- 3 veterinarios
- 4 mascotas
- 10 citas
- 10 diagnósticos
- 6 tratamientos
- 10 facturas

---

## 12. INSTRUCCIONES DE EJECUCIÓN

### Requisitos:
- PostgreSQL 17 o superior
- Acceso de administrador a la base de datos

### Pasos:
1. Conectar a PostgreSQL
2. Ejecutar el script `Veterinaria_proyecto.sql` completo
3. Verificar que no haya errores
4. Opcionalmente descomenta y ejecuta ejemplos en Sección 8

### Verificación:
```sql
-- Listar tablas
\dt

-- Verificar procedimientos
\dp

-- Verificar vistas
\dv
```

---

## 13. EJEMPLOS DE USO

### Registrar nuevo propietario:
```sql
call registrar_propietario(
    '55555555X', 
    'Juan García', 
    '600987654', 
    'juan@email.com', 
    'Calle Principal 500',
    null
);
```

### Registrar nueva mascota:
```sql
call registrar_mascota(
    'Tobías', 
    '2023-03-10', 
    1, 
    1, 
    'Ninguna',
    null
);
```

### Programar cita:
```sql
call programar_cita(
    '2025-07-15 15:00:00',
    'Vacuna anual',
    1,
    1,
    null
);
```

### Obtener historial:
```sql
SELECT * FROM historial_clinico(1);
```

---

## 14. NOTAS TÉCNICAS

- Todos los scripts están comentados en español
- El código sigue convenciones de nombres en snake_case
- Se implementan validaciones en procedimientos
- Se usan transacciones implícitas en PostgreSQL
- Las excepciones son lanzadas en casos de error
- Las vistas facilitan consultas frecuentes

---

## 15. AUTOR Y FECHA

- **Proyecto:** Sistema de Gestión Clínica Veterinaria
- **Fecha:** Junio 2025
- **Nivel:** Principiante en bases de datos

---
