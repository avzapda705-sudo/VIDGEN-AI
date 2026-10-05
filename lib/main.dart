import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const VidGenAIApp());
}

class VidGenAIApp extends StatelessWidget {
  const VidGenAIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VidGenAI Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A12),
        primaryColor: const Color(0xFF6C5CE7),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isGenerating = false;
  String _selectedRatio = "16:9";
  String _selectedStyle = "Cinematic 4K";
  String _statusMessage = "Enter your story prompt to create AI video";

  final String apiUrl = "https://your-api-url.ngrok-free.app/generate-video";

  Future<void> _startGeneration() async {
    if (_promptController.text.trim().isEmpty) return;

    setState(() {
      _isGenerating = true;
      _statusMessage = "AI Rendering Engine started...\nProcessing voiceover, scenes and visual effects.";
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "story_topic": _promptController.text,
          "aspect_ratio": _selectedRatio,
          "style": _selectedStyle,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _statusMessage = "Video Created Successfully!\nURL: ${data['video_url']}";
        });
      } else {
        setState(() {
          _statusMessage = "Generation Failed! Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Backend Server Offline!\nCheck Colab ngrok tunnel.";
      });
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0C29),
              Color(0xFF302B63),
              Color(0xFF24243E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C5CE7).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFF6C5CE7), width: 1.5),
                          ),
                          child: const Icon(Icons.auto_awesome, color: Color(0xFFA29BFE), size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "VidGenAI",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              "Cinematic AI Studio",
                              style: TextStyle(fontSize: 12, color: Colors.white54),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),Ekdam ultra-premium, modern dark aesthetic ane sleek studio look satheno Flutter UI code niche mujab chhe. Aama glassmorphism containers, neon purple/violet gradient styling, character selection chips, ane stylish status progress card mukelu chhe.

---

### Step: `lib/main.dart` File Update Karo

GitHub par **Code** tab ma jaaine `lib/main.dart` file open karo ane aakho code badline aa premium code paste kari do:

```dart
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
  bool _isRendering = false;
  String _statusMessage = "Prompt type karo ane high-definition 4K video create karo.";
  String _selectedStyle = "Cinematic 4K";
  String _selectedVoice = "Narrator (AI)";

  final List<String> styles = ["Cinematic 4K", "Anime Style", "Realistic", "3D Render"];
  final List<String> voices = ["Narrator (AI)", "Male (Deep)", "Female (Clear)"];

  // Backend ngrok URL ahi set karvo
  final String backendUrl = "[https://your-api-url.ngrok-free.app/generate-video](https://your-api-url.ngrok-free.app/generate-video)";

  Future<void> _handleGenerate() async {
    if (_promptController.text.trim().isEmpty) return;

    setState(() {
      _isRendering = true;
      _statusMessage = "AI pipeline active: Voice sync ane 4-minute visuals render thai rahya chhe...";
    });

    try {
      final res = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "story_topic": _promptController.text,
          "style": _selectedStyle,
          "voice": _selectedVoice,
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          _statusMessage = "Video Ready! File Link:\n${data['video_url']}";
        });
      } else {
        setState(() {
          _statusMessage = "Server error! Request process nathi thai saki.";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Connection failed! Server link check karo.";
      });
    } finally {
      setState(() {
        _isRendering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFFC084FC)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              "VidGenAI",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Tagline Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF7C3AED).withOpacity(0.15),
                    const Color(0xFF1E1B4B).withOpacity(0.4),
                  ],
                ),
                border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.movie_creation_outlined, color: Color(0xFFC084FC), size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Multi-Scene 4 Min AI Video & Dynamic Voice Studio",
                      style: TextStyle(fontSize: 13, color: Color(0xFFE2E8F0), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Prompt Box Header
            const Text(
              "STORYLINE & CHARACTERS",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8), letterSpacing: 1),
            ),
            const SizedBox(height: 8),

            // Premium Text Field Card
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
                  hintText: "Enter your full scene details, characters and dialogue flow...",
                  hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Style Selector Chips
            const Text(
              "VISUAL STYLE",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8), letterSpacing: 1),
            ),
            const SizedBox(height: 8),
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
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isRendering ? null : _handleGenerate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  elevation: 6,
                  shadowColor: const Color(0xFF7C3AED).withOpacity(0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: _isRendering
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Render 4-Min Video",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Output / Progress Display Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161622),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF27273A)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.terminal, color: Color(0xFFC084FC), size: 18),
                      SizedBox(width: 8),
                      Text(
                        "STUDIO OUTPUT MONITOR",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFF27273A), height: 20),
                  Text(
                    _statusMessage,
                    style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
