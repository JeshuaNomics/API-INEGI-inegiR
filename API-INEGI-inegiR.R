# API-INEGI-inegiR
# library(devtools)
install.packages("inegiR")
library(inegiR)
# ?inegiR

token_inegi <- "[Token]"

# PIB_corriente
PIB_trimestral_corriente <- inegi_series(serie = "494782", 
                              token = token_inegi)
class(PIB_corriente)
tail(PIB_corriente)

# PIB_trimestral_constante
# Descargar los datos en formato tibbletime.
PIB_trimestral_constante <- inegi_series(serie = "494782", 
                                         token = token_inegi, 
                                         as_tt = TRUE)
class(gdp)
tail(gdp)

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
frecuencias <- incat_freq(token_inegi)

# Todas las funciones específicas de los indicador comienzan con inind_ 
# (la tasa de desempleo).

# Descargar PIB y desempleo.
# Existe una función para descargar un vector de más de una serie
# (no es necesario que tengan la misma frecuencia). 
Series <- c("494782", "444612")
Nombre_de_las_series <- c("PIB trimestral constante", 
                          "Tasa de desempleo")

Datos_investigación <- inegi_series_multiple(series_id = Series, 
                                          token = token_inegi, 
                                          names = Nombre_de_las_series)