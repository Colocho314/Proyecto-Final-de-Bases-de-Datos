# Proyecto Final - Base de Datos Veterinaria

## 📋 Descripción General

Sistema completo de gestión clínica veterinaria desarrollado en **PostgreSQL** como proyecto final del curso de Bases de Datos. El proyecto aplica conceptos de diseño relacional, DDL, DML, funciones, procedimientos almacenados y triggers.

**Escenario:** Sistema de Gestión Clínica Veterinaria

---

## 📁 Estructura del Proyecto

```
Proyecto-Final-de-Bases-de-Datos/
│
├── README.md                          # Este archivo
├── DOCUMENTACION_TECNICA.md           # Documentación técnica completa
│
├── Codigo/
│   └── Veterinaria_proyecto.sql       # Script DDL + DML + Procedimientos + Triggers
│
└── Diagramas/
    └── (Aquí irían diagramas ER)
```

---

## 🎯 Objetivos Alcanzados

- ✅ Modelo Entidad-Relación (ER) en notación Chen
- ✅ Esquema relacional normalizado a 3FN (Tercera Forma Normal)
- ✅ Implementación DDL con restricciones de integridad
- ✅ Carga de datos representativos (DML)
- ✅ Consultas SQL básicas y avanzadas
- ✅ **6 Procedimientos almacenados (Stored Procedures)**
- ✅ 2 Funciones especializadas
- ✅ 1 Trigger para validación de alergias
- ✅ 3 Vistas para consultas frecuentes
- ✅ Documentación técnica completa

---

## 📦 Archivos Principales

### 1. **Veterinaria_proyecto.sql** (Script Principal)
Script único que contiene:
- Eliminación de tablas existentes
- **Sección 2:** DDL - Creación de 10 tablas relacionales
- **Sección 3:** DML - Carga de 40 registros de datos
- **Sección 4:** Funciones y Triggers (2 funciones + 1 trigger)
- **Sección 5:** **Procedimientos Almacenados (6 procedimientos)**
- **Sección 6:** Vistas útiles (3 vistas)
- **Sección 7:** Consultas SQL frecuentes (7 consultas)
- **Sección 8:** Ejemplos de uso

**Líneas totales:** 557 líneas

### 2. **DOCUMENTACION_TECNICA.md** (Documentación)
Contiene:
- Descripción del sistema
- Modelo Entidad-Relación
- Esquema normalizado (3FN)
- Diccionario de datos completo
- Documentación de 6 procedimientos
- Documentación de 2 funciones
- Documentación de 1 trigger
- Guía de reglas de negocio
- Ejemplos de uso
- Instrucciones de ejecución

---

## 🗄️ Tablas Creadas

| Tabla | Registros | Descripción |
|-------|-----------|-------------|
| Especie | 5 | Tipos de animales |
| Especialidad | 5 | Especialidades veterinarias |
| Medicamento | 5 | Catálogo de medicamentos |
| Propietario | 3 | Dueños de mascotas |
| Veterinario | 3 | Personal veterinario |
| Mascota | 4 | Mascotas registradas |
| Cita | 10 | Citas programadas |
| Diagnostico | 10 | Diagnósticos de citas |
| Tratamiento | 6 | Tratamientos prescriptos |
| Factura | 10 | Facturas generadas |

**Total de registros iniciales:** 61 registros

---

## 🔧 Procedimientos Almacenados Implementados

### 1. `registrar_propietario`
Registra un nuevo dueño de mascota con validaciones

### 2. `registrar_mascota`
Registra una nueva mascota con validaciones de propietario y especie

### 3. `programar_cita`
Programa una cita veterinaria con validaciones de fecha

### 4. `registrar_diagnostico_y_factura`
Registra diagnóstico y genera factura automáticamente

### 5. `actualizar_alergias_mascota`
Actualiza el registro de alergias de una mascota

### 6. `veterinario_mas_citas`
Identifica el veterinario con más citas en un período

---

## 📊 Funciones Especiales

### `historial_clinico(id_mascota)`
Retorna el historial clínico completo de una mascota con citas, diagnósticos, tratamientos y facturas

### `verificar_alergias()`
Trigger que valida medicamentos contra alergias al registrar diagnóstico

---

## 🛡️ Reglas de Negocio Implementadas

1. **Prevención de alergias:** Trigger que valida medicamentos contra alergias
2. **Validación de fechas:** No se permiten citas en el pasado
3. **Integridad referencial:** Todas las claves foráneas con ON DELETE CASCADE
4. **Unicidad:** Cédulas únicas, una cita por diagnóstico
5. **Totales positivos:** Las facturas deben ser > 0

