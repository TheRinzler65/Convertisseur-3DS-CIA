# Convertisseur .3ds à .cia
Un convertisseur de 3DS en CIA pour Windows (Linux pas sûr à 100%).

## Utilisation
### Facile (version précompilée)
Décompressez simplement la version publiée, placez vos ROMs dans le répertoire `roms`, vos xorpads dans le répertoire `xorpads`, puis lancez `Convertisseur .3ds à .cia`.
Le script vous guidera à travers les étapes nécessaires.
Les fichiers CIA résultants seront situés dans le répertoire `cia`.

### Pro (à partir des sources)
- Installez une version 3.x.x de python

- Le programme `make_cia` est déjà dans le code source où alors installez le et mettez le dans votre `PATH` (Les deux marchent)

## Compilation de la version
### Sur Windows:

Vous devez installer python 3.x.x avec pyinstaller et colorama (normalement par défaut), puis faites dans un Terminal :
```
pyinstaller 3ds-to-cia.spec
```

Dans le répertoire `dist` vous trouverez le fichier binaire généré.

Placez le fichier binaire dans un dossier avec les répertoires vides  `cia`, `roms` et `xorpads` compressez-le et redistribuez-le.


### Sur Linux : (prochainement)

## Bugs Connus
Les ROMs volumineuses (2 Go et plus) ne peuvent pas être converties (pour le moment) sur des systèmes d'exploitation 32 bits ou si vous utilisez make_cia en 32 bits.

## Crédits
* `mid-kid` pour les informations sur la procédure
* `3DSGuy` pour make_cia
* Génération de `ncchinfo.bin` basée sur `ArchShift` et `d0k3` [Decrypt9WIP's ncchinfo_gen_exh.py](https://github.com/d0k3/Decrypt9WIP/blob/master/scripts/ncchinfo_gen_exh.py)
* `drizzt` Créateur original du programme que je remercie

Si vous avez besoin de renseignement allez sur mon [Discord](https://discord.gg/heUzNmpXgM)