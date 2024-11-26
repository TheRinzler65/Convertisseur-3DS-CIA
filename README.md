# Multitool 3DS
Un ensemble d'outils destiné pour la Nintendo 3DS (en cours de création ne pas toucher !!!)

## Utilisation

#### Sur Windows :

Vous devez lancer le fichier `multitool_3ds.bat` et vous verrez une page s'afficher avec différent point sur le menu : 

- 1. Convertisseur .3ds / .cia : ça permet de convertir les rom decrypter et certaines rom encrypter (grâce aux xorpads (fichier signature)) .3ds en .cia, lorsque c'est terminer, vous le retrouverez dans le dossier `cia`.

- 2. Convertisseur .cia / .3ds : ça permet de convertir les roms decrypter .cia en rom decrypter .3ds, il faut mettre la rom à la racine du dossier (au même endroit que `multitool_3ds.bat`), lorsque c'est terminer, vous le retrouverez dans le dossier `3ds`.

- 3. Rejoindre notre Serveur Discord : Si jamais vous avez des problèmes par rapport au convertisseur ou un problème après conversion du fichier, veuillez faire un post sur notre serveur discord on vous répondra le plus vite possible.

- 4. 


### Sur Linux : (prochainement)

## Bugs Connus
Les ROMs volumineuses (2 Go et plus) ne peuvent pas être converties (pour le moment) sur des systèmes d'exploitation 32 bits ou si vous utilisez make_cia en 32 bits.

## Crédits
* `mid-kid` pour les informations sur la procédure
* `3DSGuy` pour make_cia
* Génération de `ncchinfo.bin` basée sur `ArchShift` et `d0k3` [Decrypt9WIP's ncchinfo_gen_exh.py](https://github.com/d0k3/Decrypt9WIP/blob/master/scripts/ncchinfo_gen_exh.py)
* `drizzt` Créateur original du programme que je remercie

Si vous avez besoin de renseignement allez sur mon [Discord](https://discord.gg/heUzNmpXgM)