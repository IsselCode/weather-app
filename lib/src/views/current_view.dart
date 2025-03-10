import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CurrentView extends StatelessWidget {
  const CurrentView({super.key});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on_outlined, size: 24,),
            const Gap(5),
            Text("Monterrey, México", style: textTheme.titleMedium,)
          ],
        ),
        actions: [
          // Lenguaje
          IconButton(
            onPressed: () => setLanguage(context),
            icon: Icon(Icons.language_outlined, size: 24,)
          ),
          IconButton(
            onPressed: () => setLocation(context),
            icon: Icon(Icons.search_outlined, size: 24,)
          )
        ],
      ),
      body: Text("Monterrey, México"),
    );
  }

  void setLanguage(BuildContext context) {



  }

  void setLocation(BuildContext context) {

  }

}
