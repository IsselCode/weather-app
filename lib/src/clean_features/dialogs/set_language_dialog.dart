import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/core/app/consts.dart';
import 'package:weather_app/core/app/enums.dart';

class SetLanguageDialog extends StatefulWidget {
  const SetLanguageDialog({super.key});

  @override
  State<SetLanguageDialog> createState() => _SetLanguageDialogState();
}

class _SetLanguageDialogState extends State<SetLanguageDialog> {

  final PageController _pageController = PageController(viewportFraction: 0.45);
  LanguageTypes selectedLanguage = LanguageTypes.es;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    LanguageTypes selectedLanguageController = LanguageTypes.pt;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      while (selectedLanguage != selectedLanguageController) {
        await _pageController.animateToPage(
          _selectedIndex + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut
        );
      }
    },);


  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 150,
        width: 200,
        child: Column(
          children: [
            // PageView para los idiomas
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: LanguageTypes.values.length,
                onPageChanged: (index) {

                  _selectedIndex += 1;
                  selectedLanguage = LanguageTypes.values[index];

                  setState(() {});

                },
                itemBuilder: (context, index) {

                  final language = LanguageTypes.values[index];
                  final bool isSelected = language == selectedLanguage;

                  return Center(
                    child: AnimatedContainer(
                      height: 50,
                      duration: Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : AppColors.neutralGrey,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text(
                          language.fullName,
                          style: TextStyle(
                            fontSize: isSelected ? 18 : 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black
                          ),
                        )
                      ),
                    ),
                  );
                },
              )
            ),
            // Botón para seleccionar el idioma
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, selectedLanguage),
                  child: Text("Seleccionar")
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
