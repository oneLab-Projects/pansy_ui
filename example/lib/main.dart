import 'package:pansy_ui/pansy_ui.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PansyApp(
      title: 'pansy_ui demo',
      theme: ThemeData(
        accentColor: Colors.grey[900],
      ),
      darkTheme: ThemeData(
        accentColor: Colors.grey[100],
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pansy UI'),
        actions: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () => setState(() => _counter--),
            tooltip: 'Decrement Counter',
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => setState(() => _counter++),
            tooltip: 'Increment Counter',
          ),
        ].separated(SizedBox(width: 2)),
      ),
      body: Center(
        child: Text(
          _counter.toString(),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.visibility),
        onPressed: () => ThemeProvider.of(context).toggleThemeMode(),
        tooltip: 'Change theme',
      ),
    );
  }
}
