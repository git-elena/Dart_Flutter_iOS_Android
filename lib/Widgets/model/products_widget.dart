import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:house_client_application/Widgets/data/main_menu_items.dart';
import 'package:house_client_application/Widgets/data/product_data.dart';
import 'package:house_client_application/Widgets/model/main_menu_item.dart';
import 'package:http/http.dart' as http;



class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  bool opened = false;
  final List<Categories> categories = [];
  int currentCategory = 0;

  @override
  void initState() {

    super.initState();
    simpleFetchCategories();
  }
  simpleFetchCategories() async {


    final response = await http.Client()
        .get(Uri.parse('https://' + www_site_com + '/wp-json/wc/v3/products/categories?consumer_key=' + consumer_key + '&consumer_secret=' + consumer_secret));

    categories.addAll(parseCategories(response.body));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
        child: Scaffold(
          bottomNavigationBar:
          AnimatedContainer (
            color: Colors.red,
            height: opened ? 400 : 66,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastOutSlowIn,
            child: Center(
                          child: Column(
                            children: [
                              GestureDetector (
                                  onTap: () {
                                    setState((){
                                      opened = !opened;
                                    });
                                  },
                                  child: const Icon(Icons.keyboard_arrow_up, color: Colors.white,)
                              ),
                              const Text('Всi категорії', style: TextStyle(
                                  color: Colors.white, fontSize: 22),),
                             // BottomMenuWidget(),
                            ],
                          ),
                    ),

          ),


          floatingActionButton: ButtonBar(

            children: [Container(
                color: Colors.red,
                child: const Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: const Icon(Icons.shopping_cart, color: Colors.white,),
                ))],
          ),
            appBar: AppBar(
              title: const Text('Меню', style: TextStyle(color: Colors.red),),
              backgroundColor: Colors.white,
              leading:
              PopupMenuButton<MenuItem>(
                  icon: Icon(Icons.menu, color: Colors.red),


                  itemBuilder: (context) => [
                    ...MenuItems.itemFirst.map(buildItem).toList(),
                    PopupMenuDivider(),
                    ...MenuItems.itemSecond.map(buildItem).toList()
                  ]
              ),
              actions: <Widget>[
              IconButton(
                onPressed: () {

                }, icon: const Icon(Icons.share, color: Colors.red, )),

              ]
            ),
            body: Text('X'),//ListProducts(),
        )
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) =>
      PopupMenuItem(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(item.icon, color: Colors.red,),
            SizedBox(width: 10,),
            Text(item.text, )
          ],
        )
      );
}

class ListProducts extends StatefulWidget {
  ListProducts({Key? key,}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _ResultProductList();
}

class _ResultProductList extends State<ListProducts> {
  final int countPartLoading = 20;

  final List<Product> products = [];
  final List<Categories> categories = [];

  ScrollController _scrollController = ScrollController();
  int offset = 0;
  int currentCategory = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    simpleFetchProduct();
    categories.addAll( context.findAncestorStateOfType<_AllProductsState>()?.categories ?? []);
    currentCategory = context.findAncestorStateOfType<_AllProductsState>()?.currentCategory ?? 0;

    _scrollController.addListener(() {

      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        offset += countPartLoading;
        simpleFetchProduct();

      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  simpleFetchProduct() async {
    print(offset);
    if(offset < 0){ return; }
    final String url = 'https://www.hirosaki.store/wp-json/wc/v3/products?per_page=${countPartLoading}&offset=${offset}&consumer_key=ck_82e7d8baebb8499987fb34f8caba6e7f8f59d908&consumer_secret=cs_3a58342c5c5a39bd07e0a2a67a61691c81d1ed5a';
    final response = await http.Client()
        .get(Uri.parse(url));

    final ResultLoading parsed = parseProduct(response.body, (categories.isEmpty||currentCategory==0?0:categories[currentCategory].id));
    if(parsed.isEmptyLoad) {
      print('EMPTY list');
      offset = -1;
    } else {
      print('FULL: ${parsed.listProduct.length}');
      products.addAll(parsed.listProduct);
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    if(products.isEmpty || categories.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText1!,

        child: ListProductsWidget(scrollCont: _scrollController,)
    );
  }

}

class ListProductsWidget extends StatelessWidget {
  const ListProductsWidget({Key? key,
    required this.scrollCont
  }) : super(key: key);

  final ScrollController scrollCont;

  @override
  Widget build(BuildContext context) {
    List<Product> products = context.findAncestorStateOfType<_ResultProductList>()?.products ?? [];
    return

         ListView.separated(
            controller: scrollCont,
              separatorBuilder: (BuildContext context, int index) {

                return Container(
                  height: 1,
                  color: Colors.grey,
                );
              },
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {

                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        //Text("${index}"),

                        ImageProduct(url: products[index].photoSrc),

                        Text(products[index].name,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 10,),
                        Text(products[index].description.replaceAll("<p>", "").replaceAll("</p>", ""),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(products[index].price,
                              style: const TextStyle(
                                //height: 12,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,

                              ),

                            ),
                            Text(" грн / " + products[index].weight + " г"),
                          ],
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () {
                          },
                          child: Text('У кошик'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: Colors.amberAccent,
                            shadowColor: Colors.red,
                            elevation: 4,
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                );
              },

          );
  }



}

class ImageProduct extends StatelessWidget {
  const ImageProduct({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
      // Image.network(products[index].photoSrc))
    if (url.isEmpty) {
      return Image.network('https://www.hirosaki.store/wp-content/uploads/woocommerce-placeholder-300x300.png');
    } else {
      return Image.network(url);
    }
  }

}

class BottomMenuWidget extends StatelessWidget{

  const BottomMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    final List<Categories> categories = context.findAncestorStateOfType<_AllProductsState>()?.categories ?? [];
    final int currentCategory = context.findAncestorStateOfType<_AllProductsState>()?.currentCategory ?? 0;

    for(int i = 1; i < categories.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          //currentCategory = i;
        },
        child: Text(categories[i].name,
            style: TextStyle(
                fontSize: 18,
                color: currentCategory == i ? Colors.amber : Colors.white,
                height: 2)),
      ));
    }


    //final List<Product> list = parsed.map<Product>((json) => Product.fromJson(json)).toList();
    return Column(
      children: list,
    );
  }

}


