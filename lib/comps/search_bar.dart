import 'package:flutter/material.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {

  bool isDark = false ;
  @override
  Widget build(BuildContext context) {


    return  SearchAnchor(
      isFullScreen: true,
      
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
             // backgroundColor: const MaterialStatePropertyAll(Colors.white),
              elevation: const MaterialStatePropertyAll(4),
              hintText: "Search Minimoon",
              hintStyle: MaterialStatePropertyAll(TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary.withAlpha(150))),
              surfaceTintColor: const MaterialStatePropertyAll(Colors.white),
              
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0,vertical: 0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                Tooltip(
                  message: 'Change brightness mode',
                  child: IconButton(
                   isSelected: isDark,
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                    icon:  Icon(Icons.category_rounded,color: Theme.of(context).colorScheme.primary,),
                    selectedIcon: const Icon(Icons.brightness_2_outlined),
                  ),
                )
              ],
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          });
  }
}