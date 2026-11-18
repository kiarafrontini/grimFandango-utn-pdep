object departamentoDeLaMuerte{
    const agentesDeViaje = []

    method mejorAgente() = agentesDeViaje.max({agente => agente.paqVendidos()})

    method diaDeLosMuertos(){
        self.mejorAgente().reducirDeuda(50)

        self.pagaronDeuda().forEach({ag => self.liberarAgente(ag)})
        
        self.noPagaronDeuda().forEach({ag => ag.subirDeuda(100)})
    }

    method pagaronDeuda() = agentesDeViaje.filter({agente => agente.deudaActual()==0})

    method noPagaronDeuda() = agentesDeViaje.filter({agente => agente.deudaActual()!= 0})


    method liberarAgente(agente){
        agentesDeViaje.remove(agente)
    }
}

class Agente{
    var paqVendidos = 0
    var dineroGanado
    var deudaActual

    method paqVendidos() = paqVendidos

    method venderPaquete(paquete, alma){
        if (paquete.costo() > alma.capital()) { 
            throw new DomainException (message = "No tiene suficiente capital")
        } else {
            paqVendidos += 1
            dineroGanado += paquete.costo()
        }
    }

    method deudaActual()= deudaActual

    method reducirDeuda(valor){
        deudaActual -= valor
    }

    method subirDeuda(valor){
        deudaActual += valor
    }
}


class Alma{
    var capital
    var dinero
    var accionesBuenas=[]

    method capital() = dinero + self.cantidadAccionesBuenas()

    method accionesBuenas()= accionesBuenas

    method cantidadAccionesBuenas() = accionesBuenas.size()
}

class Paquete{
    const valorBasico

    method costo(){
        (valorBasico * Paquete.reduccionViaje(Alma)).min(350)
    }

    method reduccionViaje(alma)

}

class Tren inherits Paquete{
    override method reduccionViaje(alma)= 4
}

class Bote inherits Paquete{
    override method reduccionViaje(alma){
        2.min((alma.cantidadAccionesBuenas()).div(50))
    }
}

class Crucero inherits Bote{
    override method reduccionViaje(alma) {
        super(alma) *2
    }
}

class PaloBurbuja inherits Paquete{
    override method reduccionViaje(alma) = 0.05

    override method costo() = valorBasico
}
