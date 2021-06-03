import csv

"""
data = {}
for num in range(0,26):
    data[num] = []

with open('Jerarquía - Hoja 1.csv', encoding='utf-8') as f:  
    csv = csv.reader(f)
    for row in enumerate(csv):
        for element in enumerate(row[1]):
            if element[1] != '':
                data[element[0]].append(element[1])
#print(data)
"""

# Leemos el archivo y obtenemos un diccionario {numero de fila: lista de valores de cada columna}
with open('Jerarquía - Hoja 1.csv', encoding='utf-8') as f:
    data = {}
    csv = csv.reader(f)
    for i, row in enumerate(csv):
        for j, element in enumerate(row):
            if element != '':
                if j not in data:
                    data[j] = []
                data[j].append(element.strip())
        

# Procesamos el diccionario "data" y generamos otro diccionario {valor del nodo: lista de elementos que lo conforman}
nodos = {}
for column in data.values():
    tmp = ""
    for element in column:
        if element.isupper():
            tmp = element
            nodos[element] = []
        elif tmp != "":
            nodos[tmp].append(element)

import graphviz as gv
g = gv.Graph(format="svg")


# Se conectan los nodos anidados (NODO -> nodo)
nodo_edge = {}
for key in nodos.keys():
    for values in nodos.values():
        for value in values:
            if key.lower() == value:
                nodo_edge[key] = value

for key in nodos:
    for value in nodos[key]:
        if key in nodo_edge:
            g.edge(key.lower(), value)
        else:
            g.edge(key, value)

g.render(view=True)
