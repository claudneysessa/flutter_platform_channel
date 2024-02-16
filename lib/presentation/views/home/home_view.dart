import 'package:flutter/material.dart';
import 'package:flutter_channel/presentation/views/home/constants/home_menu_itenslist.dart';

import '../../../commons/components/custom_appbar.dart';
import '../../../commons/components/custom_footer.dart';
import '../../../commons/style/application_colors.dart';
import 'components/home_menu_card.dart';
import 'home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Flutter Platform Channels',
        subtitle: 'Comunicação com Android Nativo',
        toolbarHeight: 107,
        centerTitle: true,
      ),
      backgroundColor: ApplicationColors().primaryColor,
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: ApplicationColors().background[10],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: homeMenuItensList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 10),
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return HomeMenuCard(
                      title: homeMenuItensList[index]['title'],
                      subtitle: homeMenuItensList[index]['subtitle'],
                      icon: homeMenuItensList[index]['icon'],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          homeMenuItensList[index]['route'],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            CustomFooter(
              title: 'Desenvolvido por:',
              subtitle: 'Claudney Sarti Sessa',
            ),
          ],
        ),
      ),
    );
  }
}
