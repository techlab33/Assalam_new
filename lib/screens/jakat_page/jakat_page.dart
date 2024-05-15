import 'package:flutter/material.dart';


class ZakatCalculatorPage extends StatefulWidget {
  @override
  _ZakatCalculatorPageState createState() => _ZakatCalculatorPageState();
}

class _ZakatCalculatorPageState extends State<ZakatCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double _totalAssets = 0.0;
  double _zakatAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zakat Calculator',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.calculate,color: Colors.white,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Total Assets',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your total assets';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _totalAssets = double.parse(value!);
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        _zakatAmount = (_totalAssets * 2.5) / 100;
                      });
                    }
                  },
                  child: Text('Calculate Zakat'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Zakat Amount: \$${_zakatAmount}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20,),
                Text("Some Questions about Zakat",style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 10,),
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Card(
                          child: ExpansionTile(
                            title: Text("📕 Rules of Zakat",style: TextStyle(color: Color(
                                0xF3098309)),),
                            children: [
                              ListTile(
                                title: Text("👉	one possesses more than 85 grams of gold or 595 grams of silver or cash equivalent to that (the market price of silver is at present tk. 18,000) after fulfilling the yearly expenditure.\n\n"
                                    "👉	if the separate or collective value of gold, or silver ornaments, gems, savings, company shares, foreign currencies, saving certificates, fixed deposits etc is over taka 18 thousand.\n\n"
                                    "👉	the value of business products; animals reared for business, lands or house rents is above the same amount\n\n"
                                    "👉		if the amount of agricultural products is more than 1,100 kilos, one-tenth of naturally produced crops and one-twentieth of crops produced with irrigated water should be given as Zakat.\n\n"
                                    "👉 Zakat is to be given at the rate of 2.5% (2.5 taka per hundred) on all saved up money, gold, silver ornaments etc.\n\n"
                                    "👉 Zakat is to be paid after minute calculation with proper niyat (intention). If given without intention or calculation, it will be sadka, not zakat"),
                              ),
                            ],),
                        ),
                        //============== end of zakat rules================//
                        Card(
                          child: ExpansionTile(
                            title: Text("📕 Who is Eligible for Zakat?",style: TextStyle(color:Color(
                                0xF3098309)),),
                            children: [
                              ListTile(
                                title: Text("👉Those living in poverty and with little to no income referred to as Fuqara\n\n"
                                    "👉People who do not have access to basic needs and amenities, known as Al-Masakin\n\n"
                                    "👉Individuals or organisations employed to distribute Zakat, also called Amil\n\n"
                                    "👉Those who are new to Islam and friends of the community, referred to as Muallaf\n\n"
                                    "👉People living in captivity and victims of slavery, known as Riqab\n\n"
                                    "👉People who are in debt beyond their means, called Gharmin\n\n"
                                    "👉Individuals who work for Allah's cause, also called Fisabilillah\n\n"
                                    "👉People who are travelling and require help or assistance, referred to as Ibnus Sabil"),
                              )
                            ],
                          ),
                        ),
                        Card(
                          child: ExpansionTile(
                            title: Text("📕 Can I pay Zakat to non-Muslims?",style: TextStyle(color: Color(
                                0xF3098309)),),
                            children: [
                              ListTile(
                                title: Text("👉 You can give your Zakat to a non-Muslim as long as they are eligible per the eight categories in the Qur'an and are not involved in fighting Muslims or forcing them out of their homes."),
                              )
                            ],
                          ),
                        ),
                        Card(
                          child: ExpansionTile(
                            title: Text("📕 What do I need to pay Zakat on?",style: TextStyle(color: Color(
                                0xF3098309)),),
                            children: [
                              ListTile(
                                title: Text("Zakat is not just paid on the savings in your bank account. You need to pay Zakat on other types of wealth, such as:\n\n"
        
                                    "👉Gold and silver\n\n"
                                    "👉Cash held at home or in bank accounts\n\n"
                                    "👉Stocks and shares owned either directly or through investment funds\n\n"
                                    "👉Money lent to others\n\n"
                                    "👉Business stock in trade and merchandise\n\n"
                                    "👉Agricultural produce\n\n"
                                    "👉Livestock animals such as cows, goats and sheep\n\n"
                                    "👉Pensions\n\n"
                                    "👉Property owned for investment purposes"),
                              )
                            ],
                          ),
                        ),
                        Card(
                          child: ExpansionTile(
                            title: Text("📕 How Much Is Zakat??",style: TextStyle(color: Color(
                                0xF3098309)),),
                            children: [
                              ListTile(
                                title: Text("👉 Zakat is charged at a rate of 2.5%. This means you should donate 2.5% of your wealth which exceeds the nisab value. If you're struggling to work out how much zakat you need to pay, use our zakat calculator."
                                    "If you don't exceed the nisab value, you need not pay."),
                              )
                            ],
                          ),
                        ),
        
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}