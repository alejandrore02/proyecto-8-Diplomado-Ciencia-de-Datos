
library(tidyverse)
library(janitor)

# 1. Leer el CSV grande solo una vez (esto se hace localmente)
data <- read_csv(
  "data/FoodBalanceSheets_E_All_Data_(Normalized).csv",
  locale = locale(encoding = "UTF-8"),
  show_col_types = FALSE
)

# 2. Filtrar solo lo que realmente usas
indicadores_nutricion <- c(664, 674)

data_filtrada <- data %>%
  janitor::clean_names() %>%
  select(area_code, area, year, item, element_code, element, value, unit) %>% 
  mutate(year = as.numeric(year)) %>%
  filter(element_code %in% indicadores_nutricion) %>%
  mutate(
    indicador = dplyr::case_when(
      element_code == 664 ~ "food_supply_kcal_per_capita",
      element_code == 674 ~ "protein_supply_g_per_capita",
      TRUE ~ "other"
    )
  ) %>%
  tidyr::pivot_wider(
    names_from  = indicador,
    values_from = value,
    id_cols     = c(area_code, area, year, item),
    values_fn   = mean
  ) %>%
  drop_na(food_supply_kcal_per_capita, protein_supply_g_per_capita)

# 3. Guardar versión comprimida en .rds
# Puedes subir compresión si quieres aún más pequeño: compress = "xz"
saveRDS(
  data_filtrada,
  file = "data/data_filtrada.rds",
  compress = "xz"
)

# Checar tamaño
print(file.info("data/data_filtrada.rds")$size)