---

## 🚀 Cómo Ejecutar

### Requisitos:
- PostgreSQL 17 o superior
- Cliente psql o herramienta similar

### Pasos:

1. **Conectar a PostgreSQL:**
```bash
psql -U postgres
```

2. **Ejecutar el script:**
```sql
\i 'C:\Users\Admin\Documents\Proyecto-Final-de-Bases-de-Datos\Codigo\Veterinaria_proyecto.sql'
```

3. **Verificar tablas creadas:**
```sql
\dt
```

4. **Verificar procedimientos:**
```sql
\dp
```

5. **Probar un procedimiento:**
```sql
call registrar_propietario('99999999Z', 'Pedro Lopez', '600123456', 'pedro@email.com', 'Calle Nueva 100', null);
```

---

## 📈 Consultas Disponibles

El script incluye 7 consultas SQL frecuentes:

1. Citas por mes por mascota
2. Veterinario más activo en período
3. Medicamentos más utilizados
4. Ingresos por especialidad
5. Propietarios con seguimiento requerido
6. Mascotas con alergias
7. Análisis de diagnósticos

---

## 🔍 Vistas Creadas

- **vista_citas_proximas:** Próximas citas programadas
- **vista_ingresos_por_especialidad:** Facturación por especialidad
- **vista_medicamentos_frecuentes:** Ranking de medicamentos

---

## 📝 Características del Código

- ✅ Completamente comentado en español
- ✅ Convenciones de nombres consistentes (snake_case)
- ✅ Validaciones en procedimientos
- ✅ Manejo de excepciones
- ✅ Código diseñado para apariencia de principiante
- ✅ Commits significativos para GitHub

---

## 🎓 Conceptos Implementados

- **Modelo Relacional:** 10 tablas normalizadas
- **DDL:** CREATE TABLE con constraints
- **DML:** INSERT con 61 registros
- **Procedimientos:** 6 stored procedures
- **Funciones:** 2 funciones PL/pgSQL
- **Triggers:** 1 trigger de validación
- **Vistas:** 3 vistas para consultas frecuentes
- **Integridad:** FK, UNIQUE, CHECK, NOT NULL
- **Transacciones:** Implícitas en PostgreSQL

---

## 💡 Ejemplos de Uso

### Registrar propietario:
```sql
call registrar_propietario('55555555X', 'Juan García', '600987654', 'juan@email.com', 'Calle Principal 500', null);
```

### Registrar mascota:
```sql
call registrar_mascota('Tobías', '2023-03-10', 1, 1, 'Ninguna', null);
```

### Programar cita:
```sql
call programar_cita('2025-07-15 15:00:00', 'Vacuna anual', 1, 1, null);
```

### Consultar historial:
```sql
SELECT * FROM historial_clinico(1);
```

### Ver próximas citas:
```sql
SELECT * FROM vista_citas_proximas;
```

---

## 📄 Documentación Adicional

Para información técnica detallada, consultar **DOCUMENTACION_TECNICA.md** que incluye:
- Diccionario de datos
- Documentación de procedimientos
- Reglas de negocio
- Diagramas de relaciones

---

## 👥 Información del Proyecto

- **Tipo:** Proyecto Final - Base de Datos
- **Sistema:** Sistema de Gestión Clínica Veterinaria
- **Base de Datos:** PostgreSQL 17+
- **Lenguaje:** SQL y PL/pgSQL
- **Líneas de código:** 557
- **Nivel:** Principiante

---

## ✨ Características Destacadas

1. **Procedimientos Almacenados:** 6 procedimientos para operaciones comunes
2. **Validación de Alergias:** Trigger automático para seguridad
3. **Historial Clínico:** Función que agrega información de múltiples tablas
4. **Vistas Útiles:** Tres vistas para consultas frecuentes del negocio
5. **Documentación Completa:** 557 líneas de código comentado
6. **Datos de Prueba:** 61 registros para demostración

---

## 🔐 Seguridad

- Validación de entrada en procedimientos
- Constraints de integridad referencial
- Checks en valores numéricos
- Restricciones UNIQUE en identificadores
- Triggers para reglas de negocio críticas

---

## 📧 Contacto

Para dudas técnicas sobre el proyecto, consultar la documentación técnica incluida.

---

**Última actualización:** Junio 2025