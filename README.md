# Copia de Seguridad de la Configuración de la Terminal de Windows

Esta guía te muestra cómo crear una función en PowerShell para hacer una copia de seguridad automática de la configuración de la Terminal de Windows, evitando así perder tus preferencias personalizadas.

![Captura de pantalla](https://github.com/user-attachments/assets/7baa9452-dd52-4cab-850c-66565103fe49)

## Pasos para agregar esta función

### 1. Instalar PowerShell

Asegúrate de tener instalada la versión más reciente de [PowerShell](https://learn.microsoft.com/es-es/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5).

### 2. Abrir la configuración de tu perfil de PowerShell

Ejecuta el siguiente comando para abrir tu archivo de perfil en el Bloc de notas:

```powershell
notepad $PROFILE
````

> ⚠️ **Nota:**
> Si recibes un error indicando que el archivo no existe, créalo con este comando:

```powershell
New-Item -Path $PROFILE -Type File -Force
```

### 3. Agregar la función de copia de seguridad

Copia y pega la siguiente función en tu archivo de perfil abierto. **No olvides modificar la variable `$destination` para definir la ruta donde quieres guardar las copias de seguridad.**

```powershell
function terminal-backup {
  # config file
  $file = "settings"
  $ext = ".json"
  
  # date
  $date = Get-Date -Format "dd-MM-yyyy"
  $h = Get-Date -Format "HH"
  $m = Get-Date -Format "mm"
  $s = Get-Date -Format "ss"

  # origin config path
  $origin = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\$file$ext"

  # destination path
  $destination = "insert your path for save backup || insertar la ruta donde guardar la copia de seguridad"

  # check file time exist 
  if (-Not (Test-Path "$destination\$date")) {
    mkdir "$destination\$date"
  } 

  # final destination
  $destination_for_save_backup = "$destination\$date\${h}hr-${m}min-${s}sec$ext"

  # copy file
  Copy-Item $origin $destination_for_save_backup -Force
}
```

### 4. Guardar y recargar el perfil

Después de guardar los cambios en el archivo `$PROFILE`, recarga tu perfil para que la función quede disponible sin necesidad de reiniciar la terminal:

```powershell
. $PROFILE
```

### 5. Usar la función

Ahora, cada vez que quieras hacer una copia de seguridad de tu configuración, solo ejecuta:

```powershell
terminal-backup
```

Esto creará una carpeta con la fecha actual y guardará una copia del archivo `settings.json` con la hora exacta.

## Resumen

Con esta función podrás mantener múltiples copias de seguridad ordenadas por fecha y hora para restaurar tu configuración de Terminal de Windows cuando lo necesites.
