import 'package:ecommerce/constant/colors.dart';
import 'package:ecommerce/constant/images.dart';
import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';

class HomePageTrendingProducts extends StatefulWidget {
  List trendingProductsList;
  GlobalKey<ScaffoldState> _scaffoldKey;
  HomePageTrendingProducts(this.trendingProductsList, this._scaffoldKey);
  @override
  _HomePageTrendingProductsState createState() =>
      _HomePageTrendingProductsState();
}

class _HomePageTrendingProductsState extends State<HomePageTrendingProducts> {
  String productNameTemp;
  int productEffPriceTemp;
  int productMRPriceTemp;
  String productImgTemp;

  double processProductEFFPrice(mrp, discount) {
    double MRP = mrp;
    double DISCOUNT = discount;
    int EFF_PRICE = MRP.toInt() - DISCOUNT.toInt();
    return EFF_PRICE.toDouble();
  }

  addToCart(String productId) async {
    CartProvider().addFirstProduct(productId);
    widget._scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Product has been added to cart'),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20, left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Trending this Week",
                  style: TextStyle(
                    fontSize: 2.4 * SizeConfig.textMultiplier,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            alignment: Alignment.center,
            margin:
                EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.trendingProductsList
                  .map(
                    (productData) => Container(
                      width: 180,
                      margin: EdgeInsets.only(right: 10.0),
                      child: Card(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(0.0)),
                        child: Container(
                          //color: Colors.red,
                          padding:
                              EdgeInsets.only(left: 25, right: 25, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                Images.homePageMalaiPaneer,
                                width: 80,
                              ),
                              Container(
                                //color: Colors.red,
                                margin: EdgeInsets.only(
                                  top: 3,
                                ),
                                child: Text(
                                  StringUtils.capitalize(
                                          productData["product_name"])
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 2.3 * SizeConfig.textMultiplier,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 3,
                                  bottom: 2,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 3.0, bottom: 1.0),
                                      child: productData["discount"] != 0.0 &&
                                              productData["discount"] != null
                                          ? Flexible(
                                              child: Text(
                                                "₹" +
                                                    processProductEFFPrice(
                                                            productData[
                                                                "product_price"],
                                                            productData[
                                                                "discount"])
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 1.8 *
                                                      SizeConfig.textMultiplier,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 3.0, bottom: 1.0),
                                      child: productData["discount"] != 0.0 &&
                                              productData["discount"] != null
                                          ? Text(
                                              "₹" +
                                                  productData["product_price"]
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 2.0 *
                                                      SizeConfig.textMultiplier,
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              "₹" +
                                                  productData["product_price"]
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 2.0 *
                                                    SizeConfig.textMultiplier,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: SizedBox(
                                  width: 80,
                                  height: 25,
                                  child: OutlineButton(
                                    textColor: ThemeColors.blueColor,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    highlightedBorderColor:
                                        ThemeColors.blueColor,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    onPressed: () {
                                      addToCart(productData["product_id"]);
                                    },
                                    child: Text("+ Add"),
                                    borderSide: BorderSide(
                                        color: ThemeColors.blueColor, width: 2),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
