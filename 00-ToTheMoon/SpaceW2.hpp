/*
Cosas a mejorar:
  - Agregar comentarios pertinentes.
  - Fijarse que los Rpm y los Minutos sean positivos.
  - Hacer interfaces en vez de hacer que cada clase dependa de las
    implementaciones, y pasar las implementaciones como parámetros de
    constructores
  - Separar en archivos.
*/

enum class TipoPiso {Piedra, Polvo, Intermedio};
enum class Porosidad {Poroso, Compacto, Intermedio};
enum class Dureza {Duro, Blando, Intermedio};
enum class Rotacion {Horaria, Antihoraria};

using Rpm = unsigned;
using Minutos = unsigned;

class ConversorDeRotacion {
public:
  Rotacion RotacionContraria(Rotacion rotacion) const {
    if (rotacion == Rotacion::Horaria) {
      return Rotacion::Antihoraria;
    } else {
      return Rotacion::Horaria;
    }
  }
};

class Mecha {
public:
  void Girar(Rotacion rotacion, Rpm vueltas_por_minuto, Minutos minutos) const;
};

class Pinzas {
public:
  void Cerrar() const;
  void Abrir() const;
};

class Brazo {
  Mecha mecha;
  Pinzas pinzas;
  ConversorDeRotacion conversorDeRotacion;
public:
  void Excavar(Rotacion rotacion, Rpm vueltas_por_minuto, Minutos minutos) const {
    mecha.Girar(rotacion, vueltas_por_minuto, minutos);
    pinzas.Cerrar();
    mecha.Girar(conversorDeRotacion.RotacionContraria(rotacion), vueltas_por_minuto, minutos);
    pinzas.Abrir();
  }

  void Excavar(Rotacion rotacion, Rpm vueltas_por_minuto, Minutos minutos,
    Rotacion rotacion2, Rpm vueltas_por_minuto2, Minutos minutos2) const {
    mecha.Girar(rotacion, vueltas_por_minuto, minutos);
    pinzas.Cerrar();
    mecha.Girar(rotacion2, vueltas_por_minuto2, minutos2);
    pinzas.Abrir();
  }
};

class Sensor {
public:
  Porosidad PorosidadSueloActual() const;
  Dureza DurezaSueloActual() const;
};

class DetectorDePiso {
public:
  TipoPiso DetectarTipoPiso(Sensor sensor) const {
    Porosidad porosidad = sensor.PorosidadSueloActual();
    Dureza dureza = sensor.DurezaSueloActual();
    if (porosidad == Porosidad::Poroso && dureza == Dureza::Blando) {
      return TipoPiso::Polvo;
    } else if (porosidad == Porosidad::Intermedio && dureza == Dureza::Intermedio){
      return TipoPiso::Intermedio;
    } else {
      return TipoPiso::Piedra;
    }
  }
};

class LunarRover {
private:
  Brazo brazo;
  Sensor sensor;
  DetectorDePiso detectorDePiso;
public:

  void Excavar() const {
    TipoPiso tipoPiso = detectorDePiso.DetectarTipoPiso(sensor);
    if (tipoPiso == TipoPiso::Piedra) {
      brazo.Excavar(Rotacion::Horaria, 150, 10);
    } else if (tipoPiso == TipoPiso::Polvo) {
      brazo.Excavar(Rotacion::Antihoraria, 100, 5);
    } else if (tipoPiso == TipoPiso::Intermedio) {
      brazo.Excavar(Rotacion::Horaria, 150, 5, Rotacion::Antihoraria, 100, 10);
    }
  }

};

