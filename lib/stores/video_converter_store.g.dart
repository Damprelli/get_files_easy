// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_converter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConversionItem on _ConversionItem, Store {
  late final _$outputFormatAtom = Atom(
    name: '_ConversionItem.outputFormat',
    context: context,
  );

  @override
  String get outputFormat {
    _$outputFormatAtom.reportRead();
    return super.outputFormat;
  }

  @override
  set outputFormat(String value) {
    _$outputFormatAtom.reportWrite(value, super.outputFormat, () {
      super.outputFormat = value;
    });
  }

  late final _$resolutionAtom = Atom(
    name: '_ConversionItem.resolution',
    context: context,
  );

  @override
  String get resolution {
    _$resolutionAtom.reportRead();
    return super.resolution;
  }

  @override
  set resolution(String value) {
    _$resolutionAtom.reportWrite(value, super.resolution, () {
      super.resolution = value;
    });
  }

  late final _$progressAtom = Atom(
    name: '_ConversionItem.progress',
    context: context,
  );

  @override
  double get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  late final _$statusAtom = Atom(
    name: '_ConversionItem.status',
    context: context,
  );

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  @override
  String toString() {
    return '''
outputFormat: ${outputFormat},
resolution: ${resolution},
progress: ${progress},
status: ${status}
    ''';
  }
}

mixin _$VideoConverterQueueStore on _VideoConverterQueueStore, Store {
  late final _$queueAtom = Atom(
    name: '_VideoConverterQueueStore.queue',
    context: context,
  );

  @override
  ObservableList<ConversionItem> get queue {
    _$queueAtom.reportRead();
    return super.queue;
  }

  @override
  set queue(ObservableList<ConversionItem> value) {
    _$queueAtom.reportWrite(value, super.queue, () {
      super.queue = value;
    });
  }

  late final _$isDraggingAtom = Atom(
    name: '_VideoConverterQueueStore.isDragging',
    context: context,
  );

  @override
  bool get isDragging {
    _$isDraggingAtom.reportRead();
    return super.isDragging;
  }

  @override
  set isDragging(bool value) {
    _$isDraggingAtom.reportWrite(value, super.isDragging, () {
      super.isDragging = value;
    });
  }

  late final _$selectedFormatAtom = Atom(
    name: '_VideoConverterQueueStore.selectedFormat',
    context: context,
  );

  @override
  String get selectedFormat {
    _$selectedFormatAtom.reportRead();
    return super.selectedFormat;
  }

  @override
  set selectedFormat(String value) {
    _$selectedFormatAtom.reportWrite(value, super.selectedFormat, () {
      super.selectedFormat = value;
    });
  }

  late final _$selectedResolutionAtom = Atom(
    name: '_VideoConverterQueueStore.selectedResolution',
    context: context,
  );

  @override
  String get selectedResolution {
    _$selectedResolutionAtom.reportRead();
    return super.selectedResolution;
  }

  @override
  set selectedResolution(String value) {
    _$selectedResolutionAtom.reportWrite(value, super.selectedResolution, () {
      super.selectedResolution = value;
    });
  }

  late final _$convertAllAsyncAction = AsyncAction(
    '_VideoConverterQueueStore.convertAll',
    context: context,
  );

  @override
  Future<void> convertAll() {
    return _$convertAllAsyncAction.run(() => super.convertAll());
  }

  late final _$_VideoConverterQueueStoreActionController = ActionController(
    name: '_VideoConverterQueueStore',
    context: context,
  );

  @override
  void addFile(String inputPath, String outputFormat, String resolution) {
    final _$actionInfo = _$_VideoConverterQueueStoreActionController
        .startAction(name: '_VideoConverterQueueStore.addFile');
    try {
      return super.addFile(inputPath, outputFormat, resolution);
    } finally {
      _$_VideoConverterQueueStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeItem(ConversionItem item) {
    final _$actionInfo = _$_VideoConverterQueueStoreActionController
        .startAction(name: '_VideoConverterQueueStore.removeItem');
    try {
      return super.removeItem(item);
    } finally {
      _$_VideoConverterQueueStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsDragging(bool value) {
    final _$actionInfo = _$_VideoConverterQueueStoreActionController
        .startAction(name: '_VideoConverterQueueStore.setIsDragging');
    try {
      return super.setIsDragging(value);
    } finally {
      _$_VideoConverterQueueStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFormat(String value) {
    final _$actionInfo = _$_VideoConverterQueueStoreActionController
        .startAction(name: '_VideoConverterQueueStore.setSelectedFormat');
    try {
      return super.setSelectedFormat(value);
    } finally {
      _$_VideoConverterQueueStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedResolution(String value) {
    final _$actionInfo = _$_VideoConverterQueueStoreActionController
        .startAction(name: '_VideoConverterQueueStore.setSelectedResolution');
    try {
      return super.setSelectedResolution(value);
    } finally {
      _$_VideoConverterQueueStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
queue: ${queue},
isDragging: ${isDragging},
selectedFormat: ${selectedFormat},
selectedResolution: ${selectedResolution}
    ''';
  }
}
