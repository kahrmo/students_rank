import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/student.dart';
import '../../domain/entities/popularity_ratings.dart';
import '../../../../core/result/result.dart';
import '../viewmodels/students_viewmodel.dart';
import '../widgets/custom_star_rating.dart';

class StudentFormScreen extends StatefulWidget {
  final StudentsViewModel viewModel;
  final String? id;

  const StudentFormScreen({super.key, required this.viewModel, this.id});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();

  Course _selectedCourse = Course.info;
  int _selectedYear = 2026;
  DateTime _selectedBirthDate = DateTime(2005, 1, 1);
  PopularityRatings _ratings = const PopularityRatings();

  final List<int> _years = List<int>.generate(29, (i) => 1998 + i); // 1998 to 2026

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      try {
        final s = widget.viewModel.students.value.firstWhere((element) => element.id == widget.id);
        _nameController.text = s.name;
        _nicknameController.text = s.nickname;
        _selectedCourse = s.course;
        _selectedYear = s.classYear;
        _selectedBirthDate = s.birthDate;
        _ratings = s.ratings;
      } catch (e) {
        // Student not found
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
      });
    }
  }

  int _getRatingValue(String key) {
    switch (key) {
      case 'resenha': return _ratings.resenha;
      case 'presencaVip': return _ratings.presencaVip;
      case 'aura': return _ratings.aura;
      case 'modoParceiro': return _ratings.modoParceiro;
      case 'carismaNatural': return _ratings.carismaNatural;
      case 'humorDeMilhoes': return _ratings.humorDeMilhoes;
      case 'energiaDeGrupo': return _ratings.energiaDeGrupo;
      case 'criatividadeCaotica': return _ratings.criatividadeCaotica;
      case 'modoAtleta': return _ratings.modoAtleta;
      case 'talentoDePalco': return _ratings.talentoDePalco;
      case 'dripEscolar': return _ratings.dripEscolar;
      case 'coracaoDeDorama': return _ratings.coracaoDeDorama;
      case 'queridinhoDosProfessores': return _ratings.queridinhoDosProfessores;
      case 'cerebroTurbo': return _ratings.cerebroTurbo;
      case 'caosControlado': return _ratings.caosControlado;
      default: return 1;
    }
  }

  void _updateRating(String key, int val) {
    setState(() {
      switch (key) {
        case 'resenha':
          _ratings = _ratings.copyWith(resenha: val);
          break;
        case 'presencaVip':
          _ratings = _ratings.copyWith(presencaVip: val);
          break;
        case 'aura':
          _ratings = _ratings.copyWith(aura: val);
          break;
        case 'modoParceiro':
          _ratings = _ratings.copyWith(modoParceiro: val);
          break;
        case 'carismaNatural':
          _ratings = _ratings.copyWith(carismaNatural: val);
          break;
        case 'humorDeMilhoes':
          _ratings = _ratings.copyWith(humorDeMilhoes: val);
          break;
        case 'energiaDeGrupo':
          _ratings = _ratings.copyWith(energiaDeGrupo: val);
          break;
        case 'criatividadeCaotica':
          _ratings = _ratings.copyWith(criatividadeCaotica: val);
          break;
        case 'modoAtleta':
          _ratings = _ratings.copyWith(modoAtleta: val);
          break;
        case 'talentoDePalco':
          _ratings = _ratings.copyWith(talentoDePalco: val);
          break;
        case 'dripEscolar':
          _ratings = _ratings.copyWith(dripEscolar: val);
          break;
        case 'coracaoDeDorama':
          _ratings = _ratings.copyWith(coracaoDeDorama: val);
          break;
        case 'queridinhoDosProfessores':
          _ratings = _ratings.copyWith(queridinhoDosProfessores: val);
          break;
        case 'cerebroTurbo':
          _ratings = _ratings.copyWith(cerebroTurbo: val);
          break;
        case 'caosControlado':
          _ratings = _ratings.copyWith(caosControlado: val);
          break;
      }
    });
  }

  void _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final id = widget.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final student = Student(
      id: id,
      name: _nameController.text.trim(),
      nickname: _nicknameController.text.trim(),
      course: _selectedCourse,
      classYear: _selectedYear,
      birthDate: _selectedBirthDate,
      ratings: _ratings,
      legendLevel: _ratings.totalScore,
    );

    Result<Student> result;
    if (widget.id != null) {
      result = await widget.viewModel.updateStudent(student);
    } else {
      result = await widget.viewModel.createStudent(student);
    }

    if (mounted) {
      if (result is Success<Student>) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aluno salvo com sucesso!')),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar aluno: ${(result as Failure).error.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalScore = _ratings.totalScore;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id != null ? 'Editar Aluno' : 'Novo Aluno'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              // Personal details section
              Card(
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.person_rounded, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text(
                            'Informações Pessoais',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome *',
                          hintText: 'Digite o nome completo do aluno',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nicknameController,
                        decoration: InputDecoration(
                          labelText: 'Apelido (opcional)',
                          hintText: 'Como o aluno é conhecido',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<Course>(
                              initialValue: _selectedCourse,
                              decoration: InputDecoration(
                                labelText: 'Curso',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              items: Course.values.map((course) {
                                return DropdownMenuItem<Course>(
                                  value: course,
                                  child: Text(course.displayName),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedCourse = val;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              initialValue: _selectedYear,
                              decoration: InputDecoration(
                                labelText: 'Turma/Ano',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              items: _years.map((year) {
                                return DropdownMenuItem<int>(
                                  value: year,
                                  child: Text(year.toString()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedYear = val;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _selectDate(context),
                        borderRadius: BorderRadius.circular(12),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Data de Nascimento',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            suffixIcon: const Icon(Icons.calendar_today_rounded),
                          ),
                          child: Text(
                            '${_selectedBirthDate.day.toString().padLeft(2, '0')}/${_selectedBirthDate.month.toString().padLeft(2, '0')}/${_selectedBirthDate.year}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Realtime Legend Level badge
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nível Lenda calculado em tempo real',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Popularidade Geral',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.bolt_rounded, color: Colors.amber, size: 36),
                          Text(
                            '$totalScore',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            '/75',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 15 criteria of popularity section
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 12),
                child: Row(
                  children: [
                    Icon(Icons.star_rounded, color: Colors.amber),
                    SizedBox(width: 8),
                    Text(
                      'Critérios de Popularidade',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              ...PopularityRatings.criteriaLabels.entries.map((entry) {
                final key = entry.key;
                final label = entry.value;
                final val = _getRatingValue(key);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Nota: $val de 5',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomStarRating(
                          value: val,
                          onChanged: (newVal) => _updateRating(key, newVal),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Salvar Aluno', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
