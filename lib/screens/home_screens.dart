import 'package:flutter/material.dart';

void main() {
  runApp(const FredReondApp());
}

class FredReondApp extends StatelessWidget {
  const FredReondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEMONS REPOND',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          brightness: Brightness.light,
          primary: const Color(0xFF6C5CE7),
          secondary: const Color(0xFF00CEFF),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          floatingLabelStyle: const TextStyle(
            color: Color(0xFF6C5CE7),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C5CE7),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          margin: EdgeInsets.zero,
          surfaceTintColor: Colors.white,
        ),
      ),
      home: const FredReondScreen(),
    );
  }
}

class FredReondScreen extends StatefulWidget {
  const FredReondScreen({super.key});

  @override
  State<FredReondScreen> createState() => _FredReondScreenState();
}

class _FredReondScreenState extends State<FredReondScreen> {
  final String _secretPhrase = "Démons, veux-tu me répondre ? Démons, veux-tu me répondre ?                                                                                                                                                                                                                                                        ";
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  
  String _realText = "";
  bool _secretMode = false;
  String _displayMessage = "";
  
  @override
  void initState() {
    super.initState();
    _inputController.addListener(_handleInputChange);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _handleInputChange() {
    final text = _inputController.text;
    
    if (!_secretMode) {
      if (text == ".") {
        setState(() {
          _secretMode = true;
          _realText = "";
          _inputController.clear();
        });
      } else {
        _realText = text;
      }
    } else {
      if (text.isNotEmpty) {
        if (text.length > _realText.length) {
          _realText += text.substring(_realText.length);
        } else if (text.length < _realText.length) {
          _realText = _realText.substring(0, text.length);
        }
        
        _inputController.value = _inputController.value.copyWith(
          text: _secretPhrase.substring(0, text.length),
          selection: TextSelection.collapsed(offset: text.length),
        );
      } else {
        _realText = "";
      }
    }
  }

  void _submitForm() {
    FocusManager.instance.primaryFocus?.unfocus();
    
    setState(() {
      if (_secretMode) {
        _displayMessage = _realText;
      } else {
        _displayMessage = "Veuillez d'abord rejoindre ces membres.";
      }
    });
  }

  void _resetAll() {
    setState(() {
      _questionController.clear();
      _inputController.clear();
      _realText = "";
      _secretMode = false;
      _displayMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          'DEMONS REPOND',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3436),
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.refresh_rounded,
                  color: Color(0xFF6C5CE7),
                  size: 24,
                ),
              ),
              onPressed: _resetAll,
              tooltip: 'Réinitialiser',
              splashRadius: 20,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade300,
                  Colors.grey.shade100,
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Question Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _questionController,
                        decoration: InputDecoration(
                          hintText: 'Posez votre question ici...',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF6C5CE7),
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Message Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Message',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _inputController,
                        decoration: InputDecoration(
                          hintText: _secretMode 
                              ? 'Tapez votre message secret...' 
                              : 'Tapez votre message secret...',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF6C5CE7),
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          suffixIcon: _secretMode
                              ? const Icon(Icons.lock_outline, color: Color(0xFF6C5CE7))
                              : null,
                        ),
                        onSubmitted: (_) => _submitForm(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text(
                    'ENVOYER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Display Area
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _displayMessage.isNotEmpty
                    ? Card(
                        key: ValueKey<String>(_displayMessage),
                        color: _secretMode 
                            ? const Color(0xFFE6F0FF)
                            : const Color(0xFFFFF0F0),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                _secretMode ? Icons.check_circle : Icons.warning,
                                color: _secretMode 
                                    ? const Color(0xFF6C5CE7)
                                    : Colors.red,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _displayMessage,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _secretMode 
                                        ? const Color(0xFF6C5CE7)
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              
              const SizedBox(height: 24),
              
              // Reset Button
              TextButton(
                onPressed: _resetAll,
                child: const Text(
                  'Réinitialiser tout',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}