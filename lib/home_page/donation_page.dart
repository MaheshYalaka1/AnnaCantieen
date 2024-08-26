import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';

class DonetionPage extends StatefulWidget {
  const DonetionPage({super.key});

  @override
  State<DonetionPage> createState() => _DonetionPage();
}

class _DonetionPage extends State<DonetionPage> {
  final _razorpay = Razorpay();
  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // void payment(amount) async {
  //   amount = amount;
  //   var options = {
  //     'key': 'rzp_live_Cv4tNJlReGwrkM',
  //     'amount': amount * 100,
  //     'name': 'Ellostar',
  //     'description': _nameController.text,
  //     'prefill': {
  //       'contact': _phonenumber.text,
  //     }
  //   };
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     print('error: $e');
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }



  final _formkey = GlobalKey<FormState>();

  String? _selectedDonorType;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedDistrict;
  String? _selectedGender; // Gender selection
  bool _breakfastSelected = false;
  bool _lunchSelected = false;
  bool _dinnerSelected = false;
  bool _breakfast1Selected = false;
  bool _lunch1Selected = false;
  bool _dinner1Selected = false;
  bool _all = false;


  final List<String> _districts = ['District 1', 'District 2', 'District 3'];
  final List<String> _states = ['State 1', 'State 2', 'State 3'];





  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("_handlePaymentSuccess${{response.paymentId}}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("_handlePaymentError");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("_handleExternalWallet");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff8f8),
      appBar: AppBar(
        backgroundColor: const Color(0xffE20736),
        title: const Text(
          'Donation',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              children: [
          Stack(
          children: [
          Container(
          height: 250,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              // margin: EdgeInsets.all(10),
              decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/image.jpg',
                      ),
                      fit: BoxFit.cover))),
          ],
        ),

                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formkey,
                    child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Donate for Anna Canteen', style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xffdc0000)
                              ),
                              )
                              
                            ],
                          ),
                          Divider(
                            color: Color(0xffdc0000),
                            thickness: 1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Type of Donor*',labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700
                            )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter type of donor';
                              }
                              return null;
                            },
                          ),

                          TextFormField(
                            decoration: InputDecoration(labelText: 'Full Name*',
                                labelStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter full name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10,),

                          Text('Gender*',style:  TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700
                          )),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Male'),
                                  value: 'Male',
                                  groupValue: _selectedGender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                ),


                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Female'),
                                  value: 'Female',
                                  groupValue: _selectedGender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedGender = value;
                                    }
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [

                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'DOB (DD/MM/YYYY) ',labelStyle: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w700
                                  )),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter pin code';
                                    }
                                    return null;
                                  },
                                ),
                              ),



                              SizedBox(width: 10),

                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'Mobile / Phone Number*',labelStyle: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w700
                                  )),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter mobile/phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          TextFormField(
                            decoration: InputDecoration(labelText: 'E-Mail*',labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700
                            )),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),


                          TextFormField(
                            decoration: InputDecoration(labelText: 'Address*', labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700
                            )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'Village / Town / City*',labelStyle: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w700
                                  )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter village/town/city';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'PinCode*',labelStyle: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w700
                                  )),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter pin code';
                                    }
                                    return null;
                                  },
                                ),
                              ),


                            ],
                          ),

                          Row(
                            children: [
                              Expanded(

                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'State*',labelStyle: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w700
                                  )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter state';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 100),
                              Expanded(

                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'Country*',labelStyle: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w700
                                  )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter country';
                                    }
                                    return null;
                                  },
                                ),
                              ),


                            ],
                          ),
                          SizedBox(height: 30,),

                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                    color: Color(0xff3C3B3B),
                                    thickness: 2,
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Contribution',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xffE20736),
                                      fontSize: 24),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                    color: Color(0xff3C3B3B),
                                    thickness: 2,
                                  ))
                            ],
                          ),



                          TextFormField(
                            decoration: InputDecoration(labelText: 'Enter Amount ',labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700
                            ),
                              hintText:'Enter Amount',hintStyle: TextStyle(
                                color: Colors.grey
                              ),

                            ),
                            keyboardType: TextInputType.number,
                          ),

                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('(or)', style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 24, color: Colors.orange.shade700),)
                            ],
                          ),
                          SizedBox(height: 20,),

                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                    color: Color(0xff3C3B3B),
                                    thickness: 2,
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Canteen Wise Contribution',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xffE20736),
                                      fontSize: 24),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                    color: Color(0xff3C3B3B),
                                    thickness: 2,
                                  ))
                            ],
                          ),





                          RadioListTile<String>(
                            title: const Text('State'),
                            value: 'State',
                            groupValue: _selectedState,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedState = value;
                              });
                            },
                          ),
                          if (_selectedState == 'State' ) ...[


                            TextFormField(
                              readOnly: true,
                              initialValue: '₹ 1,56,310/-',
                            ),
                            CheckboxListTile(
                              title: const Text('Lunch'),
                              value: _lunchSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  _lunchSelected = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: const Text('Dinner'),
                              value: _dinnerSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  _dinnerSelected = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: const Text('Preferred Canteen'),
                              value: _all,
                              onChanged: (bool? value) {
                                setState(() {
                                  _all = value!;
                                });
                              },
                            ),
                          ],





                          RadioListTile<String>(
                            title: const Text('Districts'),
                            value: 'Districts',
                            groupValue: _selectedState,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedState = value;
                              });
                            },
                          ),
                          if ( _selectedState == 'Districts') ...[
                            DropdownButtonFormField<String>(
                              hint: Text('Select Districts'),
                              value: _selectedDistrict,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedDistrict = newValue;
                                });
                              },
                              items: _districts.map((district) {
                                return DropdownMenuItem(
                                  child: Text(district),
                                  value: district,
                                );
                              }).toList(),
                              validator: (value) => value == null ? 'Please select a district' : null,
                            ),
                            CheckboxListTile(
                              title: const Text('Breakfast'),
                              value: _breakfastSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  _breakfastSelected = value!;
                                });
                              },
                            ),
                            TextFormField(
                              readOnly: true,
                              initialValue: '₹ 1,56,310/-',
                            ),
                            CheckboxListTile(
                              title: const Text('boryani'),
                              value: _lunch1Selected,
                              onChanged: (bool? value) {
                                setState(() {
                                  _lunch1Selected = value!;
                                });
                              },
                            ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [

                               Expanded(

                                 child:  CheckboxListTile(
                                 title: const Text('Dinner'),
                                 value: _dinnerSelected,
                                 onChanged: (bool? value) {
                                   setState(() {
                                     _dinnerSelected = value!;
                                   });
                                 },
                               ),
                               ),

                               Expanded(

                                   child: Text('dddd'))
                             ],
                           ),
                            CheckboxListTile(
                              title: const Text('Preferred Canteen'),
                              value: _all,
                              onChanged: (bool? value) {
                                setState(() {
                                  _all = value!;
                                });
                              },
                            ),
                          ],









                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Total Amount'),
                            readOnly: true,
                            initialValue: '₹ 1,56,310/-',
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Payment')),
                                  );
                                  // Process payment here
                                }
                              },
                              child: Text('Pay Now'),
                            ),
                          ),
                        ],
                      ),

                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }
}
