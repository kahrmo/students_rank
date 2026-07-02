import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../domain/entities/student.dart';
import '../../domain/entities/popularity_ratings.dart';
import '../../../../core/result/result.dart';
import '../viewmodels/students_viewmodel.dart';

class StudentDetailsScreen extends StatelessWidget {
  final StudentsViewModel viewModel;
  final String id;

  const StudentDetailsScreen({super.key, required this.viewModel, required this.id});

  @override
  Widget build(BuildContext context) {
    final students = viewModel.students.watch(context);
    
    Student? student;
    try {
      student = students.firstWhere((element) => element.id == id);
    } catch (_) {
      // Student not found
    }

    if (student == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes')),
        body: const Center(child: Text('Aluno não encontrado.')),
      );
    }

    final ratings = student.ratings;

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () => context.push('/students/$id/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            color: Colors.redAccent,
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Text(
                        student.name.isNotEmpty ? student.name[0].toUpperCase() : '?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      student.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    if (student.nickname.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        '"${student.nickname}"',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildHeaderInfo(context, 'Curso', student.course.displayName),
                        _buildHeaderInfo(context, 'Turma/Ano', student.classYear.toString()),
                        _buildHeaderInfo(
                          context,
                          'Nascimento',
                          '${student.birthDate.day.toString().padLeft(2, '0')}/${student.birthDate.month.toString().padLeft(2, '0')}/${student.birthDate.year}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pontuação Geral',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Nível Lenda',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.bolt_rounded, color: Colors.amber, size: 40),
                        Text(
                          '${student.legendLevel}',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          '/75',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 12),
              child: Text(
                'Pontuação Detalhada',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...PopularityRatings.criteriaLabels.entries.map((entry) {
              final key = entry.key;
              final label = entry.value;
              final val = _getRatingValue(ratings, key);

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          final isFilled = (index + 1) <= val;
                          return Icon(
                            isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                            color: isFilled ? Colors.amber : Theme.of(context).disabledColor,
                            size: 20,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  int _getRatingValue(PopularityRatings r, String key) {
    switch (key) {
      case 'resenha': return r.resenha;
      case 'presencaVip': return r.presencaVip;
      case 'aura': return r.aura;
      case 'modoParceiro': return r.modoParceiro;
      case 'carismaNatural': return r.carismaNatural;
      case 'humorDeMilhoes': return r.humorDeMilhoes;
      case 'energiaDeGrupo': return r.energiaDeGrupo;
      case 'criatividadeCaotica': return r.criatividadeCaotica;
      case 'modoAtleta': return r.modoAtleta;
      case 'talentoDePalco': return r.talentoDePalco;
      case 'dripEscolar': return r.dripEscolar;
      case 'coracaoDeDorama': return r.coracaoDeDorama;
      case 'queridinhoDosProfessores': return r.queridinhoDosProfessores;
      case 'cerebroTurbo': return r.cerebroTurbo;
      case 'caosControlado': return r.caosControlado;
      default: return 1;
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir Aluno'),
          content: const Text('Tem certeza de que deseja remover este aluno? Esta ação não pode ser desfeita.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final res = await viewModel.deleteStudent(id);
                if (context.mounted) {
                  if (res is Success<void>) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Aluno excluído com sucesso!')),
                    );
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao excluir aluno: ${(res as Failure).error.message}')),
                    );
                  }
                }
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
