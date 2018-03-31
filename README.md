Mute-spotify
==============

Script .AHK para silenciar instantaneamente el volumen en spotify en windows según qe tema (o publicidad) este sonando en ese momento
(usado mas que nada para silenciar la publicidad en spotify)

Notas:
- El control de volumen lo hace a travez del control de volumen de windows (silencia solo el canal de Spotify)
- El proceso se ejecuta cada vez que hay un cambio de cancion, luego espera hasta que haya un cambio de titulo para volver a verificar el nuevo tema



basado en el codigo de [kristoffer-tvera/mute-current-application](https://github.com/kristoffer-tvera/mute-current-application)

Ejecutar:
--------

Autohotkey.exe muteSpotify.ahk

Configuracion:
--------------

dentro del archivo muteSpotify.ahk se pueden configurar dos modos de uso
method:=1 ; filtrará cuando el titulo del tema coincide con alguno de los titulos almacenados en el archivo block.lst
method:=2 ; filtrará cuando el titulo no contenga el caracter "-" (significa que no es un tema con el formato %artist% - %title% )

Teclas rapidas:
---------------

+F1: agrega el titulo actual al archivo block.lst
+F2: vuelve a comprobar las reglas para el tema actual (debug)
