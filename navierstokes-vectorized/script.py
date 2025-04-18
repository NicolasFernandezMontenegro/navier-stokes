import os
import re
import sys
import matplotlib.pyplot as plt

# Ruta de la carpeta con los archivos
carpeta = sys.argv[1] 
salida = f"{sys.argv[2]}.png"

# Diccionario para guardar los resultados
datos = {}

# Buscar todos los archivos en la carpeta
for archivo in os.listdir(carpeta):
    if archivo.endswith(".txt"):
        ruta = os.path.join(carpeta, archivo)
        with open(ruta, "r") as f:
            for linea in f:
                if "cells per sec" in linea:
                    # Extrae el número antes de "cells per sec"
                    match = re.search(r"([\d.,]+)\s+cells per sec", linea)
                    if match:
                        valor = match.group(1).replace(".", "").replace(",", ".")
                        try:
                       	    nombre_limpio = archivo.replace(".txt", "")  
                            datos[nombre_limpio] = float(valor)
                        except ValueError:
                            print(f"No se pudo convertir '{valor}' en {archivo}")
                    break  # ya encontramos lo que necesitábamos

# Ordenar los datos por valor descendente (opcional)
datos = dict(sorted(datos.items(), key=lambda x: x[1], reverse=False))

# Generar gráfico
plt.figure(figsize=(10, 6))
plt.bar(datos.keys(), datos.values(), color='skyblue')
plt.xticks(rotation=45, ha='right')
plt.ylabel("Celdas por segundo")
plt.title("Comparación de rendimiento (cells/sec)")
plt.tight_layout()
plt.grid(True, linestyle='--', alpha=0.1)
plt.savefig(os.path.join("images", salida))
plt.show()
