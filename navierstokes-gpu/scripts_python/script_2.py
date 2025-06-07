import os
import re
import sys
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

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
                    match = re.search(r"([\d.,]+)\s+cells per sec", linea)
                    if match:
                        valor = match.group(1).replace(".", "").replace(",", ".")
                        try:
                            nombre_limpio = archivo.replace(".txt", "")  
                            datos[nombre_limpio] = float(valor)
                        except ValueError:
                            print(f"No se pudo convertir '{valor}' en {archivo}")
                    break

# Ordenar datos por valor ascendente (el menor primero)
datos = dict(sorted(datos.items(), key=lambda x: x[1]))

# Calcular el valor mínimo
valor_minimo = min(datos.values())

# Calcular los multiplicadores relativos al mínimo
datos_relativos = {k: round(v / valor_minimo, 2) for k, v in datos.items()}

# Generar gráfico
plt.figure(figsize=(10, 6))
barras = plt.bar(datos_relativos.keys(), datos_relativos.values(), color='royalblue')
plt.xticks(rotation=45, ha='right')
plt.ylabel("Multiplicador (x)")
plt.title("Comparación de rendimiento relativo")

# Mostrar los valores arriba de cada barra
for bar in barras:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2, yval + 0.05, f"x{yval}", ha='center', va='bottom')

plt.tight_layout()
plt.grid(False)
plt.savefig(os.path.join("images", salida))
plt.show()

