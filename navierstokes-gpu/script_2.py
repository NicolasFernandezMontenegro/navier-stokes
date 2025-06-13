
import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter
import os
import matplotlib.pyplot as plt
import numpy as np

# Datos (un solo grupo)
grupo = [131408, 1127754]

# Nombres para las barras
nombres_barras = ["Mejor lab 3", "lab 4"]

colores = ['darkorange', 'seagreen']

posiciones = np.arange(len(grupo))
ancho = 0.6

fig, ax = plt.subplots(figsize=(8,5))

barras = ax.bar(posiciones, grupo, width=ancho, color=colores)

ax.set_xticks(posiciones)
ax.set_xticklabels(nombres_barras)

# Etiquetas con los valores encima de las barras
for barra in barras:
    altura = barra.get_height()
    ax.annotate(f'{altura:,}',
                xy=(barra.get_x() + barra.get_width() / 2, altura),
                xytext=(0,3),
                textcoords="offset points",
                ha='center', va='bottom', fontsize=9)
    
# Título y leyenda

plt.ylabel("Celdas por milisegundo")
plt.title("Mejor lab 3 vs Lab 4")
plt.legend()

plt.gca().yaxis.set_major_formatter(ScalarFormatter(useMathText=False))
plt.ticklabel_format(style='plain', axis='y')

os.makedirs("images", exist_ok=True)
plt.savefig(os.path.join("images", "comparacion_2"))
plt.show()

plt.tight_layout()
plt.show()



