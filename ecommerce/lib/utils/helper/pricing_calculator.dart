import 'package:flutter/material.dart';

class TPricingCalculator{
  //--calculate price based on tax and shipping
  static double calculateTotalPrice(double productPrice , String location){
    double taxRate=getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice+ taxAmount+shippingCost;
    return totalPrice;
  }

  //calculate shipping cost
  static String calculateShippingCost(double productPrice, String location){
    double shippingCost=getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  //calculate tax
  static String calculateTax(double productPrice, String location){
    double taxRate=getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location){
    //check the tax rate for the given location from tax rate or API
    return 0.10; //EX
  }

  static double getShippingCost(String location){
    //check the shipping cost for the given location from tax rate or API
    return 5.00; //ex
  }

  //sum all cart values and return total amount 
  //static double calculateCarTotal(CartModel cart){
    //return cart.items.map((e)=>e.price).fold(0,(previousPrice,currentPrice)=>previousPrice+(currentPrice??0));
  //}


}