import 'package:flutter/material.dart';

import 'package:disenos/widgets/background.dart';
import 'package:disenos/widgets/card_table.dart';
import 'package:disenos/widgets/custom_bottom_navigation.dart';
import 'package:disenos/widgets/page_title.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // widfet ecima de otros stack
        children: [
          // Background
          Background(),
          // Home Body
          _HomeBody(),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigation(), // appbar arriba y esto abajp
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // si child mas grande que las dimensiones ma va permite ami hacer scroll
    return SingleChildScrollView(
      // scroll puede ser que movil sea peqeuño o tenemosmas cards
      child: Column(
        children: [
          // Titulos
          PageTitle(),

          // Card Table
          CardTable(),
        ],
      ),
    );
  }
}
