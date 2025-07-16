// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:path/path.dart' as p;

part 'video_converter_store.g.dart';

class VideoConverterQueueStore = _VideoConverterQueueStore with _$VideoConverterQueueStore;

class ConversionItem = _ConversionItem with _$ConversionItem;

abstract class _ConversionItem with Store {
  _ConversionItem({
    required this.inputPath,
    required this.outputFormat,
    required this.resolution,
  });

  final String inputPath;

  @observable
  String outputFormat;

  @observable
  String resolution;

  @observable
  double progress = 0.0;

  @observable
  String status = 'Pendente';
}

abstract class _VideoConverterQueueStore with Store {
  @observable
  ObservableList<ConversionItem> queue = ObservableList<ConversionItem>();

  @observable
  bool isDragging = false;

  @observable
  String selectedFormat = 'mp4';

  @observable
  String selectedResolution = '1920x1080';

  @action
  void addFile(String inputPath, String outputFormat, String resolution) {
    queue.add(ConversionItem(
      inputPath: inputPath,
      outputFormat: outputFormat,
      resolution: resolution,
    ));
  }

  @action
  void removeItem(ConversionItem item) {
    queue.remove(item);
  }

  @action
  void setIsDragging(bool value) => isDragging = value;

  @action
  void setSelectedFormat(String value) => selectedFormat = value;

  @action
  void setSelectedResolution(String value) => selectedResolution = value;

  @action
  Future<void> convertAll() async {
    for (final item in queue) {
      await _convertItem(item);
    }
  }

  Future<void> _convertItem(ConversionItem item) async {
    final outputPath = p.setExtension(item.inputPath, '.${item.outputFormat}');

    item.status = 'Obtendo duração...';

    final duration = await _getVideoDuration(item.inputPath);
    if (duration == null) {
      item.status = 'Erro: não foi possível obter duração';
      return;
    }

    item.status = 'Convertendo...';
    item.progress = 0.0;

    try {
      final parts = item.resolution.split('x');
      final width = parts[0];
      final height = parts[1];

      final process = await Process.start(
        'ffmpeg',
        [
          '-i',
          item.inputPath,
          '-vf',
          'scale=$width:$height',
          outputPath,
        ],
        runInShell: true,
      );

      process.stderr
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((line) {
        final match = RegExp(r'time=(\d+):(\d+):(\d+).(\d+)').firstMatch(line);
        if (match != null) {
          final current = Duration(
            hours: int.parse(match.group(1)!),
            minutes: int.parse(match.group(2)!),
            seconds: int.parse(match.group(3)!),
            milliseconds: int.parse(match.group(4)!),
          );
          final percent = current.inMilliseconds / duration.inMilliseconds;
          item.progress = percent.clamp(0.0, 1.0);
          item.status = 'Convertendo: ${(percent * 100).toStringAsFixed(1)}%';
        }
      });

      final exitCode = await process.exitCode;

      if (exitCode == 0) {
        item.progress = 1.0;
        item.status = 'Conversão concluída!';
      } else {
        item.status = 'Erro na conversão (código $exitCode)';
      }
    } catch (e) {
      item.status = 'Erro: $e';
    }
  }

  Future<Duration?> _getVideoDuration(String inputPath) async {
    try {
      final result = await Process.run(
        'ffmpeg',
        ['-i', inputPath],
        runInShell: true,
      );
      final output = result.stderr as String;

      final match = RegExp(r'Duration: (\d+):(\d+):(\d+).(\d+)').firstMatch(output);
      if (match != null) {
        return Duration(
          hours: int.parse(match.group(1)!),
          minutes: int.parse(match.group(2)!),
          seconds: int.parse(match.group(3)!),
          milliseconds: int.parse(match.group(4)!),
        );
      }
    } catch (_) {}
    return null;
  }
}
