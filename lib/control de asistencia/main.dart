import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Asistencia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aplicación de prueba funcionando'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int presentes = 0;
  final int totalEstudiantes = 25;

  String obtenerEstadoAsistencia() {
    int ausentes = totalEstudiantes - presentes;

    if (presentes == 0) {
      return 'Todos ausentes';
    } else if (presentes == totalEstudiantes) {
      return '¡Todos presentes!';
    } else if (presentes >= (totalEstudiantes * 0.75)) {
      return 'Casi todos presentes';
    } else if (ausentes >= (totalEstudiantes * 0.75)) {
      return 'Casi todos ausentes';
    } else {
      return 'Asistencia media';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 490,
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.groups, size: 90),
              const SizedBox(height: 15),
              const Text(
                'Desarrollo de aplicaciones móviles',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              const Text(
                'Estudiantes presentes',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                '$presentes',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                'de $totalEstudiantes estudiantes',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                'Ausentes: ${totalEstudiantes - presentes} (${obtenerEstadoAsistencia()})',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (presentes > 0) {
                        setState(() {
                          presentes--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove_circle, size: 45),
                  ),
                  const SizedBox(width: 35),
                  IconButton(
                    onPressed: () {
                      if (presentes < totalEstudiantes) {
                        setState(() {
                          presentes++;
                        });
                      }
                    },
                    icon: const Icon(Icons.add_circle, size: 45),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
