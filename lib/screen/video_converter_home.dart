// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, use_build_context_synchronously

import 'package:get_files_easy/stores/video_converter_store.dart';
import 'package:get_files_easy/widgets/custom_app_bar.dart';
import 'package:get_files_easy/widgets/output_format_dropdown.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path/path.dart' as p;
import '../util/globals.dart' as globals;

class VideoConverterHome extends StatefulWidget {
  const VideoConverterHome({super.key});

  @override
  State<VideoConverterHome> createState() => _VideoConverterHomeState();
}

class _VideoConverterHomeState extends State<VideoConverterHome> {
  final store = VideoConverterQueueStore();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Conversor de Vídeo',
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
        elevation: 1,
      ),
      body: DropTarget(
        onDragEntered: (_) => store.setIsDragging(true),
        onDragExited: (_) => store.setIsDragging(false),
        onDragDone: (detail) {
          // Adiciona todos arquivos válidos do drop
          final validFiles = detail.files.where((f) {
            final ext = p.extension(f.path).toLowerCase().replaceAll('.', '');
            return globals.allowedExtensions.contains(ext);
          }).toList();

          if (validFiles.isNotEmpty) {
            for (final file in validFiles) {
              store.addFile(file.path, store.selectedFormat, store.selectedResolution);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Nenhum arquivo válido no formato: ${globals.allowedExtensions.join(', ')}',
                ),
              ),
            );
          }
          store.setIsDragging(false);
        },
        child: Observer(
          builder: (_) => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: store.isDragging
                ? theme.colorScheme.primaryContainer.withOpacity(0.3)
                : Colors.transparent,
            padding: const EdgeInsets.all(24),
            child: _body(theme),
          ),
        ),
      ),
    );
  }

  Widget _body(ThemeData theme) {
    return Center(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700, maxHeight: 600),
            child: Column(
              children: [
                Expanded(
                  child: Observer(
                    builder: (_) {
                      if (store.queue.isEmpty) {
                        return Center(
                          child: Text(
                            "Nenhum arquivo na fila.\nArraste ou selecione arquivos para converter.",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge,
                          ),
                        );
                      }
                      return _buildListView(theme);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Adicionar arquivo(s)"),
                        onPressed: _pickFiles,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Iniciar conversão"),
                        onPressed: store.queue.isEmpty ? null : store.convertAll,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildListView(ThemeData theme) {
    return ListView.builder(
      itemCount: store.queue.length,
      itemBuilder: (_, index) {
        final item = store.queue[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.basename(item.inputPath),
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Observer(
                  builder: (_) {
                    return LinearProgressIndicator(
                      value: item.progress,
                      minHeight: 6,
                      backgroundColor: theme.colorScheme.surfaceVariant,
                      color: theme.colorScheme.primary,
                    );
                  },
                ),
                const SizedBox(height: 8),
                Observer(
                  builder: (_) {
                    return Text(
                      item.status,
                      style: theme.textTheme.bodySmall,
                    );
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Observer(
                        builder: (_) {
                          return OutputFormatDropdown(
                            value: item.outputFormat,
                            formats: globals.outputFormats,
                            onChanged: (value) {
                              if (value != null) {
                                item.outputFormat = value;
                              }
                            },
                          );
                        }
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Observer(
                        builder: (_) {
                          return DropdownButton<String>(
                            value: item.resolution,
                            isExpanded: true,
                            items: globals.allowedResolutions.map((res) {
                              return DropdownMenuItem<String>(
                                value: res,
                                child: Text(res),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                item.resolution = value;
                              }
                            },
                          );
                        }
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        store.removeItem(item);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: globals.allowedExtensions,
    );

    if (result != null && result.files.isNotEmpty) {
      for (final file in result.files) {
        final path = file.path;
        if (path != null) {
          store.addFile(path, store.selectedFormat, store.selectedResolution);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum arquivo selecionado.')),
      );
    }
  }
}
