/*
Cosas a mejorar:
  - Agregar comentarios pertinentes.
  - Fijarse que los Rpm y los Minutos sean positivos.
  - Hacer interfaces en vez de hacer que cada clase dependa de las
    implementaciones, y pasar las implementaciones como parámetros de
    constructores
  - Separar en archivos.
*/

enum class TipoPiso { Piedra, Polvo };
enum class Porosidad {Poroso, Compacto};
enum class Dureza {Duro, Blando};
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
    }
  }

};

