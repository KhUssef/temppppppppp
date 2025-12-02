import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/quote.dart';
import 'package:http/http.dart' as http;
import 'package:retrofit/retrofit.dart';


enum FetchMethod { http, dio, retrofit }

class QuoteScreen extends StatefulWidget {
  static const address = 'https://zenquotes.io/api';
  final FetchMethod method;
  const QuoteScreen({super.key, required this.method});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  List<Quote> _quotes = [];
  bool _isLoading = true;
  String? _errorMessage;
  late Dio dio;
  late QuoteService quoteService;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  void _loadQuotes() {
    switch (widget.method) {
      case FetchMethod.dio:
        _loadQuotesDio();
        break;
      case FetchMethod.http:
        _loadQuotesHttp();
        break;
      case FetchMethod.retrofit:
        _loadQuotesRetrofit();
        break;
    }
  }

  Future<void> _loadQuotesHttp() async {
    try {
      final quotes = await _fetchQuotesHttp();
      setState(() {
        _quotes = quotes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }
  void initDio() {
    dio = Dio(BaseOptions(
      baseUrl: QuoteScreen.address,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    //add interceptors
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        // Convert list of JSON to list of Quote objects
        final List<Quote> quotes = (response.data as List)
            .map((json) => Quote.fromJSON(json))
            .toList();
        response.data = quotes;
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if(e.response?.statusCode == 401) {
          final retryResponse = Response(
            requestOptions: e.requestOptions,
            statusCode: 200,
            data: [
              {'q': 'Default quote', 'a': 'Default author'},
            ],
          );
          return handler.resolve(retryResponse);
        }
        debugPrint('Dio error: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<void> _loadQuotesDio() async {
    initDio();
    try {
      final response = await dio.get('/quotes');
      setState(() {
        _quotes = response.data as List<Quote>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadQuotesRetrofit() async {
    try {
      final dio = Dio(BaseOptions(baseUrl: 'https://zenquotes.io/api'));
      quoteService = QuoteService(dio);
      final quotes = await quoteService.getQuotes();
      setState(() {
        _quotes = quotes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<List<Quote>> _fetchQuotesHttp() async {
    final Uri url = Uri.parse(QuoteScreen.address);
    final response = await http.get(Uri.parse('${url.toString()}/quotes'));
    if (response.statusCode == 200) {
      final List quotesJson = json.decode(response.body);
      List<Quote> quotes = quotesJson.map((json) => Quote.fromJSON(json)).toList();
      return quotes;
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  @override
  Widget build(BuildContext context) {
    String title;
    switch (widget.method) {
      case FetchMethod.http:
        title = 'Quotes (HTTP)';
        break;
      case FetchMethod.dio:
        title = 'Quotes (Dio)';
        break;
      case FetchMethod.retrofit:
        title = 'Quotes (Retrofit)';
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text('Error: $_errorMessage'));
    }

    if (_quotes.isEmpty) {
      return const Center(child: Text('No quotes available'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _quotes.length,
      separatorBuilder: (context, index) => const Divider(height: 32),
      itemBuilder: (context, index) {
        final quote = _quotes[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '"${quote.text}"',
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '- ${quote.author}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ],
        );
      },
    );
  }
}



@RestApi(baseUrl: "https://zenquotes.io/api")
abstract class QuoteService {
  factory QuoteService(Dio dio, {String? baseUrl}) = _QuoteService;

  @GET("/quotes")
  Future<List<Quote>> getQuotes();
}

class _QuoteService implements QuoteService {
  _QuoteService(this._dio, {String? baseUrl}) 
      : baseUrl = baseUrl ?? 'https://zenquotes.io/api';

  final Dio _dio;
  final String baseUrl;

  @override
  Future<List<Quote>> getQuotes() async {
    final response = await _dio.get<List<dynamic>>('$baseUrl/quotes');
    return (response.data as List)
        .map((json) => Quote.fromJSON(json as Map<String, dynamic>))
        .toList();
  }
}