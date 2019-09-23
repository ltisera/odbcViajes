class Pasaje():
    def __init__(self, codigo=0, fecha="", valor=0, pasajero="", origen="", destino=0, formaPago="", cancelacion="", registro=None):
        if(not(registro is None)):
            self._codigo = registro[0]
            self._fecha = registro[1]
            self._valor = registro[2]
            self._pasajero = registro[3]
            self._origen = registro[4]
            self._destino = registro[5]
            self._formaPago = registro[6]
            self._cancelacion = registro[7]

        else:
            self._codigo = codigo
            self._fecha = fecha
            self._valor = valor
            self._pasajero = pasajero
            self._origen = origen
            self._destino = destino
            self._formaPago = formaPago
            self._cancelacion = cancelacion

    @property
    def codigo(self):
        return self._codigo

    @codigo.setter
    def codigo(self, codigo):
        self._codigo = codigo

    @property
    def fecha(self):
        return self._fecha

    @fecha.setter
    def fecha(self, fecha):
        self._fecha = fecha

    @property
    def valor(self):
        return self._valor

    @valor.setter
    def valor(self, valor):
        self._valor = valor

    @property
    def pasajero(self):
        return self._pasajero

    @pasajero.setter
    def pasajero(self, pasajero):
        self._pasajero = pasajero

    @property
    def origen(self):
        return self._origen

    @origen.setter
    def origen(self, origen):
        self._origen = origen

    @property
    def destino(self):
        return self._destino

    @destino.setter
    def destino(self, destino):
        self._destino = destino

    @property
    def formaPago(self):
        return self._formaPago

    @formaPago.setter
    def formaPago(self, formaPago):
        self._formaPago = formaPago

    @property
    def cancelacion(self):
        return self._cancelacion

    @cancelacion.setter
    def cancelacion(self, cancelacion):
        self._cancelacion = cancelacion

    def datos(self):
        return (self._codigo,
                self._fecha,
                self._valor,
                self._pasajero,
                self._origen,
                self._destino,
                self._formaPago)

    def __str__(self):
        return str(self.__dict__)


if __name__ == '__main__':
    print("Estoy en el main de pasaje")
    print("Armando pasaje")
    pasTST = Pasaje()
    print(pasTST)
