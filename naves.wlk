class Nave {
  var velocidad
  var direccion
  var combustible
  //var estaTranquila


  method acelerar(cuanto) {
    velocidad = 10000.min(velocidad + cuanto)
  }

  method desacelerar(cuanto) {
    velocidad = 0.max(velocidad - cuanto)
  }

  method irHaciaElSol () {
    direccion = 10
  }
  method escaparDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0
  }

  method acercarseUnPocoAlSol() {
      direccion =  10.min(direccion + 1)
  }

  method alejarseUnPocoDelSol() {
      direccion =  -10.max(direccion - 1)
  }

  method prepararViaje() {
    combustible += 30000
    self.acelerar(5000)
  }

  method cargarCombustible(cantidad) {
    combustible += cantidad
  }

  method consumirCombustible(cantidad) {
    combustible-= cantidad
  }

  method condicionAdicional() 

  method estaTranquila() {
    return combustible >=4000  && velocidad <= 12000 && self.condicionAdicional()
  }

  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }

  method escapar() 
  method avisar() 

  method estaDeRelajo() {
    self.estaTranquila() && self.tienePocaActividad()
  }

  method tienePocaActividad() 

  

}

class NaveBaliza inherits Nave {
  var color = "Verde"
  var cantCambiosColor = 0

method cambiarColorDeBaliza(colorNuevo) {
  color = colorNuevo
  cantCambiosColor +=1
}

override method prepararViaje() {
  super()  
  self.cambiarColorDeBaliza("Verde")
  self.ponerseParaleloAlSol()
// self.cargarCombustible(30000)
 // self.acelerar(5000)
}
 override method condicionAdicional() {
   return color != "Rojo"
 }

 override method escapar() {
   self.irHaciaElSol()
 }

 override method avisar() {
   self.cambiarColorDeBaliza("Rojo")
 }

 override method tienePocaActividad() {
   return cantCambiosColor == 0
 }

}

class NavePasajeros inherits Nave {
  const cantPasajeros
  var racionesComida
  var racionesBebidas
  var racionesServidas = 0

  method cargarComida(unaCantidad) {
    racionesComida += unaCantidad
    racionesServidas += unaCantidad
  }

  method cargarBebida(unaCantidad) {
    racionesBebidas += unaCantidad
  }

  method descargarComida(unaCantidad) {
    racionesComida -= unaCantidad
  }

  method descargarBebida(unaCantidad) {
    racionesBebidas -= unaCantidad
  }

  override method prepararViaje() {
  super()
  self.cargarComida(4 * cantPasajeros)
  self.cargarBebida(6 * cantPasajeros)
  self.acercarseUnPocoAlSol()

 
  
 // self.cargarCombustible(30000)
  //self.acelerar(5000)
}
 override method condicionAdicional() {
    return true
  }

  override method escapar() {
   velocidad *=2
 }

 override method avisar() {
   self.descargarComida(cantPasajeros)
   self.descargarBebida(cantPasajeros)
 }
 
 override method tienePocaActividad() {
   return racionesServidas < 50
 }

}

class NaveCombate inherits Nave{

  var visible = true

  var misilesDesplegados = true

  const listaMensajes = []

  method ponerseVisible() {
     visible = true
  }

  method ponerseInvisible() {
    visible = false
  }

  method estaInvisible() {
    return !visible
  }
  method desplegarMisiles() {
    if(!misilesDesplegados)
      misilesDesplegados = true
  }  

  method replegarMisiles() {
     if(misilesDesplegados)
        misilesDesplegados = false
  }
  method misilesDesplegados() {
    return misilesDesplegados
  }
   
   method emitirMensaje(unMensaje) {
     listaMensajes.add(unMensaje)
   }
   method mensajesEmitidos() {
     return listaMensajes
   }
   method primerMensajeEmitido() {
     return listaMensajes.first()
   }
   method ultimoMensajeEmitido() {
     return listaMensajes.last()
   }
   
   method esEscueta() {
     return listaMensajes.all({mensaje => mensaje.length() <= 30})
   }

   method emitioMensaje(mensaje) {
     return listaMensajes.contains(mensaje)
   }

   override method prepararViaje() {
        super()
        self.ponerseVisible()
        self.replegarMisiles()
        self.acelerar(15000)
        self.emitirMensaje("Saliendo en Misión")
        //self.acelerar(15000)
}

  override method condicionAdicional() {
   return !misilesDesplegados
 }

 override method escapar() {
   self.acercarseUnPocoAlSol()
   self.acercarseUnPocoAlSol()
 }

 override method avisar() {
   
   self.emitirMensaje("Amenaza recibida")
 }

 override method tienePocaActividad() {
   return true
 }

}

class NaveHospital inherits NavePasajeros {
  var quirofanosPreparados = false

  method prepararQuirofano() {
    quirofanosPreparados = true
  }
 
  method deshabilitarQuirofano() {
    quirofanosPreparados = false
  }

  override method condicionAdicional() {
    return !quirofanosPreparados
  }

  override  method recibirAmenaza() {
    super()
    self.prepararQuirofano()
  }

  override method tienePocaActividad() {
   return true
 }

}

class NaveSigilosa inherits NaveCombate {
  override method condicionAdicional() {
    return super() && !self.estaInvisible()
  }

  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerseVisible()
  }
}