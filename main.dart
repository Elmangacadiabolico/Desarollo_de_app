import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Propinas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),s
      home: const MyHomePage(title: 'Calculadora de Propinas'),
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
  final TextEditingController totalController = TextEditingController();
  final TextEditingController propinaController = TextEditingController();
  final TextEditingController personasController = TextEditingController();

  double? totalConPropina;
  double? montoPorPersona;
  String? error;

  void calcularPropina() {
    final total = double.tryParse(totalController.text);
    final propina = double.tryParse(propinaController.text);
    final personas = int.tryParse(personasController.text);

    if (total == null || propina == null || personas == null || total <= 0 || propina < 0 || personas <= 0) {
      setState(() {
        error = 'Por favor ingresa valores numéricos válidos.';
        totalConPropina = null;
        montoPorPersona = null;
      });
      return;
    }

    final resultadoTotal = total + (total * propina / 100);
    final resultadoPersona = resultadoTotal / personas;

    setState(() {
      error = null;
      totalConPropina = resultadoTotal;
      montoPorPersona = resultadoPersona;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: totalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total de la cuenta',
              ),
            ),
            TextField(
              controller: propinaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Porcentaje de propina (ej: 10, 15, 20)',
              ),
            ),
            TextField(
              controller: personasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número de personas',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularPropina,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),
            if (totalConPropina != null && montoPorPersona != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total con propina: ${totalConPropina!.toStringAsFixed(2)} \$'),
                  Text('Cada persona paga: ${montoPorPersona!.toStringAsFixed(2)} \$'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
