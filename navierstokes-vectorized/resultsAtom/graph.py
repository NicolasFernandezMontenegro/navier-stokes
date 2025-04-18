import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

# Datos
N = [124, 256, 512, 1024]
rend_autovec = [15688944.460525, 14950441.677908, 14777207.806095, 10057240.887081]
rend_intrinsic = [17389592.304660, 15844454.106745, 14964990.153785, 11157966.760930]
rend_RNBASE = [7981360.012572, 7754400.036564, 7457822.286061, 6377025.037852]

# Formateador para millones
def millones_formatter(x, _):
    return f'{x/1e6:.0f}M'

# Gráfico
plt.figure(figsize=(9, 6))
plt.plot(N, rend_autovec, marker='o', label='Autovec', color='skyblue', linewidth=2)
plt.plot(N, rend_intrinsic, marker='s', label='Intrinsic', color='salmon', linewidth=2)
plt.plot(N, rend_RNBASE, marker='^', label='RNBASE', color='lightgreen', linewidth=2)

plt.yscale('log')
plt.ylim(5e6, 2e7)
plt.yticks([6e6, 8e6, 10e6, 12e6, 14e6, 16e6, 18e6, 20e6])
plt.gca().yaxis.set_major_formatter(ticker.FuncFormatter(millones_formatter))

plt.xticks(N)  # Mostrar N exactos en el eje X
plt.xlabel('Tamaño del problema (N)')
plt.ylabel('Rendimiento (Celdas/segundo)')
plt.grid(True, which="both", axis='y', linestyle='--', linewidth=0.5)
plt.legend(loc='upper center', bbox_to_anchor=(0.5, 1.1), ncol=3)

plt.tight_layout()
plt.show()
