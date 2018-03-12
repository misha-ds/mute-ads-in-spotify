Mute-spotify
==============

Script para silenciar el volumen en spotify para windows según que cosa suene en ese momento
(usado mas que nada para silenciar la publicidad en spotify)
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

F1: agrega el titulo actual al archivo block.lst
F2: vuelve a comprobar las reglas para el tema actual (debug)
