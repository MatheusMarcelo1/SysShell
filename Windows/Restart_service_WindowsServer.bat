@Echo Off
Set ServiceName=MySQL57
SC queryex "%ServiceName%"|Find "STATE"|Find /v "RUNNING">Nul&&(
    echo %ServiceName% Fora do AR
    echo Start %ServiceName%

    Net start "%ServiceName%">nul||(
        Echo "%ServiceName%" não pode ser iniciado
        exit /b 1
    )
    echo  %date%-%time% - "%ServiceName%" iniciado com sucesso >> "verifica_servico_%ServiceName%.log"
    blat -to "emailA@teste.com, emailB@teste.com" -server stmp.x.com -f sender@teste.com -subject "Tarefa executada no servidor" -body "%ServiceName% iniciado"
    exit /b 0
)||(
    echo "%ServiceName%" no ar
    exit /b 0
)
