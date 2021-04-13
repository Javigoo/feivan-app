import csv

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

nodos = {}
for row in data.values():
    tmp = ""
    for element in row:
        if element[0].isupper():
            tmp = element
            nodos[element] = []
        else:
            nodos[tmp].append(element)
print()

import graphviz as gv
g = gv.Graph(format="png")


nodo_edge = {}
for key in nodos.keys():
    for values in nodos.values():
        for value in values:
            if key.lower() == value:
                nodo_edge[key] = value

for key in nodos:
    if key in nodo_edge:
        for value in nodos[key]:
            g.edge(key.lower(), value)
    else:
        for value in nodos[key]:
            g.edge(key, value)

print()
g.render(view=True)
