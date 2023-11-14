import 'package:bmi/const.dart';
import 'package:bmi/pages/calculator.dart';
import 'package:bmi/pages/component.dart';
import 'package:bmi/pages/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //AppBar Change
  TextStyle changedAppBar =
      const TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 20);

  TextStyle defaultAppBar =
      const TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 20);

  //Content Change
  TextStyle onclickstyle = const TextStyle(
    color: white,
    fontWeight: FontWeight.bold,
  );

  TextStyle defaultStyle = const TextStyle(
    color: black,
    fontWeight: FontWeight.bold,
  );

  Color defaulticon = Colors.black;
  Color newicon = Colors.white;

  //BG Change
  LinearGradient defaultGradient = const LinearGradient(
    colors: [white, white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  LinearGradient maleGradient = const LinearGradient(
    colors: [darkblue, lightblue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient femaleGradient = const LinearGradient(
    colors: [darkpink, lightpink],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  void changeMaleBackground() {
    setState(() {
      defaultAppBar = changedAppBar;
      defaultGradient = maleGradient;
      defaultStyle = onclickstyle;
      defaulticon = newicon;
    });
  }

  void changeFemaleBackground() {
    setState(() {
      defaultAppBar = changedAppBar;
      defaultGradient = femaleGradient;
      defaultStyle = onclickstyle;
      defaulticon = newicon;
    });
  }

  //Gender----------------------------------------------------------
  int _gender = 0;

  final ChoiceChip3DStyle selectedStyle = ChoiceChip3DStyle(
      topColor: Colors.grey[200]!,
      backColor: Colors.grey,
      borderRadius: BorderRadius.circular(20));

  final ChoiceChip3DStyle unselectedStyle = ChoiceChip3DStyle(
      topColor: transparent,
      backColor: Colors.grey[300]!,
      borderRadius: BorderRadius.circular(20));

  //Height-----------------------------------------------------------
  double _height = 150;

  //Age and Weight
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: defaultGradient),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                              Icons.speed,
                              color: defaulticon,
                            ),
                        ),
                        Text(
                          "BMI Calculator",
                          style: defaultAppBar,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.logout,
                                color: defaulticon,
                              ),
                              onPressed: () {
                                signOut();
                              }),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select Gender :",
                        style: defaultStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChoiceChip3D(
                              border: Border.all(color: Colors.grey),
                              style:
                                  _gender == 1 ? selectedStyle : unselectedStyle,
                              onSelected: () {
                                changeMaleBackground();
                                setState(() {
                                  _gender = 1;
                                });
                              },
                              onUnSelected: () {},
                              selected: _gender == 1,
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/man.png",
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Male")
                                ],
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          ChoiceChip3D(
                              border: Border.all(color: Colors.grey),
                              style:
                                  _gender == 2 ? selectedStyle : unselectedStyle,
                              onSelected: () {
                                changeFemaleBackground();
                                setState(() {
                                  _gender = 2;
                                });
                              },
                              selected: _gender == 2,
                              onUnSelected: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/woman.png",
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Female")
                                ],
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Height :",
                        style: defaultStyle,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _height.toStringAsFixed(0),
                          style: defaultAppBar,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "cm",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        )
                      ],
                    ),
                    Slider(
                      min: 0,
                      max: 240,
                      value: _height.toDouble(),
                      thumbColor: black,
                      activeColor: black,
                      onChanged: (value) {
                        setState(() {
                          _height = value.toDouble();
                        });
                      },
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Age :",
                            style: defaultStyle,
                          ),
                          Text(
                            "Weight :",
                            style: defaultStyle,
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      controller: ageController,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    "(years)",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      controller: weightController,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    "(kg)",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    NeumorphicButton(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.08),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.35,
                          right: MediaQuery.of(context).size.width * 0.35,
                          top: 15,
                          bottom: 15),
                      onPressed: () {
                        Calculator cal = Calculator(
                            height: _height,
                            weight: int.parse(weightController.text));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Result(
                                bmi: cal.calucutateBMI(), result: cal.result()),
                          ),
                        );
                      },
                      style: const NeumorphicStyle(color: black),
                      child: const Text(
                        'Calculate',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GuideScreen(),
            ),
          );
        },
        elevation: 12,
        backgroundColor: black,
        foregroundColor: white,
        tooltip: 'Guide',
        child: Icon(Icons.book),
      ),
    );
  }
}
