import 'dart:async';

class StreamBloc{
  final StreamController<int> _stateStreamController = StreamController<int>();
  StreamSink<int> get _stateStreamSink =>_stateStreamController.sink;
  Stream<int> get stateStream => _stateStreamController.stream;

  final StreamController<int> _eventStreamController = StreamController<int>();
  StreamSink<int> get eventStreamSink =>_eventStreamController.sink;
  Stream<int> get _eventStream => _eventStreamController.stream;

  StreamBloc(){
    _eventStream.listen((event){
     //do something if you want..
      _stateStreamSink.add(event);
    });
  }
}