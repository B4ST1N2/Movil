void main(){

  List<Map<String,dynamic>> store = [
    {"product":"milk",'value':5000,'discount':1000 ,'IVA': 0.2 },
    {"product":"eggs",'value':10000,'discount':2000 ,'IVA': 0.3 },
    {"product":"sausages",'value':3000,'discount':500 ,'IVA': 0.2 },
    {"product":"bread",'value':2000,'discount':200 ,'IVA': 0.1 },
    {"product":"tv",'value':60000,'discount':4500 ,'IVA': 0.2 },
  ];
  finalPrice(store);
}

void finalPrice(list){
  double finalPriceProduct=0;
  for(final element in list){
    finalPriceProduct = (element['value'] - element['discount']) + (element['value']*element['IVA']);
    print('El precio final para el producto ${element["product"]} es de: ${finalPriceProduct}');
  }

}