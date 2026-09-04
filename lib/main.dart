import 'package:flutter/material.dart';

void main() {
  runApp(const MiAppCumpleanos());
}

class MiAppCumpleanos extends StatelessWidget {
  const MiAppCumpleanos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Cumpleaños',
      // Tema de colores de la app (Rosa/Morado)
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const PantallaCumpleanos(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PantallaCumpleanos extends StatefulWidget {
  const PantallaCumpleanos({super.key});

  @override
  State<PantallaCumpleanos> createState() => _PantallaCumpleanosState();
}

class _PantallaCumpleanosState extends State<PantallaCumpleanos> {
  // Controladores para guardar lo que escribe el usuario
  final TextEditingController _controladorNombre = TextEditingController();

  // Variables para guardar la fecha y el mensaje final
  DateTime? _fechaCumple;
  String _mensajeResultado = "¡Configura tu cumpleaños para empezar!";

  // Función para abrir el calendario y elegir la fecha
  Future<void> _elegirFecha() async {
    final DateTime? fechaElegida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (fechaElegida != null) {
      setState(() {
        _fechaCumple = fechaElegida;
      });
    }
  }

  // Función para calcular los días faltantes
  void _calcularDias() {
    String nombre = _controladorNombre.text;

    if (nombre.isEmpty || _fechaCumple == null) {
      setState(() {
        _mensajeResultado = "Por favor, escribe tu nombre y elige tu fecha.";
      });
      return;
    }

    // Lógica de fechas
    DateTime hoy = DateTime.now();
    DateTime proximoCumple = DateTime(
      hoy.year,
      _fechaCumple!.month,
      _fechaCumple!.day,
    );

    // Si tu cumpleaños de este año ya pasó, lo calculamos para el año que viene
    if (proximoCumple.isBefore(hoy)) {
      proximoCumple = DateTime(
        hoy.year + 1,
        _fechaCumple!.month,
        _fechaCumple!.day,
      );
    }

    // Calculamos la diferencia en días
    int diasFaltantes = proximoCumple.difference(hoy).inDays;

    setState(() {
      if (diasFaltantes == 0) {
        _mensajeResultado =
            "🎉 ¡¡FELIZ CUMPLEAÑOS $nombre!! 🎂 ¡Hoy es tu día!";
      } else {
        _mensajeResultado =
            "¡Hola $nombre! Faltan exactamente\n$diasFaltantes días \npara tu cumpleaños.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuenta Regresiva'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono grande de pastel
            const Icon(Icons.cake, size: 80, color: Colors.purple),
            const SizedBox(height: 20),

            // Campo para escribir el nombre
            TextField(
              controller: _controladorNombre,
              decoration: const InputDecoration(
                labelText: '¿Cómo te llamas?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),

            // Botón para elegir la fecha
            OutlinedButton.icon(
              onPressed: _elegirFecha,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _fechaCumple == null
                    ? 'Elige tu cumpleaños'
                    : '${_fechaCumple!.day} / ${_fechaCumple!.month} / ${_fechaCumple!.year}',
              ),
            ),
            const SizedBox(height: 30),

            // Botón para calcular
            ElevatedButton(
              onPressed: _calcularDias,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Calcular días',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),

            // Texto donde aparece el resultado
            Text(
              _mensajeResultado,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
