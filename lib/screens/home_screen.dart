import 'package:flutter/material.dart';
import '../models/frase.dart';
import '../data/frases_db.dart';
import 'formulario_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Frase> _frases = [];

  @override
  void initState() {
    super.initState();
    _cargarFrases();
  }

  Future<void> _cargarFrases() async {
    final frases = await FrasesDb.instancia.obtenerTodas();
    setState(() {
      _frases = frases;
    });
  }

  void _eliminarFrase(int id) async {
    await FrasesDb.instancia.eliminar(id);
    _cargarFrases(); // Recargamos la lista después de eliminar
  }

  // Navegar al formulario y recargar si se guardó algo
  void _navegarAFormulario([Frase? frase]) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioScreen(frase: frase),
      ),
    );

    // Si el resultado es true, significa que se guardó o actualizó una frase
    if (resultado == true) {
      _cargarFrases();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Frases'),
      ),
      body: _frases.isEmpty
          ? const Center(child: Text('No hay frases guardadas.'))
          : ListView.builder(
              itemCount: _frases.length,
              itemBuilder: (context, index) {
                final frase = _frases[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      frase.frase,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(frase.autor ?? 'Anónimo'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarFrase(frase.id!),
                    ),
                    onTap: () => _navegarAFormulario(frase), // Editar
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navegarAFormulario(), // Crear nueva
        child: const Icon(Icons.add),
      ),
    );
  }
}