import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

const APP_NAME = 'YK Partner';
const DEFAULT_LANGUAGE = 'en';

const primaryColor = Color.fromARGB(255, 241, 119, 32);
const DOMAIN_URL =
    'http://192.168.18.38:8000'; // Don't add slash at the end of the url https://yallakhedma.com
const BASE_URL = "$DOMAIN_URL/api/";
//http://192.168.18.38:8000

/// You can specify in Admin Panel, These will be used if you don't specify in Admin Panel
const IOS_LINK_FOR_PARTNER =
    "https://apps.apple.com/us/app/yk-partner/id6475168054";

const TERMS_CONDITION_URL = 'https://yallakhedma.com/term-conditions';
const PRIVACY_POLICY_URL = 'https://yallakhedma.com/privacy-policy';
const INQUIRY_SUPPORT_EMAIL = 'info@yallakhedma.com';
const GOOGLE_MAPS_API_KEY = 'AIzaSyC7e7Nkthx5ptF8q2xdcAiQuH-KhQpUkwM';
const STRIPE_MERCHANT_COUNTRY_CODE = 'AE';
DateTime todayDate = DateTime(2022, 8, 24);

/// SADAD PAYMENT DETAIL
const SADAD_API_URL = 'https://api-s.sadad.qa';
const SADAD_PAY_URL = "https://d.sadad.qa";

Country defaultCountry() {
  return Country(
    phoneCode: '971',
    countryCode: 'AE',
    e164Sc: 971,
    geographic: true,
    level: 1,
    name: 'U.A.W',
    example: '9123456789',
    displayName: 'U.A.E (AE) [+971]',
    displayNameNoCountryCode: 'U.A.E (AE)',
    e164Key: '971-AE-0',
    fullExampleWithPlusSign: '+971565002940',
  );
}
