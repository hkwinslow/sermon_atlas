import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sermon_atlas/cubit/sermon_cubit.dart';
import 'package:sermon_atlas/data/model/sermon.dart';
import 'package:intl/intl.dart';

class SermonSearchPage extends StatefulWidget {
  @override
  _SermonSearchPageState createState() => _SermonSearchPageState();
}

class _SermonSearchPageState extends State<SermonSearchPage> {
  TextEditingController _titleController;
  TextEditingController _locationController;
  TextEditingController _dateController;


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _locationController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Add sermon page pops up
          _showMyDialog(context);
        },
      ),
      appBar: AppBar(
        title: Image.asset('assets/church_img.png', height: 80),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<SermonCubit, SermonState>(
          listener: (context, state) {
            if (state is SermonError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SermonInitial) {
              final sermonCubit = context.bloc<SermonCubit>();
              sermonCubit.getSermon();
              return Container();
            } else if (state is SermonLoading) {
              return buildLoading();
            } else if (state is SermonLoaded) {
              return buildColumnWithData(state.sermon);
            } else {
              // (state is SermonError)
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(List<Sermon> sermons) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CityInputField(),
        Expanded(
          child: ListView.builder(
            itemCount: sermons.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${sermons[index].title}'),
                subtitle: Text('${sermons[index].location}'),
                trailing: Text(formatDateTime(sermons[index].date)),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('add a sermon'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                  ),
                ),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                final sermonCubit = context.bloc<SermonCubit>();

                sermonCubit.addSermon(_titleController.text, _locationController.text,
                DateTime.parse(_dateController.text));

                sermonCubit.getSermon();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

String formatDateTime(DateTime dateTime) {
  return DateFormat.yMMMd().format(dateTime);
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(children: <Widget>[
        TextField(
          onSubmitted: (value) => submitCityName(context, value),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: "Enter a city",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ]),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    //I think this section will act as a search query text field. So I will eventually
    // call a query and then return the applicable entries
    final sermonCubit = context.bloc<SermonCubit>();
    sermonCubit.getSermon();
  }
}
