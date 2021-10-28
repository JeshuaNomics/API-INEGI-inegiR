# API-INEGI-inegiR
# install.packages("devtools")
install.packages("inegiR")

# library(devtools)
library(inegiR)

# Responder dudas sobre el paquete
?inegiR

# https://www.inegi.org.mx/app/desarrolladores/generatoken/Usuarios/token_Verify
token_inegi <- "[Token]"

# PIB_trimestral_corriente
PIB_trimestral_corriente <- inegi_series(serie = "494782", 
                              token = token_inegi)
class(PIB_trimestral_corriente)
tail(PIB_trimestral_corriente)

# PIB_trimestral_constante
# (descargar los datos en formato tibbletime)
PIB_trimestral_constante <- inegi_series(serie = "494782", 
                                         token = token_inegi, 
                                         as_tt = TRUE)
class(PIB_trimestral_constante)
tail(PIB_trimestral_constante)

# Metadata
# Cuidado: No todos los formatos de fecha son compatibles 
# (solo datos anuales, trimestrales, mensuales y quincenales).
# Existe una nueva columna date_shortcut
# (facilita ver la frecuencia de la serie).
PIB <- inegi_series(series_id = "494782", 
                    token = token_inegi, 
                    metadata = TRUE)
Metadata_del_PIB <- t(PIB$metadata)

# Obtener las descripciones del código
# (funciones que comienzan con incat_).
Frecuencias <- incat_freq(token_inegi)
Recuros <- incat_source(token_inegi)
Notas <- incat_notes(token_inegi)
Tema <- incat_topic(token_inegi)
Indicador <- incat_indicator(token_inegi)

# Todas las funciones específicas de los indicador comienzan con inind_ 
# (como la tasa de desempleo: inind_unemp(token)).
inind_commerce(token_inegi)
inind_auto(token_inegi)
inind_gdp(token_inegi)
inind_fx(token_inegi)
inind_unemp(token_inegi)
inind_prices(token_inegi)

# Descargar PIB y desempleo.
# Existe una función para descargar un vector de más de una serie
# (no es necesario que tengan la misma frecuencia). 
Series <- c("494782", "444612")
Nombre_de_las_series <- c("PIB trimestral constante", 
                          "Tasa de desempleo")

Datos_investigación <- inegi_series_multiple(series_id = Series, 
                                          token = token_inegi, 
                                          names = Nombre_de_las_series)

# Conjunto de coordenadas de cuadrícula
latitud1 <- 25.66919
latitud2 <- 25.169194
longitud1 <- -100.30990
longitud2 <- -101.20102
Conjunto_de_coordenadas <- make_grid(latitud1, 
                                     latitud2,
                                     longitud1,
                                     longitud2, 
                                     space_lat = 0.07,
                                     space_lon = 0.07)

# Neumonics son nombres abreviados para series de datos económicos
# (similares a los nombres de Fed FRED).
Catálogo <- incat_neumonics()

# Exportaciones, importaciones y balanza comercial 
# (todos los productos, servicios y países)
Comercio_externo <- inegi_tradebal(token_inegi)

# Balanza de pagos 
# (Devuelve los ingresos, gastos y total de la Cuenta Corriente, 
# total de la Cuenta Financiera, errores, reservas y ajustes para México).
Balanza_de_pagos <- inegi_bop(token_inegi)

# Empresas registradas en DENUE en las proximidades de las coordenadas proporcionadas.
latitud <- 25.669194
longitud <- -100.30990
Empresas <- inegi_denue(latitud, 
                        longitud, 
                        token_inegi, 
                        meters = 1000)

# Empresas registrados en el DENUE en espacios superiores a 5 kilómetros.
latitud1 <- 25.669194
latitud2 <- 25.169194
longitud1 <- -100.30990
longitud2 <- -101.20102
Empresas <- inegi_denue_grid(latitud1, 
                             latitud2, 
                             longitud1, 
                             longitud2, 
                             token_inegi)

# Estadísticas básicas de empresas, utilizando DENUE, en la proximidad de coordenadas.
Marco_de_datos <- as.data.frame(latitud  = c(25.669194, 25.121194),
                                longitud = c(-100.30990, -99.81923))
Estadísticas <- denue_varios_stats(data = Marco_de_datos, 
                                   col_lat = 1,
                                   col_long = 2,
                                   metros = 500)

# Devuelve data.frame con id y coordenadas que coinciden con los nombres de la API.
Densidad_de_ID <- inegi_destiny("monterrey", token_inegi)

# Devuelve las exportaciones a los principales socios comerciales de todos los productos. 
# (Estados Unidos, Canadá, China, Centroamérica, Sudamérica).
Exportaciones_por_país <- inegi_partner_exports(token_inegi)

# Utiliza la API de SAKBE para devolver una ruta entre dos identificaciones de destino
# (considerando los parámetros dados).
# Preference: 
# 1 = with tolls (cuota), 
# 2 = without tolls (libre), 
# 2 = suggested route)
# vehicle: 
# 0 = motorcycle, 
# 1 = auto, 
# 2 = two axis bus, 
# 3 = three axis bus, 
# 4 = four axis bus, 
# 5 = two axis truck, 
# 6 = three axis truck, 
# 7 = four axis truck, 
# 8 = five axis truck, 
# 9 = six axis truck, 
# 10 = seven axis truck, 
# 11 = eight axis truck, 
# 12 = nine axis truck.
# calc_cost:	
# TRUE = Use the price of gasoline to calculate total cost of trip. 
route <- inegi_route(from = 6940, to = 57, token_inegi, pref = 2, vehicle = 1)

# Devuelve índices del sector económico según lo definido en INEGI 
# (subsectores de IGAE). 
# (series no desestacionalizada).
inegi_sectors(token_inegi)

# Devuelve el índice de precios para estudiantes. 
inegi_stind(token_inegi)

# Devuelve los términos de intercambio de México 
# (índice de precios de las exportaciones sobre el índice de precios de las importaciones).
inegi_tot(token_inegi)