import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:task_management/services/database.dart';

class EventAdd extends StatefulWidget {
  @override
  _EventAddState createState() => _EventAddState();
}


class _EventAddState extends State<EventAdd> {

  final _formKey = GlobalKey<FormState>();
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();
  String? title, description, address;

  DateTime selectData = DateTime.now();
  final firstDate = DateTime(2021, 8, 15, 5); // year, month, day, hour
  final lastDate =  DateTime(2022, 8, 15, 5);


  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String? _hour, _minute, _time;
  String? _setTime, _setDate;
  bool completed = false;
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timeController.text =  DateFormat('hh:mm a').format(DateTime(selectData.year, selectData.month, selectData.day, selectedTime.hour, selectedTime.minute)).toString();
    _dateController.text =  DateFormat("dd-MM-yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr_TR', null);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey,),),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    "Create Event !",
                    style: TextStyle(
                        color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: "Event Title",
                      hintStyle: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (value) => title = value,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            _openDate(context);
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: TextFormField(
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                              onSaved: (String? value) {
                                _setDate = value;
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _dateController,
                              decoration: InputDecoration(
                                  disabledBorder:
                                  UnderlineInputBorder(borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.all(5)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            _openTime(context);
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: TextFormField(
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                              onSaved: (String? value) {
                                _setTime = value;
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _timeController,
                              decoration: InputDecoration(
                                  disabledBorder:
                                  UnderlineInputBorder(borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.all(5)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: "Event Address",
                      hintStyle: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (value) => address = value,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    maxLines: null,
                    maxLength: 100,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                      hintText: "Event Description",
                      hintStyle: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (value) => description = value,
                  ),
                ),

                Center(
                  child: Padding(
                    padding:  EdgeInsets.all(20.0),
                    child: TextButton(
                        onPressed: () async {

                          final form = _formKey.currentState;
                          final userId  = context.read<AuthenticationService>().getCurrentUID;

                          if(form!.validate()){
                            form.save();

                            await fireStoreDatabase.saveEvent(userId, this.title, this.description, this.completed, _setDate, _setTime, this.address);
                            Navigator.pop(context);

                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))
                        ),
                        child: Text("Create Event", style: TextStyle(color: Colors.blueGrey, fontSize: 20),)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _openDate(BuildContext context) async {
    final  DateTime? date = await  showDatePicker(context: context, initialDate: selectData, firstDate: firstDate, lastDate: lastDate);
    if(date != null){
      setState(() {
        selectData = date;
        _dateController.text = DateFormat("dd-MM-yyyy").format(selectData);
      });
    }
  }

  _openTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: selectedTime,);
    if(time != null){
      //DateTime parsedTime = DateFormat.jm("tr").parse(picked.format(context).toString());
      //String formattedTime = DateFormat('HH:mm').format(parsedTime);
      // hh:mm a
      setState(() {
        selectedTime = time;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! +':' +_minute!;
        _timeController.text = _time!;
        _timeController.text =  DateFormat('H:m a').format(DateTime(selectData.year, selectData.month, selectData.day, selectedTime.hour, selectedTime.minute)).toString();
      });
    }
  }

}
