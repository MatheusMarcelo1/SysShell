::Sincronizar a data e hora do pc

net start w32time
w32tm /resync /force
net stop w32time
