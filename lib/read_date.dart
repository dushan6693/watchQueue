class ReadDate{

  final DateTime _dateTime = DateTime.now();

  String getDuration(String oldDate){

    List<String> parts = oldDate.split('/');

    int yyyy = int.parse(parts[0]);
    int mm = int.parse(parts[1]);
    int dd = int.parse(parts[2]);
    int hh = int.parse(parts[3]);
    int min = int.parse(parts[4]);

    if(yyyy<_dateTime.year){
      return "${_dateTime.year-yyyy} years";
    }else if(mm<_dateTime.month){
      return "${_dateTime.month-mm} months";
    }else if(dd<_dateTime.day){
      return "${_dateTime.day-dd} days";
    }else if(hh<_dateTime.hour) {
      return "${_dateTime.hour - hh} hours";
    }else if(min<_dateTime.minute) {
      return "${_dateTime.minute - min} min";
    }else{
      return "Just now";
    }

  }
  String getDateNow(){
    return "${_dateTime.year}/${_dateTime.month}/${_dateTime.day}/${_dateTime.hour}/${_dateTime.minute}";
  }
}