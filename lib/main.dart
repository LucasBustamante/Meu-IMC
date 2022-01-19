// ignore_for_file: prefer_const_constructors, avoid_print, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:caculadora_imc/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controlepeso = TextEditingController();
  TextEditingController controlealtura = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String info = "Informe seus dados!";

  void _reset (){
    controlealtura.text = "";
    controlepeso.text = "";
    setState(() {
      info = "Informe seus dados!";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(controlepeso.text);
      double altura = double.parse(controlealtura.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.6) {
        info = "Abaixo do Peso \n(IMC ${imc.toStringAsPrecision(3)})";
      }else if(imc >= 18.6 && imc < 24.9){
        info = "Peso Ideal \n(IMC ${imc.toStringAsPrecision(3)})";
      }else if(imc >= 24.9 && imc < 29.9){
        info = "Levemente Acima do Peso \n(IMC ${imc.toStringAsPrecision(3)})";
      }else if(imc >=29.9 && imc < 34.9){
        info = "Obesidade Grau I \n(IMC ${imc.toStringAsPrecision(3)})";
      }else if (imc >= 34.9 && imc < 39.9){
        info = "Obesidade Grau II \n(IMC ${imc.toStringAsPrecision(3)})";
      }else if(imc >= 40){
        info = "Obesidade Grau III \n(IMC ${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0386,0.01),
              end: Alignment(0,0),
              stops: [0.5, 0.5],
              colors: [kPrimaryColor, kSecondaryColor
              ], ),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.037,
                          child: ElevatedButton(onPressed: _reset, child: Text('Resetar',
                            style: TextStyle(color: Colors.black,
                            ),),
                            style: ElevatedButton.styleFrom(primary: kElementsColor,
                                shadowColor: kElementsColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20,)
                                )),),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.13),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Calculadora IMC',
                          style: TextStyle(
                            color: Colors.white, fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: kElementsColor,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kElementsColor),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: kElementsColor
                              )
                          ),
                          labelText: "Peso (Kg)",
                          labelStyle: TextStyle(color: kFontColor)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kFontColor, fontSize: 25.0),
                      controller: controlepeso,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Insira seu Peso";
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    TextFormField(
                      cursorColor: kFontColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kElementsColor),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: kElementsColor
                              )
                          ),
                          labelText: "Altura (cm)",
                          labelStyle: TextStyle(color: kFontColor)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kFontColor, fontSize: 25.0),
                      controller: controlealtura,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Insira sua Altura";
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: SizedBox(width: 500, height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              _calcular();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.black, fontSize: 25.0),
                          ),
                          style: ElevatedButton.styleFrom(primary: kElementsColor,
                              shadowColor: kElementsColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)
                              )
                          ),
                        ),
                      ),
                    ),
                    Text(
                      (info),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kElementsColor, fontSize: 25.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}


