@for /f "tokens=*" %%i in ('docker-machine env --shell cmd default') do @%%i
