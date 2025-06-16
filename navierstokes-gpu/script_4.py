import matplotlib.pyplot as plt

# Datos
grupoN = [1, 2, 3]  # Valores del eje x
grupo1 = [25270, 51614, 1127754]
grupo2 = [20869, 131466, 1145321]

# Crear gráfico
plt.figure(figsize=(8, 5))

# Trazar líneas para cada grupo
plt.plot(grupoN, grupo1, marker='o', color='blue', label='Grupo 1')
plt.plot(grupoN, grupo2, marker='s', color='red', label='Grupo 2')

# Etiquetas
plt.xlabel('Grupo N')
plt.ylabel('Valores')
plt.title('Comparación entre Grupo 1 y Grupo 2')
plt.xticks(grupoN)  # Asegurar que los puntos del eje x sean exactamente los de grupoN
plt.legend()
plt.grid(True)

# Mostrar gráfico
plt.tight_layout()
plt.tight_layout()
plt.savefig('grafico.png') 
