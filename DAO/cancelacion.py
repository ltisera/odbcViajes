class Cancelacion():
    def __init__(self, codigo=0, fecha="", montoReintegro=0, registro = None):
        if(not(registro is None)):
            self._codigo = registro[0]
            self._fecha = registro[1]
            self._montoReintegro = registro[2]

        else:
            self._codigo = codigo
            self._fecha = fecha
            self._montoReintegro = montoReintegro

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
    def montoReintegro(self):
        return self._montoReintegro

    @montoReintegro.setter
    def montoReintegro(self, montoReintegro):
        self._montoReintegro = montoReintegro

    def datos(self):
        return (self._codigo,
                self._fecha,
                self._montoReintegro,)

    def __str__(self):
        return str(self.__dict__)


if __name__ == '__main__':
    pass
