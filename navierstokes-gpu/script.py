import sys
import re
import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter
import os

if len(sys.argv) != 3:
    print("Uso: python graficar_celdas_ms.py archivo_entrada.txt nombre_salida")
    sys.exit(1)

archivo_entrada = sys.argv[1]
salida = f"{sys.argv[2]}.png"

datos = {}
ultimo_n = None

try:
    with open(archivo_entrada, "r") as f:
        for linea in f:
            linea = linea.strip()

            # Buscar "N = número"
            match_n = re.match(r"N\s*=\s*(\d+)", linea, re.IGNORECASE)
            if match_n:
                ultimo_n = int(match_n.group(1))
                continue

            # Buscar "Celdas/ms = número"
            match_celdas = re.search(r"Celdas/ms\s*=?\s*(\d+)", linea, re.IGNORECASE)
            if match_celdas and ultimo_n is not None:
                valor = int(match_celdas.group(1))
                datos[ultimo_n] = valor
                print(f"✅ N = {ultimo_n}, Celdas/ms = {valor}")
                ultimo_n = None  # Para evitar errores si hay Celdas/ms sin N
except FileNotFoundError:
    print(f"❌ Archivo no encontrado: {archivo_entrada}")
    sys.exit(1)

if not datos:
    print("⚠️ No se encontraron datos válidos para graficar.")
    sys.exit(1)

# Graficar
datos = dict(sorted(datos.items()))
x = list(datos.keys())
y = list(datos.values())

plt.figure(figsize=(10, 6))
plt.plot(x, y, marker='o', linestyle='-', color='steelblue', label="Celdas/ms")
plt.xticks(x, rotation=45, ha='right')
plt.xlabel("Tamaño de la matriz (N)")
plt.ylabel("Celdas por milisegundo")
plt.title("Rendimiento por tamaño de celda")
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.legend()

plt.gca().yaxis.set_major_formatter(ScalarFormatter(useMathText=False))
plt.ticklabel_format(style='plain', axis='y')

plt.tight_layout()

os.makedirs("images", exist_ok=True)
plt.savefig(os.path.join("images", salida))
print(f"📊 Gráfico guardado como images/{salida}")
plt.show()
