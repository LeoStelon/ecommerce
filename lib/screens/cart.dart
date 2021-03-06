import 'dart:convert';

import 'package:ecommerce/constant/colors.dart';
import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _cartScaffoldKey =
      new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  bool isCartEmpty = false;
  double deliveryCharge = 20;
  double taxAndFess = 0;
  double grandTotal;
  double subTotal;
  double discount;
  List cartProducts;
  bool updateItem = false;

  //All products are fetched here
  Future getCartDetails() async {
    //Get all products from DB
    print('start');
    var response = await CartProvider().getAllProducts();
    final Map<String, dynamic> responseBody = await json.decode(response.body);
    print(responseBody);
    if (responseBody['data'].runtimeType == List) {
      return setState(() {
        isCartEmpty = true;
        isLoading = false;
      });
    }
    if (responseBody['data']['products'].length == 0) {
      setState(() {
        isCartEmpty = true;
      });
    }
    setState(() {
      subTotal = responseBody['data']['get_cart_sub_total'];
      deliveryCharge = responseBody['data']['deliveryCharges'];
      cartProducts = responseBody['data']['products'];
    });
    setState(() {
      grandTotal = subTotal + deliveryCharge + taxAndFess;
    });
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        isLoading = false;
      });
    });
    print('end');
  }

  @override
  void initState() {
    super.initState();
    getCartDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _cartScaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "My Order",
          style: TextStyle(
            color: ThemeColors.blueColor,
            fontSize: 2.7 * SizeConfig.textMultiplier,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : isCartEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        // height: MediaQuery.of(context).size.height / 0.4,
                        child: Image.asset("images/s5.jpeg"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Your cart is empty!",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        //Sub total
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Card(
                            elevation: 3.0,
                            color: Color.fromRGBO(249, 249, 249, 1),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Sub Total",
                                          style: TextStyle(
                                            fontSize:
                                                2.9 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Rs. " + subTotal.toString(),
                                          style: TextStyle(
                                            fontSize:
                                                2.9 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Delivery",
                                          style: TextStyle(
                                            fontSize:
                                                3.0 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "+ Rs. " + deliveryCharge.toString(),
                                          style: TextStyle(
                                            fontSize:
                                                3.0 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 30.0,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                            fontSize:
                                                3.1 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Rs. " + grandTotal.toString(),
                                          style: TextStyle(
                                            fontSize:
                                                3.1 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        //List of all products
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Card(
                            elevation: 3.0,
                            color: Color.fromRGBO(249, 249, 249, 1),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              child: Column(
                                children: cartProducts
                                    //Cart Card Component
                                    .map((product) => Container(
                                          // color: Colors.orange,
                                          margin: EdgeInsets.only(bottom: 20.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.23,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.23,
                                                  child: Image.network(
                                                    product["product_images"],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.0,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        product["product_name"],
                                                        style: TextStyle(
                                                          fontSize: 2.7 *
                                                              SizeConfig
                                                                  .textMultiplier,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5.0,
                                                          bottom: 5.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            product["product_quantity"]
                                                                    .toString() +
                                                                " × Rs. " +
                                                                product["product_price"]
                                                                    .toString(),
                                                            style: TextStyle(
                                                              color: ThemeColors
                                                                  .blueColor,
                                                              fontSize: 2.5 *
                                                                  SizeConfig
                                                                      .textMultiplier,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                      //color: Colors.deepOrange,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            //margin: EdgeInsets.only(right: 5.0),
                                                            height: 37.0,
                                                            //width: 110.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: ThemeColors
                                                                      .blueColor,
                                                                  width: 1),
                                                            ),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: ThemeColors
                                                                        .blueColor,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      updateItem =
                                                                          true;
                                                                    });
                                                                    //Decrement product
                                                                    await CartProvider()
                                                                        .decrementProduct(
                                                                      product[
                                                                          "product_id"],
                                                                    );
                                                                    await getCartDetails();
                                                                    setState(
                                                                        () {
                                                                      updateItem =
                                                                          false;
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  product["product_quantity"]
                                                                      .toString(),
                                                                ),
                                                                IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: ThemeColors
                                                                        .blueColor,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      updateItem =
                                                                          true;
                                                                    });
                                                                    //Increment product
                                                                    await CartProvider()
                                                                        .incrementProduct(
                                                                      product[
                                                                          "product_id"],
                                                                    );
                                                                    await getCartDetails();
                                                                    setState(
                                                                        () {
                                                                      updateItem =
                                                                          false;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              "Rs. " +
                                                                  product["get_product_total"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                color: ThemeColors
                                                                    .blueColor,
                                                                fontSize: 2.5 *
                                                                    SizeConfig
                                                                        .textMultiplier,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      //Check Out Button
      bottomNavigationBar: isLoading || isCartEmpty
          ? null
          : Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                padding: EdgeInsets.symmetric(vertical: 12.0),
                onPressed: () {
                  Navigator.pushNamed(context, "/checkout");
                },
                color: ThemeColors.blueColor,
                textColor: Colors.grey[100],
                child: Text(
                  updateItem == true ? "Updating Cart" : "Checkout",
                  style: TextStyle(
                    fontSize: 2.7 * SizeConfig.textMultiplier,
                  ),
                ),
              ),
            ),
    );
  }
}
