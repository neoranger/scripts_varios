# -*- coding: utf-8 -*-
from re import sub
from sys import argv
if(len(argv) != 2):
    print('Usage:\n  python', __file__, '<file>')
    exit()
lista = open(argv[1]).read().strip().split('\n')
campos = ['C.U.I.T.', 'C.U.I.L.', 'C.D.I.', 'D.N.I.']
failed = []
for renglon in lista:
    try:
        line = ''
        for campo in campos:
            if(campo in renglon):
                #print(campo, ' Encontrado.')
                line = line + '{} : {}'.format(
                campo,
                renglon.split(campo)[1].split()[1].replace('.', '')
                ).ljust(30)
        print(line)
    except:
        failed.append(renglon)
if(len(failed) > 0):
    print('Failed lines:\n' + '\n'.join(failed))
