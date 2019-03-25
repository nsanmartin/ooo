enum class TipoPiso { Piedra, Polvo };
enum class Porosidad {Poroso, Compacto};
enum class Dureza {Duro, Blando};


class Brazo {
public:
  using Rpm = unsigned;
  using Minutos = unsigned;
  enum class Rotacion { Horaria, Antihoraria };
  void Girar(Rotacion, Rpm, Minutos) const;
};

class Sensor {
public:
  Porosidad porosidadSueloActual() const;
  Dureza durezaSueloActual() const;
};

class DetectorDePiso {
public:
  TipoPiso detectarTipoPiso(Sensor sensor) {
    Porosidad porosidad = sensor.porosidadSueloActual();
    Dureza dureza = sensor.durezaSueloActual();
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
    TipoPiso tipoPiso = detectorDePiso.detectarTipoPiso(sensor);
    if (tipoPiso == TipoPiso::Piedra) {

      brazo.Girar(Brazo::Rotacion::Horaria, 150, 10);

    } else if (tipoPiso == TipoPiso::Polvo) {

      brazo.Girar(Brazo::Rotacion::Antihoraria, 100, 5);

    }
  }

};

