set /p newname=Enter new computer name: 
wmic computersystem where name=%computername% call rename name=%newname%
echo "computer will restart in 10 seconds""
shutdown -r -t 10
