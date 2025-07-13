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
