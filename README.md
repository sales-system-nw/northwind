## Integrantes
| Nombre                      | Correo                      |
|-----------------------------|-----------------------------|
| Trujillo Montan Omar        | 201706452@est.umss.edu      |
| Roque Cerrogrande Edwin     | 201706711@est.umss.edu      |

# 📊 Northwind Data Warehouse

[![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)](https://www.microsoft.com/sql-server)
[![SSIS](https://img.shields.io/badge/SSIS-512BD4?style=for-the-badge&logo=.net&logoColor=white)](https://docs.microsoft.com/en-us/sql/integration-services/)
[![T-SQL](https://img.shields.io/badge/T--SQL-0078D4?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)](https://docs.microsoft.com/en-us/sql/t-sql/)

## 📝 Descripción del Proyecto
Este proyecto consiste en el diseño e implementación de un **Data Warehouse (DW)** basado en la base de datos transaccional **Northwind (OLTP)**. 

Se desarrolló un **modelo dimensional tipo estrella**, junto con un proceso **ETL** (Extract, Transform, Load) para la carga de datos desde el sistema operacional hacia el almacén de datos, permitiendo análisis avanzado de ventas e inteligencia de negocios.

---

## 🗺️ Tabla de Contenidos
- [Objetivos](#-objetivos)
- [Dominio de Negocio](#-dominio-de-negocio)
- [Modelo Dimensional](#-modelo-dimensional)
- [Proceso ETL](#-proceso-etl)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Instrucciones de Despliegue](#-instrucciones-de-despliegue)
- [Tecnologías](#-tecnologías-utilizadas)

---

## 🎯 Objetivos
- [x] Transformar un modelo OLTP en un modelo analítico (DW).
- [x] Implementar un esquema estrella optimizado para consultas.
- [x] Diseñar un proceso ETL robusto e incremental.
- [x] Facilitar el análisis de información histórica de ventas.

---

## Dominio de Negocio

El sistema está enfocado en el dominio de ventas, basado en la base de datos Northwind.

### Entidades principales:
- Customers (Clientes)
- Orders (Pedidos)
- Order Details (Detalle de pedidos)
- Products (Productos)
- Employees (Empleados)
- Shippers (Transportistas)

### Relaciones:
- Un cliente puede realizar muchos pedidos
- Un pedido puede contener múltiples productos
- Un empleado gestiona múltiples pedidos
- Un transportista distribuye pedidos

### Reglas de negocio básicas:
- Cada pedido debe estar asociado a un cliente
- Cada pedido debe tener al menos un producto
- Los pedidos tienen fechas (orden, envío, requerimiento)

---

## Alcance del Sistema

El sistema permite:
- Registrar y gestionar pedidos
- Analizar ventas históricas
- Evaluar desempeño de empleados
- Analizar productos y clientes

El Data Warehouse está orientado exclusivamente a análisis y toma de decisiones.

---

## Modelo Dimensional

El Data Warehouse fue diseñado utilizando un modelo estrella, donde una tabla de hechos central se relaciona con múltiples dimensiones.

<img width="662" height="832" alt="image" src="https://github.com/user-attachments/assets/f64f8000-3d63-4546-b86a-b355ad83c11f" />

### Tabla de Hechos

#### FactOrders
Contiene las métricas principales del negocio relacionadas con pedidos.

## FactOrders
| Campo          | Descripción                     |
|----------------|---------------------------------|
| OrderID        | Identificador del pedido        |
| ProductID      | Identificador del producto      |
| OrderDateKey   | Clave de fecha de orden         |
| RequiredDateKey| Clave de fecha requerida        |
| ShippedDateKey | Clave de fecha de envío         |
| CustomerSK     | Clave surrogate cliente         |
| ProductSK      | Clave surrogate producto        |
| EmployeeSK     | Clave surrogate empleado        |
| ShipperSK      | Clave surrogate transportista   |
| Quantity       | Cantidad                        |
| UnitPrice      | Precio unitario                 |
| Discount       | Descuento                       |
| OrderDate      | Fecha de orden                  |
| RequiredDate   | Fecha requerida                 |
| ShippedDate    | Fecha de envío                  |


---

### Tablas Dimensionales

## DimCustomer
| Campo          | Descripción                     |
|----------------|---------------------------------|
| CustomerSK     | Clave surrogate cliente         |
| CustomerID     | ID cliente                      |
| CompanyName    | Nombre empresa                  |
| ContactName    | Nombre contacto                 |
| ContactTitle   | Cargo contacto                  |
| Address        | Dirección                       |
| City           | Ciudad                          |
| Region         | Región                          |
| PostalCode     | Código postal                   |
| Country        | País                            |
| Phone          | Teléfono                        |
| Fax            | Fax                             |

---

## DimProduct
| Campo          | Descripción                     |
|----------------|---------------------------------|
| ProductSK      | Clave surrogate producto        |
| ProductID      | ID producto                     |
| ProductName    | Nombre producto                 |
| CategoryName   | Categoría                       |
| CompanyName    | Empresa                         |
| QuantityPerUnit| Cantidad por unidad             |
| UnitPrice      | Precio unitario                 |
| UnitsInStock   | Stock                           |
| UnitsOnOrder   | En pedido                       |
| ReorderLevel   | Nivel de reorden                |
| Discontinued   | Descontinuado                   |


## DimEmployee
| Campo             | Descripción                     |
|-------------------|---------------------------------|
| EmployeeSK        | Clave surrogate empleado        |
| EmployeeID        | ID empleado                     |
| LastName          | Apellido                        |
| FirstName         | Nombre                          |
| Title             | Cargo                           |
| TitleOfCourtesy   | Tratamiento                     |
| BirthDate         | Fecha de nacimiento             |
| HireDate          | Fecha de contratación           |
| Address           | Dirección                       |
| City              | Ciudad                          |
| Region            | Región                          |
| PostalCode        | Código postal                   |
| Country           | País                            |
| HomePhone         | Teléfono                        |
| Extension         | Extensión                       |
| Photo             | Foto                            |
| Notes             | Notas                           |
| ReportsTo         | Reporta a                       |
| PhotoPath         | Ruta foto                       |
| TextionDescription| Descripción extra               |

## DimDate
| Campo     | Descripción                     |
|-----------|---------------------------------|
| DateKey   | Clave fecha                     |
| FullDate  | Fecha completa                  |
| Year      | Año                             |
| Quarter   | Trimestre                       |
| Month     | Mes                             |
| MonthName | Nombre mes                      |
| Day       | Día                             |


## DimShipper
| Campo       | Descripción                     |
|-------------|---------------------------------|
| ShipperSK   | Clave surrogate transportista   |
| ShipperID   | ID transportista                |
| CompanyName | Nombre empresa                  |
| Phone       | Teléfono                        |


## Proceso ETL

### 1. Extracción
Datos extraídos desde el sistema OLTP Northwind.

### 2. Staging
Tablas utilizadas:
- staging.Customer
- staging.Product
- staging.Employee
- staging.Orders
- staging.Shipper

Función:
- Área intermedia
- Preparación de datos
- Separación OLTP y DW

### 3. Transformación
- Conversión de fechas a DateKey
- Homologación de estructuras
- Preparación de claves sustitutas

### 4. Carga
Procedimientos utilizados:
- DW_MergeDimCustomer
- DW_MergeDimEmployee
- DW_MergeDimProduct
- DW_MergeDimShipper
- DW_MergeFactOrders

Tipo de carga:
- Inserción de nuevos registros
- Actualización de registros existentes

No se realizan eliminaciones físicas para preservar datos históricos.

### 5. Carga Incremental

Tabla:
- PackageConfig

Procedimientos:
- GetLastPackageRowVersion
- UpdateLastPackageRowVersion

Permite:
- Procesar solo datos nuevos o modificados
- Optimizar el rendimiento

#### Lógica del Delta Load (Incremental)
El sistema utiliza el tipo de dato `rowversion` de SQL Server para identificar registros modificados en el origen (OLTP). 
1. Se obtiene el último `rowversion` procesado desde `PackageConfig`.
2. El procedimiento `GetOrdersChangesByRowVersion` extrae solo los registros mayores a ese valor.
3. Al finalizar la carga, se actualiza el punto de control para la siguiente ejecución.
Esto reduce drásticamente el tráfico de red y el tiempo de procesamiento en cargas recurrentes.

---

## Tecnologías Utilizadas
- SQL Server
- SQL Server Integration Services (SSIS)
- Transact-SQL (T-SQL)
- GitHub

---

## Estructura del Proyecto
- /OLTP
- /DW
- /ETL
- /DACPAC
- README.md

---

## Instrucciones para Desplegar

### 1. Requisitos
- SQL Server
- SQL Server Management Studio (SSMS)
- Visual Studio con SSDT (opcional)

### 2. Crear base de datos OLTP
1. Abrir SSMS
2. Ejecutar el script de Northwind
3. Crear tablas e insertar datos

### 3. Crear Data Warehouse
Ejecutar:
    CREATE DATABASE NorthwindDW;

Luego ejecutar los scripts del DW.

### 4. Ejecutar ETL
Ejecutar los procedimientos:
- DW_MergeDimCustomer
- DW_MergeDimEmployee
- DW_MergeDimProduct
- DW_MergeDimShipper
- DW_MergeFactOrders

### 5. Poblar DimDate
Ejecutar:
EXEC FillDimDate;

### 6. (Opcional) DACPAC
1. Abrir Visual Studio
2. Importar proyecto
3. Compilar
4. Publicar

### 7. Validación
- Verificar tablas pobladas
- Validar claves foráneas
- Ejecutar consultas de prueba
---

## Repositorio
https://github.com/sales-system-nw/northwind

---

## Consideraciones
- Basado en Northwind OLTP
- ETL con inserciones y actualizaciones
- No se eliminan datos
- No se implementa SCD (fuera de alcance)

---

## Resultados
El sistema permite:
- Análisis de ventas
- Evaluación de empleados
- Seguimiento de pedidos
- Análisis temporal
