import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const VidGenAIApp());
}

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
      setState(() => _statusMessage = "Please enter Server URL first!");
      return;
    }
    if (_promptController.text.trim().isEmpty) return;

    if (!serverUrl.endsWith("/generate-video")) {
      serverUrl = "$serverUrl/generate-video";
    }

    setState(() {
      _isRendering = true;
      _statusMessage = "AI Rendering Engine active...\nProcessing scenes and voiceover.";
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
          _statusMessage = "Video Ready!\nLink: ${data['video_url']}";
        });
      } else {
        setState(() => _statusMessage = "Server error! Try again.");
      }
    } catch (e) {
      setState(() => _statusMessage = "Connection failed! Check Colab ngrok URL.");
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
                  hintText: "Paste Colab ngrok URL here",
                  hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                  hintText: "Enter scene storyline, characters and prompt...",
                  hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
