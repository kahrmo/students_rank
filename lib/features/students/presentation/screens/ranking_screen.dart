import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../domain/entities/student.dart';
import '../viewmodels/students_viewmodel.dart';

class RankingScreen extends StatelessWidget {
  final StudentsViewModel viewModel;

  const RankingScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final rankingList = viewModel.ranking.watch(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking de Popularidade'),
      ),
      body: SafeArea(
        child: rankingList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      size: 80,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nenhum aluno cadastrado para o ranking',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.push('/students/create'),
                      child: const Text('Cadastrar Aluno'),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  if (rankingList.length >= 3)
                    _buildPodium(context, rankingList.sublist(0, 3))
                  else
                    const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: rankingList.length,
                      itemBuilder: (context, index) {
                        final student = rankingList[index];
                        final rank = index + 1;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: rank <= 3 ? 4 : 1,
                          shadowColor: _getRankColor(rank).withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: rank <= 3 ? _getRankColor(rank) : Colors.transparent,
                              width: rank <= 3 ? 1.5 : 0,
                            ),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: _getRankColor(rank).withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: _getRankIconOrText(rank),
                              ),
                            ),
                            title: Text(
                              student.name,
                              style: TextStyle(
                                fontWeight: rank <= 3 ? FontWeight.bold : FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '${student.course.displayName} • Turma ${student.classYear}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.bolt_rounded, color: Colors.amber, size: 20),
                                Text(
                                  '${student.legendLevel}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => context.push('/students/${student.id}'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildPodium(BuildContext context, List<Student> topThree) {
    final first = topThree[0];
    final second = topThree[1];
    final third = topThree[2];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPodiumItem(context, second, 2, 100, Colors.grey.shade400),
          _buildPodiumItem(context, first, 1, 130, Colors.amber.shade600),
          _buildPodiumItem(context, third, 3, 85, Colors.brown.shade400),
        ],
      ),
    );
  }

  Widget _buildPodiumItem(
    BuildContext context,
    Student student,
    int rank,
    double height,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => context.push('/students/${student.id}'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (rank == 1)
            const Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 28)
          else
            const Icon(Icons.star_rounded, color: Colors.transparent, size: 24),
          const SizedBox(height: 4),
          CircleAvatar(
            radius: rank == 1 ? 30 : 25,
            backgroundColor: color.withOpacity(0.2),
            child: CircleAvatar(
              radius: rank == 1 ? 27 : 22,
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Text(
                student.name.isNotEmpty ? student.name[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: rank == 1 ? 18 : 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 90,
            child: Text(
              student.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bolt_rounded, color: Colors.amber, size: 14),
              Text(
                '${student.legendLevel}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: 90,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color,
                  color.withOpacity(0.6),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$rankº',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber.shade600;
      case 2:
        return Colors.grey.shade400;
      case 3:
        return Colors.brown.shade400;
      default:
        return Colors.transparent;
    }
  }

  Widget _getRankIconOrText(int rank) {
    switch (rank) {
      case 1:
        return const Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 18);
      case 2:
        return Icon(Icons.workspace_premium_rounded, color: Colors.grey.shade600, size: 18);
      case 3:
        return Icon(Icons.workspace_premium_rounded, color: Colors.brown.shade600, size: 18);
      default:
        return Text(
          '$rank',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        );
    }
  }
}
