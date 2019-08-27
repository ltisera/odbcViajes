class Ciudad():
    
    def __init__(self, idDestinos=0, nombre="", coordenada=0 ,  baja="", registro = None):
        if(not(registro is None)):
            self._idDestinos = registro[0]
            self._nombre = registro[1]
            self._coordenada = registro[2]
            self._baja = registro[3]
            
        else:
            self._idDestinos = idDestinos
            self._nombre = nombre 
            self._coordenada = coordenada 
            self._baja = baja 
            
    @property
    def idDestinos(self):
    	return self._idDestinos
    
    @idDestinos.setter
    def idDestinos(self, idDestinos):
    	self._idDestinos = idDestinos


    @property
    def nombre(self):
    	return self._nombre
    
    @nombre.setter
    def nombre(self, nombre):
    	self._nombre = nombre


    @property
    def coordenada(self):
    	return self._coordenada
    
    @coordenada.setter
    def coordenada(self, coordenada):
    	self._coordenada = coordenada

    @property
    def baja(self):
    	return self._baja
    
    @baja.setter
    def baja(self, baja):
    	self._baja = baja

    def datos(self):
        return (self._idDestinos,
            self._nombre,
            self._coordenada,
            self._baja,)
    def __str__(self):
        
        return str(self.__dict__)

if __name__ == '__main__':
    print("Estoy en el main de ciudad")
    print("Armando ciudad")
    pasTST = Ciudad()
    print(pasTST)
