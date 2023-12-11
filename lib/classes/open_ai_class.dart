import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:open_ai_app/env/env.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';


class OpenAIClass {

  OpenAIClass(){
    OpenAI.apiKey = Env.apiKey;
    OpenAI.requestsTimeOut = Duration(seconds: 60);
  }

  // Преобразование голоса в текст
  Future<String> fromVoiceToText(String voiceFilePath) async {
    // Здесь должен быть код для преобразования аудиофайла в текст
    return "Преобразованный текст";
  }

  // Преобразование текста в голос
  Future<String> fromTextToVoice(String text) async {
    File speechFile = await OpenAI.instance.audio.createSpeech(
      model: "tts-1",
      input: text,
      voice: "nova",
      responseFormat: OpenAIAudioSpeechResponseFormat.mp3,
      outputDirectory: await getTemporaryDirectory(),
      outputFileName: Uuid().v4(),
    );

    return speechFile.path;
  }

  // Редактирование текста
  Future<String> editText(String text) async {
    var response = await OpenAI.instance.completion.create(
      model: "text-davinci-003",
      prompt: "Improve this text: $text",
      maxTokens: 250,
    );
    return response.choices.first.text.trim();
  }

  Future<String> translateText(String text, String targetLanguage) async {
    var response = await OpenAI.instance.completion.create(
      model: "text-davinci-003",
      prompt: "Translate this text to $targetLanguage: $text",
      maxTokens: 250,
    );
    return response.choices.first.text.trim();
  }
}