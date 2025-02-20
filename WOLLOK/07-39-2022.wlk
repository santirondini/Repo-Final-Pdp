
// Acordarnos que los roles pueden ser clases

class Personaje {
  var rol
  const enemigos = #{}
  method recibirDaño(cantidad){}
  method agregarEnemigo(personaje){
    enemigos.add(personaje)
  }
  method realizar_ataque(personaje){
    rol.verificar_ataque(personaje)
    self.atacar(personaje)
  }
  method atacar(personaje){
    personaje.recibirDaño(rol.daño())
    personaje.agregarEnemigo(personaje)
  }
}

class Heroe {
  const habilidades = #{}
  const aliados = #{}
  method verificar_ataque(personaje){
    if (aliados.contains(personaje)){
      throw new Exception (message = "No puedes atacar a tus aliados")
    }
  }
  method poder() = aliados.size() * habilidades.sum{ h => h.poder() }
}

class Habilidad {
  var property poder
}

class Villano {
  var property arma
  method daño(){
    return arma.daño()
  }
  method verificar_ataque() = true 
}

class Arma {
  var property dañoBase
  var property areaDeEfecto
  method daño() = dañoBase * areaDeEfecto
}