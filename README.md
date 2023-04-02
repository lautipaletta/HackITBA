# HackITBA

Repositorio del equipo "Los egrep" para la hackaton "HackITBA"

## El Proyecto: CollectApp

CollectApp es una plataforma que cambia el paradigma de las campañas de donación. Permite, mediante el uso de Smart Contracts ejecutados en
el Blockchain de Ethereum, la creación de colectas. El uso de estos contratos permite que dichas campañas sean completamente
transparentes y decentralizadas.

Cualquier entidad puede generar una campaña. Las donaciones están aseguradas, pues son retenidas por el contrato hasta que el objetivo de la 
campaña sea logrado. De esta manera las donaciones están protegidas de principio a fin. Esto es un proceso completamente transparente, tanto
los contratos, como las transacciones ejecutadas son información pública.

En caso de que el objetivo de la campaña no se cumpla a tiempo, el contrato efectua un reembolso automático.

## Stack técnico

### Frontend

Flutter

### Backend

nodeJS, mongodb, web3js

### Smart contracts

solidity, truffle

## Instrucciones de instalación

Prerequisitos:

* Docker
* Flutter

1) Clonar la repo.
2) Ejecutar

Ejecutar desde el directorio principal.
```
docker-compose up
```

Ejecutar desde el directorio app.
```
flutter run
```

Por defecto el servidor web se hostea en el puerto 3000, la base de datos en el puerto 27017 y la test net en el puerto 8545.

(Ejecutamos por serparado flutter por mas que hicimos el build porque no funciona el build por algun motivo).

### Pasos para usar la app

Cuando se ejecuta el `docker-compose` se imprime direcciones publicas de Ethereum en la test net. Las mismas deben ser usadas para probar
la aplicación.

Ir al puerto creado por flutter e utilizar la web app. 
