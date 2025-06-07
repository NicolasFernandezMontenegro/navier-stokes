import os
import re
import sys
import matplotlib.pyplot as plt

# Leer argumentos
carpetas = [sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]]
salida = f"{sys.argv[5]}.png"
labels = ["autovect", "intrinsic", "rb_base", "original"]  # Puedes cambiar estos nombres
colores = ["steelblue", "darkorange", "forestgreen", "firebrick"]

plt.figure(figsize=(10, 6))

for i, carpeta in enumerate(carpetas):
    datos = {}

    # Leer archivos en la carpeta
    for archivo in os.listdir(carpeta):
        match_archivo = re.match(r".*_(\d+)\.txt", archivo, re.IGNORECASE)
        if match_archivo:
            N = int(match_archivo.group(1))
            ruta = os.path.join(carpeta, archivo)
            with open(ruta, "r") as f:
                for linea in f:
                    if "cells per sec" in linea.lower():
                        match_valor = re.search(r"([\d.,]+)\s+cells per sec", linea)
                        if match_valor:
                            valor_str = match_valor.group(1).replace(".", "").replace(",", ".")
                            try:
                                datos[N] = float(valor_str)
                            except ValueError:
                                print(f"❌ Error al convertir '{valor_str}' en {archivo}")
                        break

    if not datos:
        print(f"⚠️  No se encontraron datos en la carpeta: {carpeta}")
        continue

    # Ordenar y graficar
    datos = dict(sorted(datos.items()))
    x = list(datos.keys())
    y = list(datos.values())
    plt.plot(x, y, marker='o', linestyle='-', color=colores[i], label=labels[i])

# Etiquetas del eje X: todos los N encontrados en las 3 carpetas
todos_n = sorted(set().union(*[set(re.findall(r"\d+", f)) for c in carpetas for f in os.listdir(c)]))
xticks = sorted(set(int(n) for n in todos_n if n.isdigit()))
plt.xticks(xticks, rotation=45, ha='right')

# Ejes y título
plt.xlabel("Tamaño de la matriz (N)")
plt.ylabel("Cells/ms)")
plt.title("Comparación cells per microsec")
plt.legend()
plt.tight_layout()

#Guardar grafico
os.makedirs("images_lab3", exist_ok=True)
plt.savefig(os.path.join("images_lab3", salida))
plt.show()