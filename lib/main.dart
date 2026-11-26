import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
​void main() {
WidgetsFlutterBinding.ensureInitialized();
runApp(const NoorAcademicReaderApp());
}
​class NoorAcademicReaderApp extends StatelessWidget {
const NoorAcademicReaderApp({super.key});
​@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'نور - القارئ الأكاديمي للمكفوفين',
debugShowCheckedModeBanner: false,
theme: ThemeData(
brightness: Brightness.dark,
scaffoldBackgroundColor: Colors.black,
primaryColor: const Color(0xFFFFD600),
colorScheme: const ColorScheme.dark(
primary: Color(0xFFFFD600),
onPrimary: Colors.black,
surface: Colors.black,
onSurface: Color(0xFFFFD600),
),
textTheme: const TextTheme(
headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFFD600)),
bodyLarge: TextStyle(fontSize: 22, height: 1.5, color: Colors.white),
),
),
home: const StartupGateScreen(),
);
}
}
​class StartupGateScreen extends StatefulWidget {
const StartupGateScreen({super.key});
​@override
State<StartupGateScreen> createState() => _StartupGateScreenState();
}
​class _StartupGateScreenState extends State<StartupGateScreen> {
bool _acceptedLegal = false;
​void _acceptAndProceed() {
HapticFeedback.heavyImpact();
setState(() {
_acceptedLegal = true;
});
}
​@override
Widget build(BuildContext context) {
return _acceptedLegal
? const AccessibleHomeScreen()
: LegalConsentScreen(onAccept: _acceptAndProceed);
}
}
​class LegalConsentScreen extends StatelessWidget {
final VoidCallback onAccept;
const LegalConsentScreen({super.key, required this.onAccept});
​final String _legalText =
'مرحباً بك في تطبيق نور، القارئ الأكاديمي الشامل للمكفوفين وضعاف البصر. '
'يعمل هذا التطبيق محلياً بالكامل داخل هاتفك دون إرسال أي ملفات أو أبحاث إلى خوادم خارجية، '
'حمايةً لخصوصيتك وملكيتك الفكرية وفق اللائحة الأوروبية GDPR. '
'يُستخدم التطبيق للأغراض الشخصية والتعليمية والبحثية وفق معاهدة مراكش الدولية، '
'وهو مرخص بموجب رخصة Apache 2.0 مفتوحة المصدر. اضغط على الزر الأصفر الكبير في الأسفل للموافقة والبدء.';
​@override
Widget build(BuildContext context) {
return Directionality(
textDirection: TextDirection.rtl,
child: Scaffold(
appBar: AppBar(
title: const Text('الإقرار القانوني والخصوصية', style: TextStyle(color: Color(0xFFFFD600))),
backgroundColor: Colors.black,
),
body: Padding(
padding: const EdgeInsets.all(20.0),
child: Column(
children: [
Expanded(
child: SingleChildScrollView(
child: Semantics(
liveRegion: true,
label: 'نص الإقرار القانوني ومعاهدة مراكش وسياسة الخصوصية: $_legalText',
child: Text(_legalText, style: Theme.of(context).textTheme.bodyLarge),
),
),
),
const SizedBox(height: 16),
SizedBox(
width: double.infinity,
height: 75,
child: ElevatedButton.icon(
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFFFD600),
foregroundColor: Colors.black,
),
onPressed: onAccept,
icon: const Icon(Icons.check_circle, size: 32),
label: const Text('أوافق وأبدأ الاستخدام', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
),
),
],
),
),
),
);
}
}
​class AccessibleHomeScreen extends StatelessWidget {
const AccessibleHomeScreen({super.key});
​void _handleAction(BuildContext context, String title, String description) {
HapticFeedback.mediumImpact();
ScaffoldMessenger.of(context).clearSnackBars();
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
backgroundColor: const Color(0xFFFFD600),
duration: const Duration(seconds: 4),
content: Semantics(
liveRegion: true,
child: Text(
'$title:$description',
style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
),
),
),
);
}
​@override
Widget build(BuildContext context) {
return Directionality(
textDirection: TextDirection.rtl,
child: Scaffold(
appBar: AppBar(
title: const Text('نور الأكاديمي', style: TextStyle(color: Color(0xFFFFD600), fontWeight: FontWeight.bold)),
backgroundColor: Colors.black,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
children: [
_buildBigAccessibleTile(
icon: Icons.menu_book,
title: '1. قراءة الكتب والملفات الضخمة',
subtitle: 'قراءة متدفقة لملفات PDF و EPUB بأكثر من 500 صفحة',
onTap: () => _handleAction(context, 'قراءة الكتب والملفات الضخمة', 'هذه الوحدة جاهزة للربط في المرحلة الثانية.'),
),
const SizedBox(height: 14),
_buildBigAccessibleTile(
icon: Icons.document_scanner,
title: '2. تصوير مستند وتحويله إلى Word',
subtitle: 'توجيه صوتي للكاميرا واستخراج النصوص محلياً بدون إنترنت',
onTap: () => _handleAction(context, 'تصوير مستند وتحويله إلى وورد', 'هذه الوحدة جاهزة للربط في المرحلة الثالثة.'),
),
const SizedBox(height: 14),
_buildBigAccessibleTile(
icon: Icons.auto_awesome_mosaic,
title: '3. المنسق الأكاديمي والعروض التقديمية',
subtitle: 'تنسيق الأبحاث وإعداد شرائح PowerPoint بإشراف صوتي',
onTap: () => _handleAction(context, 'المنسق الأكاديمي وصانع العروض', 'هذه الوحدة جاهزة للربط في المرحلة الرابعة.'),
),
const SizedBox(height: 14),
_buildBigAccessibleTile(
icon: Icons.travel_explore,
title: '4. البحث العلمي الموثق بالمراجع',
subtitle: 'جلب الأبحاث الحقيقية وتوثيق المراجع بصيغ APA و IEEE',
onTap: () => _handleAction(context, 'البحث العلمي الموثق بالمراجع', 'هذه الوحدة جاهزة للربط في المرحلة الخامسة.'),
),
],
),
),
),
);
}
​Widget _buildBigAccessibleTile({
required IconData icon,
required String title,
required String subtitle,
required VoidCallback onTap,
}) {
return Expanded(
child: Semantics(
button: true,
label: '$title.$subtitle',
child: InkWell(
onTap: onTap,
child: Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
decoration: BoxDecoration(
color: const Color(0xFF141414),
border: Border.all(color: const Color(0xFFFFD600), width: 2.5),
borderRadius: BorderRadius.circular(14),
),
child: Row(
children: [
Icon(icon, size: 42, color: const Color(0xFFFFD600)),
const SizedBox(width: 16),
Expanded(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFD600))),
const SizedBox(height: 4),
Text(subtitle, style: const TextStyle(fontSize: 15, color: Colors.white)),
],
),
),
],
),
),
),
),
);
}
}
