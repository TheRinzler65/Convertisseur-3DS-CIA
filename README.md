# Convertisseur-3DS-CIA
Juste un autre convertisseur 3DS en CIA pour Linux et Windows.

## Utilisation
### Facile (version précompilée)
Décompressez simplement la version publiée, placez vos ROM dans le répertoire `roms`, placez les xorpads dans le répertoire `xorpads` et lancez 3ds-to-cia.
Le script vous dira ce que vous devez faire.
Les CIA résultantes seront trouvées dans le répertoire `cia`.

### Pro (à partir des sources)
Installez `python2` avec `colorama`, compilez [make_cia](https://github.com/ihaveamac/ctr_toolkit) et placez-le dans votre PATH, puis lancez simplement `./3ds-to-cia.py`

### Construction de la version publiée
Vous devez installer python2 avec pyinstaller et colorama, puis :
```
pyinstaller 3ds-to-cia.spec
```

dans le répertoire `distro`, vous trouverez le binaire résultant.

Placez le binaire dans un dossier avec `cia`, `roms` et `xorpads` des répertoires vides, compressez-le et redistribuez-le.

## Bugs Connus
Les ROMs volumineuses (2 Go ou plus) ne peuvent pas être converties (encore) sur des systèmes d'exploitation 32 bits ou si vous utilisez un make_cia 32 bits.

## Crédits
`mid-kid` pour les informations sur la procédure
`3DSGuy` pour make_cia
Génération de `ncchinfo.bin` basée sur `ArchShift` et `d0k3` [Decrypt9WIP's ncchinfo_gen_exh.py](https://github.com/d0k3/Decrypt9WIP/blob/master/scripts/ncchinfo_gen_exh.py)
