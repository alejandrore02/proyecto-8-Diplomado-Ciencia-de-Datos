# Proyecto:  Análisis del Consumo de Alimentos y Nutrición

## Autores

+ Corral Robles Leonardo
+ Mondragon Velazquez Lorenzo Jesus
+ Ruiz Escamilla Alejandro.

## Overview

Este proyecto desarrolla un dashboard interactivo en **R** (**flexdashboard** + **Shiny**) para analizar el suministro mundial de alimentos, tanto en términos de energía _(kcal / cápita / día)_ como de proteínas _(g / cápita / día)_, usando información oficial de:

+ **FAOSTAT** – Food Balance Sheets (FBS)
+ **Banco Mundial (WDI)** – PIB per cápita (NY.GDP.PCAP.CD)

## Obtención y preparación de los datos FAOSTAT (FBS)

El presente proyecto utiliza información proveniente de **FAOSTAT – Food Balance Sheets (FBS)**, que recopila datos estandarizados sobre el suministro alimentario mundial.  
La base puede consultarse y descargarse desde:

**https://www.fao.org/faostat/en/#data/FBS**

Para asegurar la comparabilidad entre países y años, utilizamos la versión **normalizada (Normalized)** del conjunto de datos.

El dashboard lo carga automáticamente mediante:

```r
data <- read_csv(
  "data/FoodBalanceSheets_E_All_Data_(Normalized).csv",
  locale = locale(encoding = "UTF-8"),
  show_col_types = FALSE
)
