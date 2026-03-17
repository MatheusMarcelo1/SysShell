

@echo off

rem Cria a pasta "prints" na área de trabalho, se ela não existir
if not exist "C:\Users\User\Desktop\prints\" (
  mkdir "C:\Users\User\Desktop\prints"
)

rem Captura a tela usando o snippingtool
start /wait snippingtool /clip

rem Define o nome do arquivo com a data e hora atual
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
  set day=%%a
  set month=%%b
  set year=%%c
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
  set hour=%%a
  set minute=%%b
)
set filename=C:\Users\User\Desktop\prints\screenshot_%year%%month%%day%_%hour%%minute%.png

rem Move o arquivo para a pasta "prints"
move /y "%USERPROFILE%\Pictures\SnippingTool\*.png" %filename%

echo Printscreen salvo como %filename%
pause
