import 'dart:io';

const ACCESS_KEY = 'ACCESS_TOKEN';
const REFRESH_ACCESS_KEY = 'REFRESH_ACCESS_TOKEN';
const STORAGE_USER_NO = 'NO';
const STORAGE_ID = 'ID';
const STORAGE_NICK = 'NICK';

const emulatorIp = 'http://10.0.2.2:4000/api';
const simulatorIp = 'http://127.0.0.1:4000/api';

final baseUrl = Platform.isIOS ? simulatorIp : emulatorIp;
