import 'package:flutter/material.dart';
import 'package:flutter_channel/commons/components/custom_appbar.dart';
import 'package:flutter_channel/presentation/views/method_channel/method_channel_arguments/method_channel_arguments_view.dart';
import 'package:flutter_channel/presentation/views/method_channel/method_channel_simple/method_channel_simple_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../commons/style/application_colors.dart';

class MethodChannelView extends StatefulWidget {
  const MethodChannelView({super.key});

  @override
  MethodChannelViewState createState() => MethodChannelViewState();
}

class MethodChannelViewState extends State<MethodChannelView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController =
      PageController(); // Adicione um PageController

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(
        _handleTabChange); // Adicione um listener para capturar mudanças de aba
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Descarte o TabController para evitar vazamentos de memória
    super.dispose();
  }

  void _handleTabChange() {
    _pageController.jumpToPage(_tabController
        .index); // Altere a página do PageView de acordo com a aba selecionada
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Method Channel',
          toolbarHeight: 60,
          centerTitle: true,
          bottom: TabBar(
            labelColor: ApplicationColors().branco,
            labelStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            dividerColor: ApplicationColors().primaryColor,
            indicatorWeight: 1,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.all(0),
            automaticIndicatorColorAdjustment: false,
            overlayColor:
                MaterialStateProperty.all(ApplicationColors().primaryColor),
            tabAlignment: TabAlignment.fill,
            unselectedLabelColor: ApplicationColors().branco.withAlpha(150),
            indicatorColor: ApplicationColors().branco,
            tabs: [
              Tab(
                child: Text(
                  'Method Channel Simple',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Method Channel Arguments',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: ApplicationColors().background[10],
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            FadeTransition(
              opacity: AlwaysStoppedAnimation(1),
              child: MethodChannelSimpleView(),
            ),
            FadeTransition(
              opacity: AlwaysStoppedAnimation(1),
              child: MethodChannelArgumentsView(),
            ),
          ],
        ),
      ),
    );
  }
}
