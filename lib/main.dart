import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const VidGenAIApp());

class VidGenAIApp extends StatelessWidget {
  const VidGenAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VidGenAI Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D12),
        primaryColor: const Color(0xFF7C3AED),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _promptController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  
  bool _isRendering = false;
  String _statusMessage = "Enter story prompt to render video.";
  String _selectedStyle = "Cinematic 4K";

  final List<String> styles = ["Cinematic 4K", "Anime Style", "Realistic", "3D Render"];

  Future<void> _handleGenerate() async {
    String serverUrl = _urlController.text.trim();
    if (serverUrl.isEmpty) {
      setState(() => _statusMessage = "પહેલાં ઉપર Server URL નાખો!");
      return;
    }
    if (_promptController.text.trim().isEmpty) return;

    if (!serverUrl.endsWith("/generate-video")) {
      serverUrl = "$serverUrl/generate-video";
    }

    setState(() {
      _isRendering = true;
      _statusMessage = "AI Rendering Engine ચાલુ છે...\nઓડિયો અને સીન્સ પ્રોસેસ થઈ રહ્યા છે.";
    });

    try {
      final res = await http.post(
        Uri.parse(serverUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "story_topic": _promptController.text,
          "style": _selectedStyle,
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          _statusMessage = "વિડિયો તૈયાર!\nલિંક: ${data['video_url']}";
        });
      } else {
        setState(() => _statusMessage = "સર્વર એરર! ફરી પ્રયાસ કરો.");
      }
    } catch (e) {
      setState(() => _statusMessage = "કનેક્શન ફેલ! URL સાચો છે કે નહીં તે ચેક કરો.");
    } finally {
      setState(() => _isRendering = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "VidGenAI Studio",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Server URL Input (તારે વારંવાર કોડિંગ ન કરવું પડે એટલા માટે)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF161622),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.5)),
              ),
              child: TextField(
                controller: _urlController,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: const InputDecoration(
                  icon: Icon(Icons.link, color: Color(0xFFC084FC), size: 20),
                  hintText: "Colab ngrok URL અહીં પેસ્ટ કરો",
                  hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Prompt Box
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF161622),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF27273A)),
              ),
              child: TextField(
                controller: _promptController,
                maxLines: 5,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: "અહીં ૪ મિનિટની સ્ટોરી અથવા સીન લખો...",
                  hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Visual Style Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: styles.map((style) {
                  final isSelected = _selectedStyle == style;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(style),
                      selected: isSelected,
                      onSelected: (val) => setState(() => _selectedStyle = style),
                      selectedColor: const Color(0xFF7C3AED),
                      backgroundColor: const Color(0xFF1E1E2D),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Generate Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isRendering ? null : _handleGenerate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isRendering
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Render 4-Min Video",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161622),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF27273A)),
              ),
              child: Text(
                _statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
