import 'package:veggie_seasons_v2/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.tabController.index;
    widget.tabController.addListener(_handleTabChanged);
  }

  void _handleTabChanged() {
    setState(() {
      selectedIndex = widget.tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tabController.index);
    const List<IconData> icons = [
      FontAwesomeIcons.house,
      FontAwesomeIcons.list,
      FontAwesomeIcons.magnifyingGlass,
      FontAwesomeIcons.solidUser,
    ];

    double containerW = 46;
    double iconContainerW = containerW / 2;
    double iconSize = 22;
    double totalWidth = MediaQuery.of(context).size.width;

    return Container(
      color: $styles.colors.white,
      child: SafeArea(
        child: Container(
          height: containerW,
          width: double.infinity,
          decoration: BoxDecoration(
            color: $styles.colors.white,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                ),
                child: AnimatedSlide(
                  offset: Offset(
                    ((((totalWidth -
                                        (2 *
                                            ($styles.padding.xl +
                                                iconContainerW))) /
                                    3) *
                                selectedIndex) +
                            $styles.padding.xl) /
                        containerW,
                    $styles.padding.s / containerW,
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubicEmphasized,
                  child: Container(
                    height: containerW,
                    width: containerW,
                    decoration: $styles.containerStyles.circular.copyWith(
                      color: $styles.colors.winter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: $styles.padding.xl + iconContainerW / 2,
                  right: $styles.padding.xl + iconContainerW / 2,
                  top: $styles.padding.s + iconContainerW / 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: icons.map((icon) {
                    return SizedBox(
                      width: iconContainerW,
                      height: iconContainerW,
                      child: Center(
                        child: FaIcon(
                          size: iconSize,
                          icon,
                          color: $styles.colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: icons.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          widget.tabController.animateTo(index);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Unsure how to do this -- need to think a little
// @widgetbook.UseCase(
//   name: 'Bottom Navigation Bar',
//   type: CustomNavigationBar,
// )
// Widget buttonUseCase(BuildContext context) {
//   return CustomNavigationBar(
//       tabController: TabController(
//     length: 4,
//     vsync: this,
//     initialIndex: 0,
//   ));
// }
