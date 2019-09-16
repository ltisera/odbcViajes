class Ciudad():
    def __init__(self, idCiudad=0, nombre="", latitud=0, longitud=0, baja=False, registro=None):
        if(not(registro is None)):
            self._idCiudad = registro[0]
            self._nombre = registro[1]
            self._latitud = registro[2]
            self._longitud = registro[3]
            self._baja = registro[4]

        else:
            self._idCiudad = idCiudad
            self._nombre = nombre
            self._latitud = latitud
            self._longitud = longitud
            self._baja = baja

    @property
    def idCiudad(self):
        return self._idCiudad

    @idCiudad.setter
    def idCiudad(self, idCiudad):
        self._idCiudad = idCiudad

    @property
    def nombre(self):
        return self._nombre

    @nombre.setter
    def nombre(self, nombre):
        self._nombre = nombre

    @property
    def latitud(self):
        return self._latitud

    @latitud.setter
    def latitud(self, latitud):
        self._latitud = latitud

    @property
    def longitud(self):
        return self._longitud

    @longitud.setter
    def longitud(self, longitud):
        self._longitud = longitud

    @property
    def baja(self):
        return self._baja

    @baja.setter
    def baja(self, baja):
        self._baja = baja

    def datos(self):
        return (self._nombre,
                self._latitud,
                self._longitud,)

    def __str__(self):
        return str(self.__dict__)


if __name__ == '__main__':
    print("Estoy en el main de ciudad")
    print("Armando ciudad")
    pasTST = Ciudad()
    print(pasTST)
