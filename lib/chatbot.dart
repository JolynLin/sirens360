import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  String _selectedLanguage = 'English';
  bool _hasUserInteracted = false;

  // Mock responses for different languages
  final Map<String, Map<String, String>> _responses = {
    'English': {
      'hello': 'Hello! How can I help you today?',
      'how are you':
          'I\'m doing well, thank you for asking! How can I assist you?',
      'help':
          'I can help you with:\n- Medical information\n- Emergency guidance\n- Health tips\n- First aid advice',
      'emergency':
          'If this is a medical emergency, please call emergency services immediately.',
      'default':
          'I\'m here to help with medical and health-related questions. Could you please rephrase your question?',
    },
    'Bahasa Melayu': {
      'helo': 'Helo! Apa yang boleh saya bantu hari ini?',
      'apa khabar':
          'Saya sihat, terima kasih kerana bertanya! Apa yang boleh saya bantu?',
      'bantuan':
          'Saya boleh membantu anda dengan:\n- Maklumat perubatan\n- Panduan kecemasan\n- Petua kesihatan\n- Nasihat pertolongan cemas',
      'kecemasan':
          'Jika ini adalah kecemasan perubatan, sila hubungi perkhidmatan kecemasan dengan segera.',
      'default':
          'Saya di sini untuk membantu dengan soalan perubatan dan kesihatan. Bolehkah anda mengemukakan semula soalan anda?',
    },
    '中文': {
      '你好': '你好！今天我能帮你什么？',
      '你好吗': '我很好，谢谢关心！有什么我可以帮你的吗？',
      '帮助': '我可以帮你：\n- 医疗信息\n- 紧急指导\n- 健康提示\n- 急救建议',
      '紧急': '如果是医疗紧急情况，请立即拨打紧急服务电话。',
      'default': '我在这里帮助解答医疗和健康相关问题。您能重新表述您的问题吗？',
    },
  };

  // Mock prediction data
  final Map<String, double> _predictionData = {
    'Heart Rate': 75.0,
    'Blood Pressure': 120.0,
    'Oxygen Level': 98.0,
    'Temperature': 37.0,
  };

  // Mock chart data
  final List<FlSpot> _chartData = [
    FlSpot(0, 3),
    FlSpot(1, 1),
    FlSpot(2, 4),
    FlSpot(3, 2),
    FlSpot(4, 5),
  ];

  // Quick suggestions based on language
  final Map<String, Map<String, String>> _suggestions = {
    'English': {
      'How to check blood pressure?':
          'To check blood pressure:\n1. Sit quietly for 5 minutes\n2. Place the cuff on your upper arm\n3. Keep your arm at heart level\n4. Take the reading when the device stops',
      'First aid for burns':
          'For minor burns:\n1. Cool the burn under running water\n2. Remove jewelry near the burn\n3. Don\'t pop blisters\n4. Apply sterile bandage\nFor severe burns, seek immediate medical help.',
      'Symptoms of flu':
          'Common flu symptoms include:\n- Fever or chills\n- Cough\n- Sore throat\n- Runny nose\n- Body aches\n- Headaches\n- Fatigue',
      'Emergency contacts':
          'Emergency Numbers:\n- Ambulance: 999\n- Police: 999\n- Fire Department: 999\n- Poison Control: 999',
    },
    'Bahasa Melayu': {
      'Cara memeriksa tekanan darah?':
          'Cara memeriksa tekanan darah:\n1. Duduk diam selama 5 minit\n2. Letakkan manset pada lengan atas\n3. Pastikan lengan setinggi jantung\n4. Ambil bacaan apabila peranti berhenti',
      'Pertolongan cemas untuk luka bakar':
          'Untuk luka bakar ringan:\n1. Sejukkan luka di bawah air mengalir\n2. Tanggalkan barang kemas berdekatan\n3. Jangan pecahkan lepuh\n4. Balut dengan pembalut steril\nUntuk luka bakar teruk, dapatkan bantuan perubatan segera.',
      'Gejala selesema':
          'Gejala selesema biasa:\n- Demam atau menggigil\n- Batuk\n- Sakit tekak\n- Hidung berair\n- Sakit badan\n- Sakit kepala\n- Keletihan',
      'Nombor kecemasan':
          'Nombor Kecemasan:\n- Ambulans: 999\n- Polis: 999\n- Bomba: 999\n- Kawalan Racun: 999',
    },
    '中文': {
      '如何测量血压？': '测量血压的步骤：\n1. 静坐5分钟\n2. 将袖带放在上臂\n3. 保持手臂与心脏同高\n4. 等待设备停止后读取数值',
      '烧伤急救':
          '轻微烧伤处理：\n1. 用流动水冷却烧伤处\n2. 移除烧伤处附近的饰品\n3. 不要弄破水泡\n4. 使用无菌绷带包扎\n严重烧伤请立即就医。',
      '流感症状': '常见流感症状：\n- 发烧或发冷\n- 咳嗽\n- 喉咙痛\n- 流鼻涕\n- 身体疼痛\n- 头痛\n- 疲劳',
      '紧急联系方式': '紧急电话：\n- 救护车：999\n- 警察：999\n- 消防：999\n- 中毒控制：999',
    },
  };

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    // Set user interaction flag
    setState(() {
      _hasUserInteracted = true;
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    // Simulate bot thinking
    Future.delayed(const Duration(milliseconds: 500), () {
      _getBotResponse(text);
    });

    _textController.clear();
    _scrollToBottom();
  }

  void _getBotResponse(String userInput) {
    String response = _getResponseForLanguage(userInput.toLowerCase());

    setState(() {
      _messages.add(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });

    _scrollToBottom();
  }

  String _getResponseForLanguage(String input) {
    // Check if the input matches any suggestion
    final suggestions = _suggestions[_selectedLanguage]!;
    for (var entry in suggestions.entries) {
      if (input.toLowerCase() == entry.key.toLowerCase()) {
        return entry.value;
      }
    }

    // If no match found, use default responses
    final responses = _responses[_selectedLanguage]!;
    if (responses.containsKey(input)) {
      return responses[input]!;
    }

    for (var key in responses.keys) {
      if (input.contains(key)) {
        return responses[key]!;
      }
    }

    return responses['default']!;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Medical Assistant',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.language, color: Colors.grey[800]),
            onSelected: (String language) {
              setState(() {
                _selectedLanguage = language;
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'English',
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: 'Bahasa Melayu',
                child: Text('Bahasa Melayu'),
              ),
              const PopupMenuItem(
                value: '中文',
                child: Text('中文'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Only show these sections if user hasn't interacted yet
          if (!_hasUserInteracted) ...[
            // Health Metrics Section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Health Metrics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          // Add refresh functionality here
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _predictionData.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: _buildMetricCard(entry.key, entry.value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Chart Section
            Container(
              height: 150,
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Health Trends',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _chartData,
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Quick Suggestions
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Suggestions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children:
                        _suggestions[_selectedLanguage]!.keys.map((suggestion) {
                      return ActionChip(
                        label: Text(suggestion),
                        onPressed: () => _handleSubmitted(suggestion),
                        backgroundColor: Colors.blue.shade50,
                        labelStyle: TextStyle(color: Colors.blue.shade700),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
          // Chat Messages
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ),
          // Input Field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => _handleSubmitted(_textController.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, double value) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.medical_services, color: Colors.blue),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Colors.blue.shade400
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
