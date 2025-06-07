import os
import re
import sys
import matplotlib.pyplot as plt

# Validación de argumentos
if len(sys.argv) < 6:
    print("Uso: python script.py carpeta1 carpeta2 carpeta3 carpeta4 salida")
    sys.exit(1)

carpetas = [sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]]
salida = f"{sys.argv[5]}.png"
labels = ["autovect", "intrinsic", "rb_base", "original"]  # Puedes cambiar estos nombres
colores = ["steelblue", "darkorange", "forestgreen", "firebrick"]

# Paso 1: leer todos los datos por carpeta y por N
rendimientos = [{} for _ in carpetas]  # Lista de diccionarios: versión -> {N: valor}

for i, carpeta in enumerate(carpetas):
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
                                rendimientos[i][N] = float(valor_str)
                            except ValueError:
                                print(f"❌ Error al convertir '{valor_str}' en {archivo}")
                        break

# Paso 2: encontrar todos los Ns comunes entre versiones
Ns_comunes = set.intersection(*[set(r.keys()) for r in rendimientos])
if not Ns_comunes:
    print("❌ No hay tamaños de matriz comunes entre todas las versiones.")
    sys.exit(1)

Ns_comunes = sorted(Ns_comunes)

# Paso 3: construir curvas de speedup relativo
relativos = [[] for _ in carpetas]  # Una lista por versión

for N in Ns_comunes:
    valores_N = [r[N] for r in rendimientos]
    minimo = min(valores_N)
    for i in range(len(carpetas)):
        relativos[i].append(round(valores_N[i] / minimo, 2))

# Paso 4: graficar
plt.figure(figsize=(10, 6))
for i in range(len(carpetas)):
    plt.plot(Ns_comunes, relativos[i], marker='o', linestyle='-', color=colores[i], label=labels[i])

plt.xticks(Ns_comunes, rotation=45, ha='right')
plt.xlabel("Tamaño de la matriz (N)")
plt.ylabel("Multiplicador de rendimiento (XN)")
plt.title("Comparación relativa de rendimiento (XN respecto al más lento)")
plt.legend()
plt.grid(True)
plt.tight_layout()

# Guardar imagen
os.makedirs("images_lab3", exist_ok=True)
plt.savefig(os.path.join("images_lab3", salida))
plt.show()
