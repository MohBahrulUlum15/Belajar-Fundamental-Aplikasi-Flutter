import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ModulPage(),
    );
  }
}

class ModulPage extends StatefulWidget {
  const ModulPage({super.key});

  @override
  State<ModulPage> createState() => _ModulPageState();
}

class _ModulPageState extends State<ModulPage> {
  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memulai Pemrograman Dengan Dart'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoneModulList(
                              doneModuleList: doneModuleList,
                            )));
              },
              icon: const Icon(Icons.done)),
        ],
      ),
      body: ModuleList(
        doneModuleList: doneModuleList,
      ),
    );
  }
}

class ModuleList extends StatefulWidget {
  final List<String> doneModuleList;
  const ModuleList({Key? key, required this.doneModuleList}) : super(key: key);

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  final List<String> _moduleList = const [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Program Dart Pertamamu',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _moduleList.length,
        itemBuilder: (context, index) {
          return ModuleTile(
            moduleName: _moduleList[index],
            isDone: widget.doneModuleList.contains(
              _moduleList[index],
            ),
            onClick: () {
              setState(() {
                widget.doneModuleList.add(_moduleList[index]);
              });
            },
          );
        });
  }
}

class ModuleTile extends StatelessWidget {
  final String moduleName;
  final bool isDone;
  final Function() onClick;

  const ModuleTile({
    super.key,
    required this.moduleName,
    required this.isDone,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(moduleName),
      trailing: isDone
          ? const Icon(Icons.done)
          : ElevatedButton(
              onPressed: onClick,
              child: const Text('Done'),
            ),
    );
  }
}

class DoneModulList extends StatelessWidget {
  final List<String> doneModuleList;
  const DoneModulList({super.key, required this.doneModuleList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Done Module List'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doneModuleList[index]),
          );
        },
        itemCount: doneModuleList.length,
      ),
    );
  }
}
