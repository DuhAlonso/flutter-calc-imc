import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weigthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Insira seu Peso e Altura";

  void _resetFilds(){
    weigthController.text="";
    heightController.text="";
    setState(() {
      _infoText = "Insira seu Peso e Altura";
      _formKey = GlobalKey<FormState>();    // Limpar a linha quando tiver com erro!
    });
  }

  void _calculater(){
    setState(() {
      double weigth = double.parse(weigthController.text);
      double heigth = double.parse(heightController.text)/100 ;
      double imc = weigth / (heigth * heigth);
      if(imc < 18.6){
        _infoText = "Abaixo do peso. (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal. (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso. (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I. (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II. (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 40) {
        _infoText = "Obesidade Grau III. (${imc.toStringAsPrecision(4)})";
      }

      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
          onPressed: _resetFilds,
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Form(
          key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Icon(Icons.person, size: 120.0, color: Colors.white),

                TextFormField(keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.white)
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  controller: weigthController,
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira seu peso!!!";
                    }
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child:
                  TextFormField(keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.white)
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura!!!";
                      }
                    }
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calculater();
                        }
                      },
                      child: Text("Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0)
                      ),
                      color: Colors.teal,
                    ),
                  ),
                ),

                Text(_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                )

              ],
            ),
        ),
      ),
    );
  }
}
