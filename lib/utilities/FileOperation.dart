import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// 此文件操作类只在 `应用所在文件夹下` 操作
class FileOperation {
  /// #### 缓冲
  /// 写数据时，先把数据填入该值，读数据时，从该值读数据。
  static String buffer;

  /// 将数据内容写入指定文件中
  static void writeFile(String folderName) async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;

    /// 创建名为 user 的文件夹。
    File file = new File('$documentsPath/$folderName');
    if (!file.existsSync()) {
      file.createSync();
    }

    await file.writeAsString(buffer);
  }

  static void readFile(String folderName) async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;

    File file = new File('$documentsPath/$folderName');
    if (!file.existsSync()) {
      return;
    }

    buffer = await file.readAsString();
  }

  static void saveJsonToFile(
      Map<String, dynamic> jsonData, String folderName) async {
    print(jsonData.toString());
  }
}

/**
  * #### 判断输入的文本是否有效，只针对TextFiled
  *
  * 返回 `true` ：有效的输入文本
  *
  * 返回 `false` ：无效的输入文本
  *
  * 判断依据：
  *
  *         str != null & str.isNotEmpty & str.trim() != ""
  *
  * str`不为空`、`有内容`、不全为 `空格` 或 `tab` 键
  */
bool isValidTextInput(String str) {
  if (str == null || str.isEmpty || str.trim() == "") return false;
  return true;
}
