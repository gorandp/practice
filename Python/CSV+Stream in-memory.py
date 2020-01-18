import io
import csv

myText = """long,lat,tipo_sitio,id_arbol,altura_tot,diametro,inclinacio,id_especie,nombre_fam,nombre_gen,nombre_cie,nombre_com,tipo_folla,origen,codigo_man,barrio,comuna,calle,chapa1,chapa2
-58.3890587967,-34.6200256156,Árbol,2430,7,20,17,1,Oleáceas,Fraxinus,Fraxinus pennsylvanica,Fresno americano,Árbol Latifoliado Caducifolio,Exótico,14-017,CONSTITUCION,1,"Calvo, Carlos",1609,0
-58.389211331700004,-34.6200342718,Árbol,2431,8,33,16,1,Oleáceas,Fraxinus,Fraxinus pennsylvanica,Fresno americano,Árbol Latifoliado Caducifolio,Exótico,14-017,CONSTITUCION,1,"Calvo, Carlos",1617,0
-58.389268791400006,-34.6200374616,Árbol,2432,2,3,0,9,Oleáceas,Ligustrum,Ligustrum lucidum,Ligustro,Árbol Latifoliado Perenne,Exótico,14-017,CONSTITUCION,1,"Calvo, Carlos",1629,0
-58.3895252334,-34.6200520397,Árbol,2433,9,17,0,7,Aceráceas,Acer,Acer negundo,Arce negundo,Árbol Latifoliado Caducifolio,Exótico,14-017,CONSTITUCION,1,"Calvo, Carlos",0,0
-58.389607770299996,-34.6200566868,Árbol,2434,6,13,14,1,Oleáceas,Fraxinus,Fraxinus pennsylvanica,Fresno americano,Árbol Latifoliado Caducifolio,Exótico,14-017,CONSTITUCION,1,"Calvo, Carlos",1655,0
-58.3896652299,-34.620059966599996,Árbol,2435,3,2,0,28,Rosáceas,Prunus,Prunus cerasifera,Ciruelo de jardín,Árbol Latifoliado Caducifolio,Exótico,14-017,CONSTITUCION,1,"Calvo, Carlos",1661,0
-58.3897390443,-34.6200641577,Árbol,2436,17,43,10,1,Oleáceas,Fraxinus,Fraxinus pennsylvanica,Fresno americano,Árbol Latifoliado Caducifolio,Exótico,14-017,CONSTITUCION,1,"Calvo, Carlos",0,0
"""

myStream = io.StringIO(myText)
del myText

# Show myStream, but without Fresnos americanos

csvReader = csv.DictReader(myStream, delimiter=',')

for row in csvReader:
    if "Fresno americano" not in row["nombre_com"]:
        print(row["nombre_com"])

# Filter out myStream Fresnos americanos records
# and save others to myOtherStream

print("myStream.tell() = ", myStream.tell())
print("myStream.seek(0,0) = ", myStream.seek(0,0))
csvReader = csv.DictReader(myStream, delimiter=',')

myOtherStream = io.StringIO()
csvWriter = csv.DictWriter(myOtherStream, fieldnames = csvReader.fieldnames)
csvWriter.writeheader()
for row in csvReader:
    if "Fresno americano" not in row["nombre_com"]:
        csvWriter.writerow(row)

# Show myOtherStream

print("myOtherStream.tell() = ", myOtherStream.tell())
print("myOtherStream.seek(0,0) = ", myOtherStream.seek(0,0))
csvReader = csv.DictReader(myOtherStream, delimiter=',')
print("--- List filtered ---")

for row in csvReader:
    print(row["nombre_com"])

#print('Second line.', file=myStream)
#print(myStream.tell())


# Retrieve file contents -- this will be
# 'First line.\nSecond line.\n'
#contents = myStream.getvalue()
#print(contents)
# Close object and discard memory buffer --
# .getvalue() will now raise an exception.
"""
print(myStream.seek(0,0))
num_of_char = myStream.readline
myStream.write('\b\b\b\b\b\b\b\b\b\b\b\b')
contents = myStream.getvalue()
print(contents)
"""
myStream.close()
myOtherStream.close()
