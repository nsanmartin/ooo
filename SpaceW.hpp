enum class TipoPiso { Piedra, Polvo };

class Brazo {
public:
  using Rpm = unsigned;
  using Minutos = unsigned;
  enum class Rotacion { Horaria, Antihoraria };
  void Girar(Rotacion, Rpm, Minutos) const;
};

class Sensor {
public:
  TipoPiso tipoPisoActual() const;
};


class LunarRover {
private:
  Brazo brazo;
  Sensor sensor;
public:

  void Excavar() const {
    TipoPiso tipoPiso = sensor.tipoPisoActual();
    if (tipoPiso == TipoPiso::Piedra) {

      brazo.Girar(Brazo::Rotacion::Horaria, 150, 10);

    } else if (tipoPiso == TipoPiso::Polvo) {

      brazo.Girar(Brazo::Rotacion::Antihoraria, 100, 5);

    }
  }

};

