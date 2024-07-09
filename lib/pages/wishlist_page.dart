import 'package:flutter/material.dart';
import 'package:gbook_remake/pages/TabButtonView.dart';
import 'package:gbook_remake/utils/colors.dart';
import 'package:gbook_remake/utils/dimes.dart';
import 'package:gbook_remake/utils/images.dart';
import 'package:gbook_remake/utils/strings.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  String selectedText = kWishlist;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                        prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.black),
                            child: Icon(Icons.search)),
                        focusColor: kPrimaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        suffixIcon: IconTheme(
                            data: const IconThemeData(color: Colors.black),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 16,
                                width: 16,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  kBookImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        hintText: kSearch,
                        hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                      textAlign: TextAlign.start,
                      onChanged: (text) {

                      },
                    ),

                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: WishListTabBar(selectedText: selectedText, onTapEbookorAudio: (text)
              {
                setState(() {
                  selectedText = text;
                });
              }),
            )
          ],
        )
    );
  }
}

class WishListTabBar extends StatelessWidget {

  final String selectedText;
  final Function(String) onTapEbookorAudio;

  const WishListTabBar({super.key, required this.selectedText, required this.onTapEbookorAudio}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTabBarHeight,
      margin: const EdgeInsets.symmetric(horizontal: kMarginLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          /// Ebooks Button
          Expanded(child: TabButtonView(
            label: kWishlist,
            isSelected: selectedText == kWishlist,
            onTapButton: (){
              onTapEbookorAudio(kWishlist);
            }, fontSize: kTextRegular2x,
          ),
          ),

          /// Audiobooks Button
          Expanded(child: TabButtonView(
            label: kRecentlyBrowse,
            isSelected: selectedText == kRecentlyBrowse,
            onTapButton: (){
              onTapEbookorAudio(kRecentlyBrowse);
            }, fontSize: kTextRegular2x,
          ),
          )
        ],
      ),
    );
  }

}
