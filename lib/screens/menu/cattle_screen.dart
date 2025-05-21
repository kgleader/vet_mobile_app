import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/widgets/painters/decorative_ring_painter.dart'; // Import the new painter

class CattleScreen extends StatelessWidget {
  const CattleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Бодо мал";
    final Color figmaGreen = const Color(0xFF38A169);
    final String bannerImagePath = "assets/images/bodomal_banner.png";

    final List<TopicListItemModel> cattleTopics = [
      TopicListItemModel(
        id: 'cattle_feeding',
        imagePath: 'assets/icons/menu/grass.svg',
        title: 'Тоюттануусу',
        description: 'Бодо малды туура тоюттандыруу боюнча маалымат.',
        fullDescription: 'Бодо малды тоюттандыруу – бул жогорку продуктуулуктун жана ден соолуктун негизи. Бул бөлүмдө бодо малдын ар кандай топтору (саан уйлар, бордогуч мал, торпоктор) үчүн тоюттандыруунун илимий негизделген нормалары, рацион түзүү эрежелери, негизги тоют түрлөрү (көк чөп, силос, сенаж, концентраттар, минералдык кошумчалар), алардын аш болумдуулугу жана сапатына койгон талаптар жөнүндө кеңири маалымат берилет. Ошондой эле, тоюттандыруудагы катачылыктардын кесепеттери жана аларды алдын алуу жолдору каралат.'
      ),
      TopicListItemModel(
        id: 'cattle_diseases',
        imagePath: 'assets/icons/menu/vaccines.svg',
        title: 'Ооруусу',
        description: 'Бодо малдын негизги оорулары жана алардын алдын алуу.',
        fullDescription: 'Бодо малдын ден соолугун сактоо – мал чарбасынын маанилүү милдети. Бул жерде бодо малдын кеңири таралган жугуштуу (шарп, кутурма, карасан ж.б.) жана жугушсуз (кеттоз, мастит, ашказан-ичеги оорулары) оорулары, алардын негизги клиникалык белгилери, диагностикалоо ыкмалары, заманбап дарылоо жолдору жана алдын алуу боюнча комплекстүү чаралар (вакцинация, дезинфекция, карантин) тууралуу маалыматтар келтирилген.'
      ),
      TopicListItemModel(
        id: 'cattle_insemination',
        imagePath: 'assets/icons/menu/male.svg',
        title: 'Уруктандыруу',
        description: 'Бодо малды уруктандыруу ыкмалары.',
        fullDescription: 'Бодо малды уруктандыруу – бул тукум алуунун жана малдын санын көбөйтүүнүн негизги жолу. Бул бөлүмдө бодо малды табигый жана жасалма уруктандыруу ыкмалары, алардын артыкчылыктары жана кемчиликтери талкууланат. Уйлардын кунаажынга келүү белгилери, уруктандыруу үчүн оптималдуу убакытты аныктоо, уруктун сапатына койгон талаптар жана уруктандыруу техникасы боюнча практикалык кеңештер берилет. Ошондой эле, тукумдук ишти жакшыртуу жана мал чарбасынын натыйжалуулугун жогорулатуу маселелери каралат.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // Figma uses a bolder weight
            fontSize: 18, // Matches Figma
          ),
        ),
        backgroundColor: const Color(0xFFF3F0EB), // Matches Figma background
        elevation: 0,
        leading: IconButton(
          // Use a more standard back icon that matches Figma better
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black), 
          onPressed: () => GoRouter.of(context).go(RouteNames.menu), // Navigate to menu screen by path
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Matches Figma padding
            child: CircleAvatar(
              backgroundColor: figmaGreen, // Matches Figma
              radius: 18, // Matches Figma
              // Replace with SvgPicture for the custom logo from Figma
              child: SvgPicture.asset(
                'assets/icons/common/cattle_logo.svg', // Assuming this is the path to your SVG logo
                width: 20, // Adjust size as needed
                height: 20, // Adjust size as needed
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF3F0EB), // Matches Figma background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Adjusted spacing
            SizedBox(
              width: 327, // Figma specified width
              height: 327, // Figma specified height
              child: CustomPaint(
                painter: DecorativeRingPainter(
                  baseColor: figmaGreen,
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      bannerImagePath,
                      fit: BoxFit.cover,
                      width: 160, // Approx image size from Figma
                      height: 160, // Approx image size from Figma
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), // Adjusted spacing

            _buildNavigationButton(context, cattleTopics[0], false, figmaGreen), 
            const SizedBox(height: 16), // Matches Figma spacing
            _buildNavigationButton(context, cattleTopics[1], true, figmaGreen), // Highlighted button
            const SizedBox(height: 16), // Matches Figma spacing
            _buildNavigationButton(context, cattleTopics[2], false, figmaGreen),
            const Spacer(), // Pushes buttons up if content is not enough to fill screen
          ],
        ),
      ),
      // Add BottomNavigationBar to match Figma
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home', // Replace with actual labels or leave empty if only icons
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0, // Set the current index for the 'Home' tab or relevant tab for this screen
        selectedItemColor: figmaGreen, // Color for selected icon and label
        unselectedItemColor: Colors.grey, // Color for unselected icons and labels
        showSelectedLabels: false, // As per Figma, labels might not be shown
        showUnselectedLabels: false, // As per Figma, labels might not be shown
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        backgroundColor: Colors.white, // Background color of the bottom bar
        elevation: 8.0, // Add some elevation if needed
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, TopicListItemModel topic, bool isHighlighted, Color highlightColor) {
    final Color buttonColor = isHighlighted ? highlightColor : Colors.white;
    final Color textColor = isHighlighted ? Colors.white : Colors.black87; // Slightly less intense black for text
    final Color iconColor = isHighlighted ? Colors.white : highlightColor;
    final BorderSide borderSide = isHighlighted ? BorderSide.none : BorderSide(color: highlightColor.withOpacity(0.5), width: 1.5); // Lighter border for non-highlighted

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        side: borderSide,
        elevation: isHighlighted ? 4 : 2, // Adjusted elevation for more depth
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24), // Increased padding for a taller button
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // More rounded corners as in Figma
        minimumSize: const Size(double.infinity, 60), // Increased height
      ),
      onPressed: () {
        GoRouter.of(context).pushNamed(
          RouteNames.topicDetail,
          extra: {'topic': topic, 'currentIndex': 0},
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            topic.imagePath,
            width: 24, // Slightly larger icon
            height: 24, // Slightly larger icon
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          Text(
            topic.title,
            style: TextStyle(
              fontSize: 16, // Consistent with Figma
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500, // Matches Figma
            ),
          ),
        ],
      ),
    );
  }
}
